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
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/creation_footer.dart';
import '../../../core/widgets/creation_header.dart';
import '../../../core/widgets/creation_toolbar.dart';
import '../../../core/widgets/public_profile/public_profile_view.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/profile_card_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../data/profile_card_repo.dart';
import '../logic/profile_card_cubit.dart';
import 'widgets/profile_card_contact_actions.dart';
import '../../../core/utils/share_origin.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({
    super.key,
    this.viewOnly = false,
    this.fromStudio = false,
    this.portfolioId,
  });

  final bool viewOnly;
  final bool fromStudio;
  final String? portfolioId;

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  static const int portfoliosTabIndex = 1;

  late final ProfileCardCubit _cubit = (widget.portfolioId == null
      ? getIt<ProfileCardCubit>()
      : ProfileCardCubit(ProfileCardRepo(
          dio: getIt(),
          scope: ApiEndpoints.mePortfolio(widget.portfolioId!),
        )))
    ..getMyCard();
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

  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    final origin = ShareOrigin.of(context);
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
        sharePositionOrigin: origin,
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
    final portfolioId = widget.portfolioId;
    await Navigator.pushNamed(
      context,
      portfolioId == null
          ? Routes.profileCompletionScreen
          : Routes.portfolioStudioScreen,
      arguments: portfolioId == null ? null : {'portfolioId': portfolioId},
    );
    if (mounted) _cubit.getMyCard();
  }

  void _finish() => Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.layoutScreen,
        (_) => false,
        arguments: widget.portfolioId == null
            ? null
            : {'currentPage': portfoliosTabIndex},
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
                    actions: ProfileCardContactActions(
                      context,
                      state.card,
                    ).build(
                      onShare: _share,
                      onClose: widget.viewOnly
                          ? () => Navigator.of(context).maybePop()
                          : null,
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
