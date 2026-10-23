import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/network_exceptions.dart';
import '../../auth/data/models/registration_ticket.dart';
import '../../card_studio/data/card_studio_repo.dart';
import '../../card_studio/data/models/studio_design_options.dart';
import '../../card_studio/data/models/studio_draft.dart';
import '../../profile_card/data/profile_card_repo.dart';
import '../../profile_completion/data/models/appearance_model.dart';
import '../../profile_completion/data/models/template_model.dart';
import '../../profile_completion/data/profile_completion_repo.dart';

class PortfolioStudioRepo extends CardStudioRepo {
  PortfolioStudioRepo({
    required super.dio,
    required super.authRepo,
    required super.storage,
    required super.completionRepo,
    required super.cardRepo,
    String? portfolioId,
  })  : _accountCompletion = completionRepo,
        _portfolioId = portfolioId;

  static const String _businessProfile = 'business';
  static const String _freelanceProfile = 'freelance';

  final ProfileCompletionRepo _accountCompletion;
  String? _portfolioId;
  ProfileCompletionRepo? _scopedCompletion;
  ProfileCardRepo? _scopedCard;

  String? get portfolioId => _portfolioId;

  String get _scope => ApiEndpoints.mePortfolio(_portfolioId ?? '');

  @override
  bool get requiresVerification => false;

  @override
  ProfileCompletionRepo get completion =>
      _scopedCompletion ??= ProfileCompletionRepo(dio: dio, scope: _scope);

  @override
  ProfileCardRepo get cardRepo =>
      _scopedCard ??= ProfileCardRepo(dio: dio, scope: _scope);

  Future<FormData> _form(StudioDraft draft) async {
    final photo = draft.photoFile;
    return FormData.fromMap({
      'profileType': draft.company.trim().isNotEmpty
          ? _businessProfile
          : _freelanceProfile,
      'fullName': draft.name.trim(),
      'jobTitle': draft.title.trim(),
      'company': draft.company.trim(),
      'bio': draft.bio.trim(),
      'address': draft.location.trim(),
      if (draft.lat != null) 'lat': draft.lat,
      if (draft.lng != null) 'lng': draft.lng,
      'phone': draft.phone.trim(),
      'email': draft.email.trim(),
      if (photo != null)
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: photo.path.split('/').last,
        ),
    });
  }

  @override
  Future<RegistrationTicket?> register(StudioDraft draft) async {
    try {
      final response =
          await dio.postForm(ApiEndpoints.mePortfolios, await _form(draft));
      final data = response.data['data'];
      _portfolioId =
          data is Map<String, dynamic> ? data['id']?.toString() : null;
      _scopedCompletion = null;
      _scopedCard = null;
      return null;
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  @override
  Future<void> saveProfile(StudioDraft draft) async {
    try {
      await dio.postForm(
        ApiEndpoints.mePortfolio(_portfolioId ?? ''),
        await _form(draft),
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  @override
  Future<void> clearPending() async {}

  @override
  Future<StudioDraft> loadRemote() async {
    final draft = await super.loadRemote();
    final card = await cardRepo.getMyCard();
    final font = card.appearance.fontFamily;
    return StudioDraft.fonts.contains(font)
        ? draft.copyWith(fontFamily: font)
        : draft;
  }

  @override
  Future<StudioDesignOptions> loadDesignOptions() async {
    final results = await Future.wait([
      completion.getTemplates(),
      completion.getAppearance(),
      _accountCompletion.getAppearance(),
    ]);
    final selected = results[1] as AppearanceModel;
    final catalog = results[2] as AppearanceModel;
    return StudioDesignOptions(
      templates: results[0] as TemplateSettings,
      appearance: catalog.copyWith(
        primaryColor: selected.primaryColor,
        coverColor: selected.coverColor,
        background: selected.background,
        buttonShape: selected.buttonShape,
        fontId: selected.fontId,
      ),
    );
  }
}
