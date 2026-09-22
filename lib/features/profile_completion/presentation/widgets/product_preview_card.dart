import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPreviewCard extends StatelessWidget {
  const ProductPreviewCard({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.kindLabel,
  });

  final String name;
  final String price;
  final String? imageUrl;
  final String? kindLabel;

  @override
  Widget build(BuildContext context) {
    final cardRadius = 16.r;
    final imageRadius = 12.r;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(6.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(imageRadius),
              child: AspectRatio(
                aspectRatio: 1.3,
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (kindLabel != null && kindLabel!.isNotEmpty) ...[
                  2.height,
                  AppText(
                    kindLabel!,
                    fontSize: 11.sp,
                    color: AppColors.mint.themeColor,
                  ),
                ],
                4.height,
                AppText(
                  price,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mint.themeColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.mintSoft.themeColor,
      alignment: Alignment.center,
      child: Icon(Icons.work_outline,
          size: 28.sp, color: AppColors.mint.themeColor),
    );
  }
}
