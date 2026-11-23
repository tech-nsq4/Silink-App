import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';

class NewCardLoginPrompt extends StatefulWidget {
  const NewCardLoginPrompt({super.key, required this.onLoginTap});

  final VoidCallback onLoginTap;

  @override
  State<NewCardLoginPrompt> createState() => _NewCardLoginPromptState();
}

class _NewCardLoginPromptState extends State<NewCardLoginPrompt>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  )..forward();

  late final AnimationController _arrowController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  late final Animation<double> _fade = CurvedAnimation(
    parent: _entranceController,
    curve: const Interval(0.25, 1, curve: Curves.easeOut),
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.6),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _entranceController,
    curve: const Interval(0.25, 1, curve: Curves.easeOutCubic),
  ));

  late final Animation<double> _arrowShift = Tween<double>(begin: 0, end: 3)
      .animate(CurvedAnimation(
    parent: _arrowController,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _entranceController.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.brandTeal.themeColor;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              LocaleKeys.newCard_haveCardQuestion.tr(),
              fontSize: 11.sp,
              color: AppColors.footerNote.themeColor,
            ),
            4.width,
            CustomTapEffect(
              onTap: widget.onLoginTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: accent.withValues(alpha: 0.25)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      LocaleKeys.newCard_loginCta.tr(),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                    4.width,
                    AnimatedBuilder(
                      animation: _arrowShift,
                      builder: (context, child) => Transform.translate(
                        offset: Offset(
                          isRtl ? -_arrowShift.value : _arrowShift.value,
                          0,
                        ),
                        child: child,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 13.sp,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
