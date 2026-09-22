import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:Silink/features/my_card/presentation/widgets/card_link_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import 'widgets/my_cards_qr_buttons_row.dart';
import 'widgets/profile_preview_card.dart';
import 'widgets/public_toggle_card.dart';
import 'widgets/publish_success_banner.dart';

class PublishedScreen extends StatelessWidget {
  const PublishedScreen({
    super.key,
    required this.data,
  });

  final ProfileCompletionData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.publish_publishedTitle.tr()),
          12.height,
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  const PublishSuccessBanner(handle: 'حا1'),
                  16.height,
                  ProfilePreviewCard(data: data),
                  12.height,
                  CardLinkField(),
                  12.height,
                  const PublicToggleCard(),
                  12.height,
                  MyCardsAndQrButtonsRow(
                    onMyCardsTap: () {
                      NavigationService.push(
                        Routes.layoutScreen,
                        arguments: {'data': data},
                      );
                    },
                    onQrCodeTap: () {
                      NavigationService.push(
                        Routes.qrCodeScreen,
                        arguments: {
                          'data': data,
                        },
                      );
                    },
                  ),
                  12.height,
                  CustomButton(
                    onTap: () {
                      NavigationService.push(
                        Routes.publicProfilePreviewScreen,
                        arguments: {'data': data},
                      );
                    },
                    color: AppColors.white.themeColor,
                    borderColor: AppColors.borderColor.themeColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.iconsPreview,
                          height: 15.h,
                          width: 15.w,
                        ),
                        8.width,
                        AppText(
                          LocaleKeys.publish_viewCard.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                  16.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}