import 'dart:ui' as ui;

import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/helper_methods.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_contact_item.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_lead_request.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_model.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_product.dart';
import 'package:Silink/features/profile_card/data/profile_card_contact_saver.dart';
import 'package:Silink/features/profile_card/logic/profile_card_cubit.dart';
import 'package:Silink/features/profile_completion/data/models/catalog_model.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/profile_catalog_item_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import 'widgets/profile_card_all_items_sheet.dart';
import 'widgets/profile_card_body.dart';
import 'widgets/profile_card_exit_preview_button.dart';
import 'widgets/profile_card_footer.dart';
import 'widgets/profile_card_share_data_dialog.dart';
import 'widgets/profile_card_toolbar.dart';
import 'widgets/profile_card_visitor_banner.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  static const String viewAllProductsResult = 'view_all_products';

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  late final ProfileCardCubit _cubit = getIt<ProfileCardCubit>()..getMyCard();
  final GlobalKey _shareCardKey = GlobalKey();
  bool _isSharing = false;
  bool _isVisitorMode = false;

  ProfileCardModel? get _card {
    final state = _cubit.state;
    return state is ProfileCardSuccess ? state.card : null;
  }

  String get _profileLink {
    final name = _card?.basic.fullName.trim() ?? '';
    final handle = name.isEmpty ? 'demo-profile' : name.replaceAll(' ', '-');
    return 'silink.sa/$handle';
  }

  Future<void> _launch(Future<void> Function() action) async {
    try {
      await action();
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _handleCall() {
    final phone = _card?.basic.phone.trim() ?? '';
    if (phone.isEmpty) return;
    _launch(() => HelperMethods.openUri(Uri(scheme: 'tel', path: phone)));
  }

  void _handleEmail() {
    final email = _card?.basic.email.trim() ?? '';
    if (email.isEmpty) return;
    _launch(() => HelperMethods.openUri(Uri(scheme: 'mailto', path: email)));
  }

  void _handleWhatsapp() {
    final whatsapp = _card?.whatsapp;
    if (whatsapp == null) return;
    _handleOpenContact(whatsapp);
  }

  void _handleOpenContact(ProfileCardContactItem item) {
    _launch(() => HelperMethods.openLink(item.url));
  }

  Future<void> _handleSaveContact() async {
    final card = _card;
    if (card == null) return;
    try {
      final saved = await const ProfileCardContactSaver().save(card);
      if (saved) AppOverlay.showSuccess(LocaleKeys.publish_contactSaved.tr());
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _handleShareData() {
    ProfileCardShareDataDialog.show(
      context,
      ownerName: _card?.basic.fullName.trim() ?? '',
      onSubmit: _handleSubmitLead,
    );
  }

  Future<bool> _handleSubmitLead(ProfileCardLeadRequest lead) async {
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
    return false;
  }

  void _handleViewAsVisitor() {
    if (_card == null) return;
    setState(() => _isVisitorMode = true);
  }

  void _handleExitVisitorMode() {
    setState(() => _isVisitorMode = false);
  }

  void _handleCopyLink() {
    Clipboard.setData(ClipboardData(text: _profileLink));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  void _handleSaveAndPublish() {
    context.pushNamedAndRemoveUntil(
      Routes.layoutScreen,
      predicate: (_) => false,
    );
  }

  void _handleViewAllProducts() {
    final card = _card;
    if (card == null) return;
    if (!_isVisitorMode) {
      Navigator.of(context).pop(ProfileCardScreen.viewAllProductsResult);
      return;
    }
    ProfileCardAllItemsSheet.show(
      context,
      items: card.activeCatalogItems,
      primaryColor: ProfileCardBody.primaryColorOf(card),
      fontFamily: ProfileCardBody.fontFamilyOf(card),
      onItemTap: _handleProductTap,
    );
  }

  void _handleProductTap(ProfileCardProduct product) {
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

  Future<void> _handleShare() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await WidgetsBinding.instance.endOfFrame;
      final boundary = _shareCardKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) throw StateError('card not ready');
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw StateError('failed to encode image');

      final basic = _card?.basic;
      final name = basic?.fullName.trim() ?? '';
      final email = basic?.email.trim() ?? '';
      final caption = [
        name.isEmpty ? AppConstants.appName : name,
        if (email.isNotEmpty) email,
        AppConstants.appName,
        _profileLink,
      ].join('\n');

      await Share.shareXFiles(
        [
          XFile.fromData(
            byteData.buffer.asUint8List(),
            name: 'silink-card.png',
            mimeType: 'image/png',
          ),
        ],
        text: caption,
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

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  PreferredSizeWidget get _appBar {
    if (_isVisitorMode) return const ProfileCardVisitorBanner();
    return ProfileCardToolbar(
      onBack: () => Navigator.of(context).maybePop(),
      onOpenEditor: () => Navigator.of(context).maybePop(),
      onSaveAndPublish: _handleSaveAndPublish,
      onViewAsVisitor: _handleViewAsVisitor,
      onCopyLink: _handleCopyLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<ProfileCardCubit, ProfileCardState>(
        builder: (context, state) {
          final scrollView = SingleChildScrollView(
            child: state is ProfileCardSuccess
                ? ProfileCardBody(
                    card: state.card,
                    repaintKey: _shareCardKey,
                    onCall: _handleCall,
                    onWhatsapp: _handleWhatsapp,
                    onEmail: _handleEmail,
                    onSaveContact: _handleSaveContact,
                    onOpenContact: _handleOpenContact,
                    onProductTap: _handleProductTap,
                    onViewAllProducts: _handleViewAllProducts,
                    footer: ProfileCardFooter(
                      onShareData: _handleShareData,
                      onShareFile: _handleShare,
                      isSharingFile: _isSharing,
                    ),
                  )
                : const SizedBox.shrink(),
          );

          return PopScope(
            canPop: !_isVisitorMode,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop && _isVisitorMode) _handleExitVisitorMode();
            },
            child: Scaffold(
              backgroundColor: AppColors.white.themeColor,
              appBar: _appBar,
              body: CustomScreenStateLayout(
                isLoading:
                    state is ProfileCardInitial || state is ProfileCardLoading,
                error: state is ProfileCardError
                    ? ErrorModel(
                        code: ErrorEnum.otherError,
                        errorMessage: state.message,
                      )
                    : null,
                onRetry: _cubit.getMyCard,
                builder: (context) => _isVisitorMode
                    ? Stack(
                        children: [
                          scrollView,
                          PositionedDirectional(
                            top: 12.h,
                            end: 12.w,
                            child: ProfileCardExitPreviewButton(
                              onExit: _handleExitVisitorMode,
                            ),
                          ),
                        ],
                      )
                    : scrollView,
              ),
            ),
          );
        },
      ),
    );
  }
}
