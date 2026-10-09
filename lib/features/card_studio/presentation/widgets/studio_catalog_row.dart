import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/image/custom_image.dart';
import '../../data/models/studio_item.dart';
import 'studio_move_arrows.dart';

class StudioCatalogRow extends StatelessWidget {
  const StudioCatalogRow({
    super.key,
    required this.item,
    required this.busy,
    required this.onEdit,
    required this.onDelete,
    this.onMoveUp,
    this.onMoveDown,
  });

  final StudioItem item;
  final bool busy;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  @override
  Widget build(BuildContext context) {
    final iconColor = AppColors.studioRowIcon.themeColor;
    final kind = item.isService
        ? LocaleKeys.cardStudio_kindService.tr()
        : LocaleKeys.cardStudio_kindProduct.tr();
    final price = item.price.trim();
    final meta = [
      kind,
      if (price.isNotEmpty) '$price ${LocaleKeys.publicProfile_currency.tr()}',
      if (!item.visible) LocaleKeys.cardStudio_hiddenBadge.tr(),
    ].join(' · ');
    final imageUrl = item.imageUrl?.trim() ?? '';
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.5.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: AppColors.studioStepLine.themeColor),
      ),
      child: Row(
        children: [
          Container(
            width: 37.w,
            height: 42.h,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.studioItemIcon.themeColor,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: item.imageFile != null
                ? Image.file(item.imageFile!,
                    width: 50.w, height: 60.h, fit: BoxFit.cover)
                : imageUrl.isNotEmpty
                    ? CustomImage(
                        image: imageUrl,
                        width: 50.w,
                        height: 60.h,
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
          10.width,
          Expanded(
            child: GestureDetector(
              onTap: busy ? null : onEdit,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    item.name,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  AppText(
                    meta,
                    fontSize: 9.sp,
                    color: AppColors.studioRowMeta.themeColor,
                  ),
                  SizedBox(height: 5.h),
                  AppText(
                    LocaleKeys.cardStudio_editItemDetails.tr(),
                    fontSize: 8.sp,
                    color: AppColors.accentTeal.themeColor,
                  ),
                ],
              ),
            ),
          ),
          if (busy)
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: CustomLoadingWidget(
                color: AppColors.accentTeal.themeColor,
                size: 18,
              ),
            )
          else ...[
            IconButton(
              onPressed: onDelete,
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.delete_outline_rounded,
                  size: 17.sp, color: iconColor),
            ),
            StudioMoveArrows(
              color: iconColor,
              onUp: onMoveUp,
              onDown: onMoveDown,
            ),
          ],
        ],
      ),
    );
  }
}
