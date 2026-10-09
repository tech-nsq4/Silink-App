import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/image/custom_image.dart';
import '../../../profile_completion/data/models/catalog_model.dart';

class CatalogHubRow extends StatelessWidget {
  const CatalogHubRow({
    super.key,
    required this.item,
    this.busy = false,
    this.onToggle,
    this.onEdit,
    this.onDelete,
    this.onMoveUp,
    this.onMoveDown,
  });

  final CatalogItemModel item;
  final bool busy;
  final VoidCallback? onToggle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  bool get _editable => onEdit != null;

  String get _priceLine {
    final price = item.price.trim();
    final label = item.priceLabel.trim();
    if (price.isEmpty) return label;
    final currency = LocaleKeys.store_currency.tr();
    return [if (label.isNotEmpty) label, '$price $currency'].join(' ');
  }

  Widget _arrow(IconData icon, VoidCallback? onTap) => InkWell(
        onTap: busy ? null : onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Icon(
            icon,
            size: 16.sp,
            color: onTap == null
                ? AppColors.studioStepLine.themeColor
                : AppColors.textSecondaryColor.themeColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    final secondary = AppColors.textSecondaryColor.themeColor;
    final image = item.imageUrl?.trim() ?? '';
    final price = _priceLine;
    return Opacity(
      opacity: item.isActive || !_editable ? 1 : 0.6,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.studioPanelBorder.themeColor),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.studioSelectFill.themeColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: image.isNotEmpty
                  ? CustomImage(
                      image: image,
                      width: 44.w,
                      height: 44.w,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      item.isService
                          ? Icons.work_outline_rounded
                          : Icons.restaurant_menu_rounded,
                      size: 18.sp,
                      color: secondary,
                    ),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    item.name,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.isService) ...[
                    SizedBox(height: 4.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: AppText(
                        LocaleKeys.catalogHub_offerBadge.tr(),
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                  ],
                  if (price.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    AppText(price, fontSize: 8.5.sp, color: secondary),
                  ],
                ],
              ),
            ),
            if (_editable) ...[
              if (busy)
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: CustomLoadingWidget(color: accent, size: 16),
                )
              else ...[
                _arrow(Icons.arrow_upward_rounded, onMoveUp),
                _arrow(Icons.arrow_downward_rounded, onMoveDown),
              ],
              4.width,
              Transform.scale(
                scale: 0.75,
                child: Switch.adaptive(
                  value: item.isActive,
                  activeTrackColor: accent,
                  onChanged: busy ? null : (_) => onToggle?.call(),
                ),
              ),
              InkWell(
                onTap: busy ? null : onEdit,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child:
                      Icon(Icons.edit_outlined, size: 16.sp, color: secondary),
                ),
              ),
              InkWell(
                onTap: busy ? null : onDelete,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(Icons.delete_outline_rounded,
                      size: 16.sp, color: AppColors.errorColor.themeColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
