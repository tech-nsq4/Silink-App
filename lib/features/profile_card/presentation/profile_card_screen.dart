import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/helper_methods.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/creation_footer.dart';
import '../../../core/widgets/creation_header.dart';
import '../../../core/widgets/creation_toolbar.dart';
import '../../../core/widgets/public_profile/public_profile_data.dart';
import '../../../core/widgets/public_profile/public_profile_view.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../../profile_completion/data/models/catalog_model.dart';
import '../../profile_completion/presentation/widgets/profile_catalog_item_details.dart';
import '../data/models/profile_card_lead_request.dart';
import '../data/models/profile_card_model.dart';
import '../data/profile_card_contact_saver.dart';
import '../logic/profile_card_cubit.dart';
import 'widgets/profile_card_share_data_dialog.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({
    super.key,
    this.viewOnly = false,
    this.fromStudio = false,
  });

  final bool viewOnly;
  final bool fromStudio;

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  late final ProfileCardCubit _cubit = getIt<ProfileCardCubit>()..getMyCard();
  final GlobalKey _shareKey = GlobalKey();
  bool _isSharing = false;

  ProfileCardModel? get _card {
    final state = _cubit.state;
    return state is ProfileCardSuccess ? state.card : null;
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _launch(Future<void> Function() action) async {
    try {
      await action();
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _call() {
    final phone = _card?.basic.phone.trim() ?? '';
    if (phone.isEmpty) return;
    _launch(() => HelperMethods.openUri(Uri(scheme: 'tel', path: phone)));
  }

  void _email() {
    final email = _card?.basic.email.trim() ?? '';
    if (email.isEmpty) return;
    _launch(() => HelperMethods.openUri(Uri(scheme: 'mailto', path: email)));
  }

  void _openContact(PublicProfileContact contact) =>
      _launch(() => HelperMethods.openLink(contact.url));

  void _mainContact() {
    final whatsapp = _card?.whatsapp;
    if (whatsapp != null) {
      _launch(() => HelperMethods.openLink(whatsapp.url));
    } else if ((_card?.basic.phone.trim() ?? '').isNotEmpty) {
      _call();
    } else if ((_card?.basic.email.trim() ?? '').isNotEmpty) {
      _email();
    } else {
      _shareData();
    }
  }

  Future<void> _saveContact() async {
    final card = _card;
    if (card == null) return;
    try {
      final saved = await const ProfileCardContactSaver().save(card);
      if (saved) AppOverlay.showSuccess(LocaleKeys.publish_contactSaved.tr());
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _shareData() => ProfileCardShareDataDialog.show(
        context,
        ownerName: _card?.basic.fullName.trim() ?? '',
        onSubmit: _submitLead,
      );

  Future<bool> _submitLead(ProfileCardLeadRequest lead) async {
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
    return false;
  }

  void _openItem(PublicProfileItem item) {
    final product = _card?.products.where((p) => p.id == item.id).firstOrNull;
    if (product == null) return;
    openProfileCatalogItemDetails(
      context,
      CatalogItemModel(
        id: product.id,
        kind: product.kind,
        name: product.name,
        description: product.description,
        priceLabel: product.priceLabel,
        price: product.price,
        actionType: product.actionType,
        actionUrl: product.actionUrl,
        imageUrl: product.imageUrl,
      ),
      visible: product.isActive,
    );
  }

  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await WidgetsBinding.instance.endOfFrame;
      final boundary = _shareKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) throw StateError('card not ready');
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      if (bytes == null) throw StateError('failed to encode image');
      final name = _card?.basic.fullName.trim() ?? '';
      await Share.shareXFiles(
        [
          XFile.fromData(
            bytes.buffer.asUint8List(),
            name: 'silink-card.png',
            mimeType: 'image/png',
          ),
        ],
        text: name.isEmpty ? AppConstants.appName : name,
        fileNameOverrides: const ['silink-card.png'],
      );
    } catch (_) {
      if (mounted) {
        AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _editProfile() async {
    await Navigator.pushNamed(context, Routes.profileCompletionScreen);
    if (mounted) _cubit.getMyCard();
  }

  void _finish() => Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.layoutScreen,
        (_) => false,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCardCubit, ProfileCardState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          body: Column(
            children: [
              if (widget.viewOnly)
                SizedBox(height: MediaQuery.paddingOf(context).top)
              else ...[
                CreationHeader(
                  compact: true,
                  eyebrow: LocaleKeys.cardStudio_cardEyebrow.tr(),
                  title: LocaleKeys.cardStudio_cardTitle.tr(),
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                CreationToolbar(
                  hint: LocaleKeys.cardStudio_cardHint.tr(),
                  actionLabel: LocaleKeys.cardStudio_reviewEdit.tr(),
                  onAction: _editProfile,
                ),
              ],
              Expanded(
                child: CustomScreenStateLayout(
                  isLoading: state is ProfileCardInitial ||
                      state is ProfileCardLoading,
                  error: state is ProfileCardError
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: state.message,
                        )
                      : null,
                  onRetry: _cubit.getMyCard,
                  builder: (context) => PublicProfileView(
                    data: (state as ProfileCardSuccess).card.toPublicProfile(),
                    repaintKey: _shareKey,
                    actions: PublicProfileActions(
                      onShare: _share,
                      onClose: widget.viewOnly
                          ? () => Navigator.of(context).maybePop()
                          : null,
                      onCall: _call,
                      onEmail: _email,
                      onSaveContact: _saveContact,
                      onShareData: _shareData,
                      onOpenContact: _openContact,
                      onItemTap: _openItem,
                      onMainContact: _mainContact,
                    ),
                  ),
                ),
              ),
              if (widget.fromStudio)
                CreationFooter(
                  title: LocaleKeys.cardStudio_cardCta.tr(),
                  note: LocaleKeys.cardStudio_cardNote.tr(),
                  onTap: _finish,
                ),
            ],
          ),
        );
      },
    );
  }
}
