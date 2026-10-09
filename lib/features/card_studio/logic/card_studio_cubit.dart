import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../auth/data/models/registration_ticket.dart';
import '../../auth/data/models/user_model.dart';
import '../data/card_studio_repo.dart';
import '../data/models/studio_design_options.dart';
import '../data/models/studio_draft.dart';
import '../data/models/studio_item.dart';

part 'card_studio_state.dart';

class CardStudioCubit extends Cubit<CardStudioState> {
  CardStudioCubit(this._repo) : super(const CardStudioInitial());

  static const int identityStep = 0;
  static const int verifyStep = 1;
  static const int contactStep = 2;
  static const int contentStep = 3;
  static const int designStep = 4;
  static const int lastStep = designStep;
  static const int minPasswordLength = 6;
  static const int otpLength = 6;
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final RegExp _phonePattern = RegExp(r'^\+?[\d\s-]{7,16}$');

  final CardStudioRepo _repo;

  String _message(Object e) => e is NetworkException ? e.message : e.toString();

  CardStudioSuccess? get _ready {
    final current = state;
    return current is CardStudioSuccess ? current : null;
  }

  void startLocal({StudioDraft? initial}) => emit(
        CardStudioSuccess(
          draft: initial ?? StudioDraft.empty(),
          step: identityStep,
          isRemote: false,
        ),
      );

  Future<void> startRemote({bool resume = false}) async {
    emit(const CardStudioLoading());
    try {
      final draft = await _repo.loadRemote();
      emit(CardStudioSuccess(
        draft: draft,
        step: resume ? contactStep : identityStep,
        minStep: resume ? contactStep : identityStep,
        isRemote: true,
      ));
    } catch (e) {
      final msg = _message(e);
      AppOverlay.showError(msg);
      emit(CardStudioError(msg));
    }
  }

  void update(StudioDraft draft) =>
      _ready.let((s) => emit(s.copyWith(draft: draft, clearError: true)));

  bool _isReachable(CardStudioSuccess current, int step) =>
      step >= current.minStep &&
      step <= lastStep &&
      !(current.isRemote && step == verifyStep);

  void goTo(int step) {
    final current = _ready;
    if (current == null || !_isReachable(current, step)) return;
    emit(current.copyWith(step: step, clearError: true));
    if (step == designStep) _ensureDesignOptions();
  }

  Future<void> _ensureDesignOptions() async {
    final current = _ready;
    if (current == null || !current.isRemote || current.designOptions != null) {
      return;
    }
    try {
      final options = await _repo.loadDesignOptions();
      final latest = _ready!;
      final appearance = options.appearance;
      emit(latest.copyWith(
        designOptions: options,
        draft: latest.draft.copyWith(
          template: options.selectedTemplateSlug,
          primaryColor: appearance.primaryColor,
          background: appearance.background,
          buttonShape: appearance.buttonShape,
          fontFamily: options.selectedFontFamily,
        ),
      ));
    } catch (e) {
      AppOverlay.showError(_message(e));
    }
  }

  static const Duration _designSaveDelay = Duration(milliseconds: 600);

  Timer? _templateSave;
  Timer? _appearanceSave;

  void selectTemplate(String slug) {
    final current = _ready;
    if (current == null || current.draft.template == slug) return;
    emit(current.copyWith(draft: current.draft.copyWith(template: slug)));
    if (!current.isRemote || current.designOptions == null) return;
    _templateSave?.cancel();
    _templateSave = Timer(_designSaveDelay, _saveTemplate);
  }

  void updateAppearance(StudioDraft draft) {
    final current = _ready;
    if (current == null) return;
    emit(current.copyWith(draft: draft, clearError: true));
    if (!current.isRemote || current.designOptions == null) return;
    _appearanceSave?.cancel();
    _appearanceSave = Timer(_designSaveDelay, _saveAppearance);
  }

  Future<void> _saveTemplate({bool strict = false}) async {
    _templateSave = null;
    final current = _ready;
    final options = current?.designOptions;
    if (current == null || options == null) return;
    final slug = current.draft.template;
    if (options.selectedTemplateSlug == slug) return;
    try {
      final templates = await _repo.saveTemplate(options, slug);
      final latest = _ready;
      if (templates != null && latest != null) {
        emit(latest.copyWith(
          designOptions: latest.designOptions?.copyWith(templates: templates),
        ));
      }
    } catch (e) {
      final latest = _ready;
      final saved = latest?.designOptions?.selectedTemplateSlug;
      if (latest != null && saved != null && latest.draft.template == slug) {
        emit(latest.copyWith(draft: latest.draft.copyWith(template: saved)));
      }
      if (strict) rethrow;
      AppOverlay.showError(_message(e));
    }
  }

  Future<void> _saveAppearance({bool strict = false}) async {
    _appearanceSave = null;
    final current = _ready;
    final options = current?.designOptions;
    if (current == null || options == null) return;
    final draft = current.draft;
    final saved = options.appearance;
    final unchanged = saved.primaryColor == draft.primaryColor &&
        saved.background == draft.background &&
        saved.buttonShape == draft.buttonShape &&
        options.selectedFontFamily == draft.fontFamily;
    if (unchanged) return;
    try {
      final appearance = await _repo.saveAppearance(options, draft);
      final latest = _ready;
      if (latest == null) return;
      emit(latest.copyWith(
        designOptions: latest.designOptions?.copyWith(appearance: appearance),
      ));
    } catch (e) {
      final latest = _ready;
      if (latest != null) {
        emit(latest.copyWith(
          draft: latest.draft.copyWith(
            primaryColor: saved.primaryColor,
            background: saved.background,
            buttonShape: saved.buttonShape,
            fontFamily: options.selectedFontFamily,
          ),
        ));
      }
      if (strict) rethrow;
      AppOverlay.showError(_message(e));
    }
  }

  Future<void> _flushDesignSaves() async {
    _templateSave?.cancel();
    _appearanceSave?.cancel();
    await _saveTemplate(strict: true);
    await _saveAppearance(strict: true);
  }

  @override
  Future<void> close() {
    _templateSave?.cancel();
    _appearanceSave?.cancel();
    return super.close();
  }

  bool back() {
    final current = _ready;
    if (current == null) return false;
    var target = current.step - 1;
    if (current.isRemote && target == verifyStep) target = identityStep;
    if (!_isReachable(current, target)) return false;
    emit(current.copyWith(step: target, clearError: true));
    return true;
  }

  String? _validateIdentity(CardStudioSuccess current) {
    final draft = current.draft;
    final email = draft.email.trim();
    final phone = draft.phone.trim();
    if (draft.name.trim().isEmpty || draft.title.trim().isEmpty) {
      return LocaleKeys.cardStudio_errorIdentity.tr();
    }
    if (phone.isEmpty) return LocaleKeys.cardStudio_errorPhoneRequired.tr();
    if (!_phonePattern.hasMatch(phone)) {
      return LocaleKeys.cardStudio_errorPhone.tr();
    }
    if (email.isNotEmpty && !_emailPattern.hasMatch(email)) {
      return LocaleKeys.cardStudio_errorEmail.tr();
    }
    if (!current.isRemote && draft.password.length < minPasswordLength) {
      return LocaleKeys.cardStudio_errorPassword.tr();
    }
    return null;
  }

  bool get needsAccount {
    final current = _ready;
    return current != null && !current.isRemote && current.step == identityStep;
  }

  bool get needsVerification {
    final current = _ready;
    return current != null && !current.isRemote && current.step == verifyStep;
  }

  Future<void> register() async {
    final current = _ready;
    if (current == null || current.saving) return;
    final error = _validateIdentity(current);
    if (error != null) {
      emit(current.copyWith(error: error));
      return;
    }
    emit(current.copyWith(saving: true, clearError: true));
    try {
      final ticket = await _repo.register(current.draft);
      emit(_ready!.copyWith(
        saving: false,
        ticket: ticket,
        step: verifyStep,
        minStep: verifyStep,
      ));
    } catch (e) {
      final msg = _message(e);
      AppOverlay.showError(msg);
      emit(_ready!.copyWith(saving: false, error: msg));
    }
  }

  Future<UserModel?> verify(String code) async {
    final current = _ready;
    final ticket = current?.ticket;
    if (current == null || ticket == null || current.saving) return null;
    if (code.length < otpLength) {
      emit(current.copyWith(error: LocaleKeys.otp_enterFullCode.tr()));
      return null;
    }
    emit(current.copyWith(saving: true, clearError: true));
    try {
      final user = await _repo.verifyOtp(
        registrationId: ticket.registrationId,
        code: code,
      );
      emit(_ready!.copyWith(
        saving: false,
        isRemote: true,
        step: contactStep,
        minStep: contactStep,
        clearTicket: true,
        draft: _ready!.draft.copyWith(password: ''),
      ));
      return user;
    } catch (e) {
      final msg = _message(e);
      AppOverlay.showError(msg);
      emit(_ready!.copyWith(saving: false, error: msg));
      return null;
    }
  }

  Future<void> _saveStep(CardStudioSuccess current) async {
    final draft = current.draft;
    switch (current.step) {
      case identityStep:
        await _repo.saveProfile(draft);
      case contactStep:
        await _repo.saveContacts(draft);
      case contentStep:
        final items = await _repo.uploadPendingItems(draft.items);
        emit(_ready!.copyWith(draft: _ready!.draft.copyWith(items: items)));
        await _repo.saveCatalogSettings(draft);
      default:
        await _repo.saveCatalogSettings(draft);
        if (current.designOptions == null) {
          await _repo.saveDesign(draft);
        } else {
          await _flushDesignSaves();
          await _repo.saveArrangement(_ready!.draft);
        }
        await _repo.clearPending();
    }
  }

  int _nextStep(CardStudioSuccess current) {
    final next = current.step + 1;
    return current.isRemote && next == verifyStep ? contactStep : next;
  }

  int? get nextStep => _ready.letValue(_nextStep);

  Future<StudioNextResult> next() async {
    final current = _ready;
    if (current == null || current.saving) return StudioNextResult.blocked;
    if (current.step == identityStep) {
      final error = _validateIdentity(current);
      if (error != null) {
        emit(current.copyWith(error: error));
        return StudioNextResult.blocked;
      }
    }
    if (current.isRemote) {
      emit(current.copyWith(saving: true, clearError: true));
      try {
        await _saveStep(current);
      } catch (e) {
        final msg = _message(e);
        AppOverlay.showError(msg);
        emit(_ready!.copyWith(saving: false, error: msg));
        return StudioNextResult.blocked;
      }
    }
    final latest = _ready!;
    if (latest.step == lastStep) {
      emit(latest.copyWith(saving: false, clearError: true));
      return StudioNextResult.finished;
    }
    final nextStep = _nextStep(latest);
    emit(latest.copyWith(step: nextStep, saving: false, clearError: true));
    if (nextStep == designStep) _ensureDesignOptions();
    return StudioNextResult.moved;
  }

  Future<void> toggleCatalog(
      {required bool services, required bool enabled}) async {
    final current = _ready;
    if (current == null) return;
    final previous = current.draft;
    final draft = services
        ? previous.copyWith(servicesEnabled: enabled)
        : previous.copyWith(productsEnabled: enabled);
    emit(current.copyWith(draft: draft, clearError: true));
    if (!current.isRemote) return;
    try {
      await _repo.saveCatalogSettings(draft);
    } catch (e) {
      AppOverlay.showError(_message(e));
      _ready.let((s) => emit(s.copyWith(
            draft: services
                ? s.draft.copyWith(servicesEnabled: previous.servicesEnabled)
                : s.draft.copyWith(productsEnabled: previous.productsEnabled),
          )));
    }
  }

  void _setItems(List<StudioItem> items) => _ready.let(
        (s) => emit(s.copyWith(
          draft: s.draft.copyWith(items: items).withCatalogSections(),
          clearError: true,
        )),
      );

  Future<void> addItem(StudioItem item) async {
    final current = _ready;
    if (current == null) return;
    final kindEnabled = item.isService
        ? current.draft.servicesEnabled
        : current.draft.productsEnabled;
    if (!kindEnabled) {
      await toggleCatalog(services: item.isService, enabled: true);
    }
    _setItems([..._ready!.draft.items, item]);
    if (!current.isRemote) return;
    emit(_ready!.copyWith(busyItemId: item.localId));
    try {
      final remoteId = await _repo.addItem(item);
      final items = [
        for (final i in _ready!.draft.items)
          i.localId == item.localId ? i.copyWith(remoteId: remoteId) : i,
      ];
      _setItems(items);
      emit(_ready!.copyWith(clearBusyItem: true));
    } catch (e) {
      AppOverlay.showError(_message(e));
      _setItems(
          _ready!.draft.items.where((i) => i.localId != item.localId).toList());
      emit(_ready!.copyWith(clearBusyItem: true));
    }
  }

  Future<void> updateItem(StudioItem item) async {
    final current = _ready;
    if (current == null) return;
    final previous =
        current.draft.items.firstWhere((i) => i.localId == item.localId);
    _setItems([
      for (final i in current.draft.items) i.localId == item.localId ? item : i,
    ]);
    if (!current.isRemote) return;
    emit(_ready!.copyWith(busyItemId: item.localId));
    try {
      await _repo.updateItem(item);
    } catch (e) {
      AppOverlay.showError(_message(e));
      _setItems([
        for (final i in _ready!.draft.items)
          i.localId == item.localId ? previous : i,
      ]);
    }
    emit(_ready!.copyWith(clearBusyItem: true));
  }

  Future<void> removeItem(StudioItem item) async {
    final current = _ready;
    if (current == null) return;
    final before = current.draft.items;
    _setItems(before.where((i) => i.localId != item.localId).toList());
    if (!current.isRemote) return;
    try {
      await _repo.deleteItem(item);
    } catch (e) {
      AppOverlay.showError(_message(e));
      _setItems(before);
    }
  }

  void reorderItems(int oldIndex, int newIndex) {
    final current = _ready;
    if (current == null) return;
    final items = [...current.draft.items];
    final moved = items.removeAt(oldIndex);
    items.insert(newIndex, moved);
    _setItems(items);
  }

  void reorderSections(int oldIndex, int newIndex) {
    final current = _ready;
    if (current == null) return;
    final sections = [...current.draft.sections];
    final moved = sections.removeAt(oldIndex);
    sections.insert(newIndex, moved);
    update(current.draft.copyWith(sections: sections));
  }
}

extension _NullableLet<T extends Object> on T? {
  void let(void Function(T value) action) {
    final value = this;
    if (value != null) action(value);
  }

  R? letValue<R>(R Function(T value) transform) {
    final value = this;
    return value == null ? null : transform(value);
  }
}
