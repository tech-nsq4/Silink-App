import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../../core/widgets/image/custom_image.dart';
import '../../../../../card_studio/data/models/studio_item.dart';
import '../../../../../card_studio/presentation/widgets/studio_reveal.dart';

class WorkspaceReviewItemRow extends StatelessWidget {
  const WorkspaceReviewItemRow({
    super.key,
    required this.item,
    required this.index,
  });

  final StudioItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final kind = item.isService
        ? LocaleKeys.cardStudio_kindService.tr()
        : LocaleKeys.cardStudio_kindProduct.tr();
    final price = item.price.trim();
    final meta = [
      kind,
      if (price.isNotEmpty) '$price ${LocaleKeys.publicProfile_currency.tr()}',
    ].join(' · ');
    final imageUrl = item.imageUrl?.trim() ?? '';
    return StudioReveal(
      delay: Duration(milliseconds: 70 * index),
      offset: 10,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.studioItemIcon.themeColor,
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: item.imageFile != null
                  ? Image.file(item.imageFile!,
                      width: 44.w, height: 44.w, fit: BoxFit.cover)
                  : imageUrl.isNotEmpty
                      ? CustomImage(
                          image: imageUrl,
                          width: 44.w,
                          height: 44.w,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          item.isService
                              ? Icons.work_outline_rounded
                              : Icons.inventory_2_outlined,
                          size: 20.sp,
                          color: AppColors.studioItemIconColor.themeColor,
                        ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    item.name,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  3.height,
                  AppText(
                    meta,
                    fontSize: 9.sp,
                    color: AppColors.textSecondaryColor.themeColor,
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
