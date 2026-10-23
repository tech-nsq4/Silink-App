import 'dart:math' as math;

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'invitation_rings_painter.dart';

class InvitationHero extends StatefulWidget {
  const InvitationHero({super.key, this.companyName, this.logoUrl});

  final String? companyName;
  final String? logoUrl;

  @override
  State<InvitationHero> createState() => _InvitationHeroState();
}

class _InvitationHeroState extends State<InvitationHero>
    with SingleTickerProviderStateMixin {
  static const double _logoAlignmentY = -0.36;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 7),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _logo(double size) {
    final url = widget.logoUrl;
    final fallback = Icon(
      Icons.apartment_rounded,
      size: size * 0.46,
      color: AppColors.primaryColor.themeColor,
    );
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.themeColor,
        border: Border.all(
          color: AppColors.accentGold.themeColor,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGold.themeColor.withValues(alpha: 0.35),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: url == null || url.isEmpty
            ? fallback
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallback,
              ),
      ),
    );
  }

  Widget _envelopeBadge() {
    return Container(
      padding: EdgeInsets.all(7.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentGold.themeColor,
        border: Border.all(color: AppColors.primaryColor.themeColor, width: 3),
      ),
      child: Icon(
        Icons.mark_email_read_rounded,
        size: 16.sp,
        color: AppColors.primaryColor.themeColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final logoSize = 92.w;
    final name = widget.companyName;
    return Container(
      height: 310.h + top,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor.themeColor,
            Color.alphaBlend(
              AppColors.brandGreen.themeColor.withValues(alpha: 0.22),
              AppColors.primaryColor.themeColor,
            ),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
        child: Stack(
          children: [
            PositionedDirectional(
              top: -70.h,
              end: -60.w,
              child: Container(
                width: 190.h,
                height: 190.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      AppColors.accentGold.themeColor.withValues(alpha: 0.12),
                ),
              ),
            ),
            PositionedDirectional(
              bottom: -50.h,
              start: -50.w,
              child: Container(
                width: 140.h,
                height: 140.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      AppColors.accentGold.themeColor.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) => CustomPaint(
                  painter: InvitationRingsPainter(
                    progress: _controller.value,
                    centerAlignmentY: _logoAlignmentY,
                    scale: 1.w,
                    ringColor: AppColors.accentGold.themeColor,
                    dotColor: AppColors.white.themeColor,
                    accentColor: AppColors.accentGold.themeColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, _logoAlignmentY),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) => Transform.translate(
                  offset: Offset(
                    0,
                    math.sin(_controller.value * 2 * math.pi * 2) * 5.h,
                  ),
                  child: child,
                ),
                child: SizedBox(
                  width: logoSize + 10.w,
                  height: logoSize + 10.w,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      _logo(logoSize),
                      PositionedDirectional(
                        end: 0,
                        bottom: 0,
                        child: _envelopeBadge(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.8),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      LocaleKeys.invitation_heroTitle.tr(),
                      fontSize: 13.sp,
                      color: AppColors.white.themeColor.withValues(alpha: 0.75),
                    ),
                    if (name != null && name.isNotEmpty) ...[
                      6.height,
                      AppText(
                        name,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white.themeColor,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: top + 6.h,
              start: 8.w,
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18.sp,
                  color: AppColors.white.themeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
