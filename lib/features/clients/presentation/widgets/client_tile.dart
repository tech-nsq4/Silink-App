import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_tap_effect.dart';
import '../../data/models/client_model.dart';
import 'client_category_chip.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({
    super.key,
    required this.client,
    required this.onTap,
    this.tint,
  });

  final ClientModel client;
  final VoidCallback onTap;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.textSecondaryColor.themeColor;
    final color = tint ?? AppColors.accentTeal.themeColor;
    final email = client.email.trim();
    final name = client.name.trim();
    return CustomTapEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: AppText(
                name.isEmpty ? '' : name.characters.first,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          client.name,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w800,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (client.categories.isNotEmpty)
                        ClientCategoryChip(
                          label: client.categories.first.name,
                          selected: true,
                          compact: true,
                        ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  AppText(
                    email.isNotEmpty ? email : client.mobile,
                    fontSize: 8.5.sp,
                    color: secondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (email.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: AppText(client.mobile,
                          fontSize: 7.5.sp, color: secondary),
                    ),
                  ],
                ],
              ),
            ),
            8.width,
            Icon(Icons.chevron_left_rounded, size: 20.sp, color: secondary),
          ],
        ),
      ),
    );
  }
}
