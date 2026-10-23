import 'dart:async';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/deep_link_service.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/silink_brand.dart';
import '../../profile/logic/profile_cubit.dart';
import 'widgets/splash_backdrop.dart';
import 'widgets/splash_loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration _minDuration = Duration(milliseconds: 2600);

  Timer? _minTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _minTimer = Timer(_minDuration, _navigate);
  }

  @override
  void dispose() {
    _minTimer?.cancel();
    super.dispose();
  }

  Future<void> _navigate() async {
    if (_navigated || !mounted) return;
    _navigated = true;
    await _routeToStart();
    DeepLinkService.markReady();
  }

  Future<void> _routeToStart() async {
    final storage = getIt<LocalStorage>();
    if (storage.isLoggedIn) {
      await context.read<ProfileCubit>().getProfile();
      if (!mounted) return;
      final navigator = Navigator.of(context);
      final isCompany = kUserModel?.usageIntent == 'company';
      if (isCompany && storage.isCompanySetupPending) {
        navigator.pushNamedAndRemoveUntil(Routes.companySetup, (_) => false);
        return;
      }
      navigator.pushNamedAndRemoveUntil(kHomeRoute, (_) => false);
      if (!isCompany && storage.isStudioPending) {
        navigator.pushNamed(
          Routes.cardStudioScreen,
          arguments: {'remote': true, 'resume': true},
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.onBoardingScreen,
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.light;
    return Scaffold(
      backgroundColor: AppColors.splashBackground.themeColor,
      body: Stack(
        children: [
          const Positioned.fill(child: SplashBackdrop()),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                30.w,
                math.max(55.h, MediaQuery.paddingOf(context).top + 12.h),
                30.w,
                40.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SilinkBrand(fontSize: 52.sp, color: white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocaleKeys.brand_tagline.tr(),
                        fontSize: 8.sp,
                        letterSpacing: 2,
                        color: AppColors.splashEyebrow.themeColor,
                      ),
                      SizedBox(height: 20.h),
                      AppText(
                        LocaleKeys.splash_headline.tr(),
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                        letterSpacing: -1.2,
                        color: white,
                      ),
                      SizedBox(height: 20.h),
                      AppText(
                        LocaleKeys.splash_tagline.tr(),
                        fontSize: 12.sp,
                        color: AppColors.splashBody.themeColor,
                      ),
                    ],
                  ),
                  SplashLoadingIndicator(
                    label: LocaleKeys.splash_welcome.tr(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
