import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/card_link_field.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/profile_preview_card.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/public_toggle_card.dart';
import 'package:Silink/features/statistics/presentation/widgets/stats_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PublishCardScreen extends StatefulWidget {
  const PublishCardScreen({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<PublishCardScreen> createState() => _PublishCardScreenState();
}

class _PublishCardScreenState extends State<PublishCardScreen> {
  bool _isLoading = false;

  Future<void> _handlePublish() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      AppOverlay.showSuccess(LocaleKeys.publish_publishedSuccess.tr());
      NavigationService.push(Routes.publishedScreen, arguments: {
        'data': widget.data,
      });
    } catch (e) {
      if (!mounted) return;
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StatsAppBar(
            title: LocaleKeys.publish_publishCard.tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                children: [
                  ProfilePreviewCard(
                    data: widget.data,
                  ),
                  12.height,
                  CardLinkField(),
                  12.height,
                  const PublicToggleCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 19.paddingHorizontal + 12.paddingVert,
        child: CustomButton(
          onTap: _handlePublish,
          radius: 14,
          loading: _isLoading,
          child: _isLoading
              ? null
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.iconsFlash),
                    8.width,
                    AppText(
                      LocaleKeys.publish_publishCard.tr(),
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AppColors.white.themeColor,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
