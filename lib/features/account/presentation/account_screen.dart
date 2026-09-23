import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile/logic/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../auth/logic/auth_cubit.dart';
import '../widgets/account_menu_tile.dart';
import '../widgets/account_profile_header_card.dart';
import '../widgets/account_ready_card.dart';
import '../widgets/account_section_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, this.showBack = true});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state is ProfileSuccess ? state.user : null;

        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(
                title: LocaleKeys.account_title.tr(),
                showBack: showBack,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AccountProfileHeaderCard(
                        user: user!,
                        onEditTap: () => context.pushNamed(
                            Routes.accountEditScreen,
                            arguments: {'user': user}),
                      ),
                      12.height,
                      AccountReadyCard(
                        title: LocaleKeys.account_readyTitle.tr(),
                        subtitle: LocaleKeys.account_readySubtitle.tr(),
                        actionLabel: LocaleKeys.account_add.tr(),
                        // onAddTap: () =>
                        //     context.pushNamed(Routes.publishCardScreen),
                      ),
                      16.height,
                      AccountSectionCard(
                        children: [
                          AccountMenuTile(
                            label: LocaleKeys.account_sectionAccountData.tr(),
                            onTap: () => context.pushNamed(
                                Routes.accountEditScreen,
                                arguments: {'user': user}),
                            icon: AppImages.iconsPersonal,
                          ),
                          AccountMenuTile(
                            label: LocaleKeys.account_changeUsageType.tr(),
                            onTap: () =>
                                context.pushNamed(Routes.usageTypeScreen),
                            icon: AppImages.iconsChanging,
                          ),
                          AccountMenuTile(
                            icon: AppImages.iconsNotifications,
                            label: LocaleKeys.account_notificationsTitle.tr(),
                            onTap: () =>
                                context.pushNamed(Routes.notificationsScreen),
                          ),
                          AccountMenuTile(
                            icon: AppImages.iconsPrivacy,
                            label: LocaleKeys.account_privacyTitle.tr(),
                            onTap: () =>
                                context.pushNamed(Routes.privacyScreen),
                          ),
                          AccountMenuTile(
                            icon: AppImages.iconsStar,
                            label: LocaleKeys.account_subscriptionTitle.tr(),
                            onTap: () =>
                                context.pushNamed(Routes.subscriptionScreen),
                          ),
                          AccountMenuTile(
                            icon: AppImages.iconsInfo,
                            label: LocaleKeys.account_helpCenter.tr(),
                            onTap: () => context.pushNamed(Routes.helpScreen),
                          ),
                        ],
                      ),
                      16.height,
                      _LanguageTile(
                        onTap: () => AppOverlay.showSuccess(
                          LocaleKeys.common_comingSoon.tr(),
                        ),
                      ),
                      12.height,
                      CustomButton(
                        onTap: () {
                          context.read<ProfileCubit>().reset();
                          context.read<AuthCubit>().logout();
                          context.pushNamedAndRemoveUntil(
                            Routes.loginScreen,
                            predicate: (_) => false,
                          );
                        },
                        color: Color(0xFFfef2f2),
                        borderColor: Color(0xFFe7000b),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.iconsLogout),
                            8.width,
                            AppText(
                              LocaleKeys.account_logout.tr(),
                              color: Color(0xFFe7000b),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),

                      // AccountSectionCard(
                      //   label: LocaleKeys.account_sectionDashboard.tr(),
                      //   children: [
                      //     AccountMenuTile(
                      //       icon: AppImages.iconsStats,
                      //       label: LocaleKeys.account_statistics.tr(),
                      //       onTap: () =>
                      //           context.pushNamed(Routes.statisticsScreen),
                      //     ),
                      //     AccountMenuTile(
                      //       icon: AppImages.iconsQrCode,
                      //       label: LocaleKeys.account_publishCard.tr(),
                      //       onTap: () =>
                      //           context.pushNamed(Routes.publishCardScreen),
                      //     ),
                      //   ],
                      // ),
                      // 24.height,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppImages.iconsInternet,
                  height: 21.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.textSecondaryColor.themeColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      LocaleKeys.account_language.tr(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    4.height,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Native language names are shown as-is by design.
                        Flexible(
                          child: AppText(
                            'العربية · English · ',
                            fontSize: 12.sp,
                            color: AppColors.textSecondaryColor.themeColor,
                          ),
                        ),
                        AppText(
                          LocaleKeys.account_soon.tr(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.hintColor.themeColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              8.width,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AppText(
                  'AR',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
