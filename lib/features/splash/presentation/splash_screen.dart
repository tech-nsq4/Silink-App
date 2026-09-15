import 'dart:async';

import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/storage/local_storage.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';

import '../../../core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final GifController _gifController;
  Timer? _minTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _gifController = GifController(vsync: this);
    _minTimer = Timer(const Duration(seconds: 2), _navigate);
  }

  @override
  void dispose() {
    _minTimer?.cancel();
    _gifController.dispose();
    super.dispose();
  }

  void _navigate() {
    if (_navigated || !mounted) return;
    _navigated = true;

    final storage = getIt<LocalStorage>();

    if (storage.isLoggedIn) {
   
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.layoutScreen,
        (_) => false,
      );
    } else if (storage.isOnboardingSeen) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        // Routes.loginScreen,
        // Routes.onBoardingScreen,
        Routes.onBoardingScreen,

        (_) => false,
      );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(AppImages.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.darkSlate.themeColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Image.asset(AppImages.logoApp),
                  ),
                  16.verticalSpace,
                  AppText(
                    LocaleKeys.splash_subtitle.tr(),
                    fontSize: 12.sp,
                    color: AppColors.white.themeColor,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 32.h,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomLoadingWidget(),
                  8.verticalSpace,
                  AppText(
                    LocaleKeys.splash_loading.tr(),
                    fontSize: 12.sp,
                    color: AppColors.white.themeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
