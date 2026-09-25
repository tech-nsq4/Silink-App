import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_avatar.dart';

class ProfileCardCover extends StatelessWidget {
  const ProfileCardCover({
    super.key,
    required this.coverColor,
    required this.primaryColor,
    required this.fullName,
    required this.photoUrl,
    required this.fontFamily,
  });

  final Color coverColor;
  final Color primaryColor;
  final String fullName;
  final String? photoUrl;
  final String? fontFamily;

  static double get avatarSize => 88.w;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white.themeColor;
    final decorColor = white.withValues(alpha: 0.08);

    return SizedBox(
      height: 130.h + avatarSize / 2,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 130.h,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  coverColor,
                  Color.lerp(coverColor, white, 0.18) ?? coverColor,
                ],
              ),
            ),
            child: Stack(
              children: [
                PositionedDirectional(
                  top: -40.w,
                  start: -30.w,
                  child: Container(
                    width: 130.w,
                    height: 130.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: decorColor,
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 20.w,
                  start: 10.w,
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: decorColor,
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: -40.w,
                  end: -20.w,
                  child: Container(
                    width: 110.w,
                    height: 110.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: decorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 130.h - avatarSize / 2,
            child: ProfileCardAvatar(
              size: avatarSize,
              fullName: fullName,
              photoUrl: photoUrl,
              backgroundColor: primaryColor,
              fontFamily: fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
