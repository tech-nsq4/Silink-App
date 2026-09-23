import 'package:Silink/core/utils/app_images.dart';
import 'package:Silink/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import 'account_avatar.dart';

class AccountProfileHeaderCard extends StatelessWidget {
  const AccountProfileHeaderCard({
    super.key,
    required this.user,
    this.imageUrl,
    this.onEditTap,
  });

  final String? imageUrl;
  final VoidCallback? onEditTap;

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final trimmedName = user.fullName.trim();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AccountAvatar(
            imageUrl: imageUrl,
            initial: trimmedName.isEmpty ? '' : trimmedName.substring(0, 1),
            
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  user.fullName,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                2.height,
                AppText(
                  user.phone,
                  fontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                2.height,
                AppText(
                  user.email ?? '',
                  fontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.height,
                Container(
                  padding: 8.paddingHorizontal + 4.paddingVert,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondaryColor.themeColor
                        .withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: AppText(
                    'خطة مجاني',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ),
              ],
            ),
          ),
          if (onEditTap != null)
            InkWell(
              onTap: onEditTap,
              borderRadius: BorderRadius.circular(19.r),
              child: Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.themeColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppImages.iconsEdit),
              ),
            ),
        ],
      ),
    );
  }
}
