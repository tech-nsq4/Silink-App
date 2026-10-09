import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import '../../auth/data/auth_repo.dart';
import '../../auth/data/models/registration_ticket.dart';
import '../../auth/data/models/user_model.dart';
import '../../../core/storage/local_storage.dart';
import '../../profile_card/data/models/profile_card_model.dart';
import '../../profile_card/data/profile_card_repo.dart';
import '../../profile_completion/data/models/appearance_model.dart';
import '../../profile_completion/data/models/arrangement_section_model.dart';
import '../../profile_completion/data/models/catalog_model.dart';
import '../../profile_completion/data/models/channel_model.dart';
import '../../profile_completion/data/models/link_model.dart';
import '../../profile_completion/data/models/template_model.dart';
import '../../profile_completion/data/profile_completion_repo.dart';
import 'models/studio_contact.dart';
import 'models/studio_design_options.dart';
import 'models/studio_draft.dart';
import 'models/studio_item.dart';
import 'models/studio_section.dart';

class CardStudioRepo {
  CardStudioRepo({
    required DioClient dio,
    required AuthRepo authRepo,
    required LocalStorage storage,
    required ProfileCompletionRepo completionRepo,
    required ProfileCardRepo cardRepo,
  })  : _dio = dio,
        _auth = authRepo,
        _storage = storage,
        _completion = completionRepo,
        _card = cardRepo;

  static const String _lockedSection = 'basic';
  static const String _personalUsageIntent = 'personal';
  static const String _businessProfile = 'business';
  static const String _freelancerProfile = 'freelancer';
  static const String _quickContactSection = 'quick_contact';

  final DioClient _dio;
  final AuthRepo _auth;
  final LocalStorage _storage;
  final ProfileCompletionRepo _completion;
  final ProfileCardRepo _card;

  Future<StudioDraft> loadRemote() async {
    final results = await Future.wait([
      _card.getMyCard(),
      _completion.getChannels(),
      _completion.getLinks(),
      _completion.getCatalog(),
      _completion.getArrangement(),
      _completion.getTemplates(),
      _completion.getAppearance(),
    ]);
    final card = results[0] as ProfileCardModel;
    final channels = results[1] as List<ChannelModel>;
    final links = results[2] as List<LinkModel>;
    final catalog = results[3] as CatalogModel;
    final arrangement = results[4] as List<ArrangementSectionModel>;
    final templates = results[5] as TemplateSettings;
    final appearance = results[6] as AppearanceModel;

    final selectedTemplate = templates.templates
        .where((t) => t.id == templates.selectedId)
        .map((t) => t.slug)
        .firstOrNull;
    final selectedFont = appearance.fonts
        .where((f) => f.id == appearance.fontId)
        .map((f) => f.family)
        .firstOrNull;
    final studioTypes = StudioSection.defaults.map((s) => s.type).toSet();
    final sections = [
      for (final section in arrangement)
        if (studioTypes.contains(section.type))
          StudioSection(type: section.type, visible: section.visible),
    ];
    for (final fallback in StudioSection.defaults) {
      if (!sections.any((s) => s.type == fallback.type)) sections.add(fallback);
    }

    return StudioDraft(
      name: card.basic.fullName,
      title: card.basic.jobTitle,
      company: card.basic.company,
      bio: card.bio,
      phone: card.basic.phone,
      email: card.basic.email,
      location: card.basic.address,
      photoUrl: card.basic.photoUrl,
      channels: _contacts(
        StudioContact.channelTypes,
        {for (final c in channels) c.type: (c.value, c.visible)},
      ),
      links: _contacts(
        StudioContact.linkTypes,
        {for (final l in links) l.type: (l.value, l.visible)},
      ),
      items: [
        for (final item in catalog.items)
          StudioItem(
            localId: item.id,
            remoteId: item.id,
            kind: item.kind,
            name: item.name,
            description: item.description,
            price: item.price,
            priceLabel: item.priceLabel,
            actionType: item.actionType.isEmpty
                ? StudioItem.defaultActionType
                : item.actionType,
            actionUrl: item.actionUrl,
            imageUrl: item.imageUrl,
          ),
      ],
      servicesEnabled: catalog.servicesEnabled,
      productsEnabled: catalog.productsEnabled,
      template: StudioDraft.templates.contains(selectedTemplate)
          ? selectedTemplate!
          : 'pro',
      primaryColor: appearance.primaryColor,
      background: appearance.background,
      buttonShape: appearance.buttonShape,
      fontFamily:
          StudioDraft.fonts.contains(selectedFont) ? selectedFont! : 'Tajawal',
      sections: sections,
    );
  }

  List<StudioContact> _contacts(
    List<String> types,
    Map<String, (String, bool)> values,
  ) =>
      [
        for (final type in types)
          StudioContact(
            type: type,
            value: values[type]?.$1 ?? '',
            visible: values[type]?.$2 ?? false,
          ),
      ];

  Future<RegistrationTicket> register(StudioDraft draft) {
    final hasCompany = draft.company.trim().isNotEmpty;
    return _auth.registerPersonal(
      usageIntent: _personalUsageIntent,
      profileType: hasCompany ? _businessProfile : _freelancerProfile,
      fullName: draft.name.trim(),
      jobTitle: draft.title.trim(),
      company: draft.company.trim(),
      bio: draft.bio.trim(),
      address: draft.location.trim(),
      lat: draft.lat,
      lng: draft.lng,
      phone: draft.phone.trim(),
      email: draft.email.trim(),
      password: draft.password,
      photo: draft.photoFile,
    );
  }

  Future<UserModel> verifyOtp({
    required String registrationId,
    required String code,
  }) async {
    final user =
        await _auth.verifyOtp(registrationId: registrationId, code: code);
    await _storage.setStudioPending(true);
    return user;
  }

  Future<void> clearPending() => _storage.setStudioPending(false);

  Future<void> saveProfile(StudioDraft draft) async {
    try {
      await _dio.postForm(
        ApiEndpoints.profile,
        FormData.fromMap({
          'name': draft.name.trim(),
          'phone': draft.phone.trim(),
          if (draft.email.trim().isNotEmpty) 'email': draft.email.trim(),
          'jobTitle': draft.title.trim(),
          'company': draft.company.trim(),
          'bio': draft.bio.trim(),
          'address': draft.location.trim(),
          if (draft.lat != null) 'lat': draft.lat,
          if (draft.lng != null) 'lng': draft.lng,
          if (draft.photoFile != null)
            'image': await MultipartFile.fromFile(
              draft.photoFile!.path,
              filename: draft.photoFile!.path.split('/').last,
            ),
        }),
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> saveContacts(StudioDraft draft) async {
    await _completion.saveChannels([
      for (final channel in draft.channels) _channelModel(channel),
    ]);
    await _completion.saveLinks([
      for (final link in draft.links) _linkModel(link),
    ]);
  }

  ChannelModel _channelModel(StudioContact contact) => ChannelModel(
        type: contact.type,
        label: '',
        value: contact.value.trim(),
        visible: contact.visible,
        placeholder: '',
      );

  LinkModel _linkModel(StudioContact contact) => LinkModel(
        type: contact.type,
        label: '',
        value: contact.value.trim(),
        visible: contact.visible,
        placeholder: '',
      );

  Future<String?> addItem(StudioItem item) async {
    final before = await _completion.getCatalog();
    final knownIds = before.items.map((i) => i.id).toSet();
    final catalog = await _completion.addCatalogItem(
      kind: item.kind,
      name: item.name.trim(),
      description: item.description.trim(),
      priceLabel: item.priceLabel.trim(),
      price: item.price.trim(),
      actionType: item.actionType,
      actionUrl: item.actionUrl.trim(),
      image: item.imageFile,
    );
    final added = catalog.items.where((i) => !knownIds.contains(i.id));
    return added.isEmpty ? null : added.last.id;
  }

  Future<void> updateItem(StudioItem item) async {
    final id = item.remoteId;
    if (id == null) return;
    await _completion.updateCatalogItem(
      id: id,
      kind: item.kind,
      name: item.name.trim(),
      description: item.description.trim(),
      priceLabel: item.priceLabel.trim(),
      price: item.price.trim(),
      actionType: item.actionType,
      actionUrl: item.actionUrl.trim(),
      image: item.imageFile,
    );
  }

  Future<void> deleteItem(StudioItem item) async {
    final id = item.remoteId;
    if (id == null) return;
    await _completion.deleteCatalogItem(id: id, kind: item.kind);
  }

  Future<void> saveCatalogSettings(StudioDraft draft) async {
    await _completion.saveCatalogSettings(
      productsEnabled: draft.productsEnabled,
      servicesEnabled: draft.servicesEnabled,
    );
  }

  Future<StudioDesignOptions> loadDesignOptions() async {
    final results = await Future.wait([
      _completion.getTemplates(),
      _completion.getAppearance(),
    ]);
    return StudioDesignOptions(
      templates: results[0] as TemplateSettings,
      appearance: results[1] as AppearanceModel,
    );
  }

  Future<TemplateSettings?> saveTemplate(
    StudioDesignOptions options,
    String slug,
  ) async {
    final template = options.templateBySlug(slug);
    if (template == null) return null;
    return _completion.saveTemplate(template.id);
  }

  Future<AppearanceModel> saveAppearance(
    StudioDesignOptions options,
    StudioDraft draft,
  ) =>
      _completion.saveAppearance(
        options.appearance.copyWith(
          primaryColor: draft.primaryColor,
          coverColor: draft.primaryColor,
          background: draft.background,
          buttonShape: draft.buttonShape,
          fontId: options.fontByFamily(draft.fontFamily)?.id,
        ),
      );

  Future<void> saveDesign(StudioDraft draft) async {
    final templates = await _completion.getTemplates();
    final template =
        templates.templates.where((t) => t.slug == draft.template).firstOrNull;
    if (template != null && template.id != templates.selectedId) {
      await _completion.saveTemplate(template.id);
    }

    final appearance = await _completion.getAppearance();
    final font = appearance.fonts
        .where((f) => f.family.toLowerCase() == draft.fontFamily.toLowerCase())
        .firstOrNull;
    await _completion.saveAppearance(
      appearance.copyWith(
        primaryColor: draft.primaryColor,
        coverColor: draft.primaryColor,
        background: draft.background,
        buttonShape: draft.buttonShape,
        fontId: font?.id,
      ),
    );

    await saveArrangement(draft);
  }

  Future<void> saveArrangement(StudioDraft draft) async {
    final current = await _completion.getArrangement();
    final quickContact =
        current.where((s) => s.type == _quickContactSection).firstOrNull;
    await _completion.saveArrangement([
      const ArrangementSectionModel(
        type: _lockedSection,
        label: '',
        visible: true,
        locked: true,
        sortOrder: 0,
      ),
      for (final section in draft.sections)
        ArrangementSectionModel(
          type: section.type,
          label: '',
          visible: section.visible,
          locked: false,
          sortOrder: 0,
        ),
      ArrangementSectionModel(
        type: _quickContactSection,
        label: '',
        visible: quickContact?.visible ?? false,
        locked: false,
        sortOrder: 0,
      ),
    ]);
  }

  Future<List<StudioItem>> uploadPendingItems(List<StudioItem> items) async {
    final uploaded = <StudioItem>[];
    for (final item in items) {
      if (item.remoteId != null) {
        uploaded.add(item);
        continue;
      }
      final remoteId = await addItem(item);
      uploaded.add(item.copyWith(remoteId: remoteId));
    }
    return uploaded;
  }
}
