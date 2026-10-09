import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/client_category_model.dart';
import 'client_category_chip.dart';
import 'client_section_card.dart';

class ClientCategoriesCard extends StatelessWidget {
  const ClientCategoriesCard({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.isUpdating,
    required this.onToggle,
  });

  final List<ClientCategoryModel> categories;
  final Set<String> selectedIds;
  final bool isUpdating;
  final ValueChanged<ClientCategoryModel> onToggle;

  @override
  Widget build(BuildContext context) {
    return ClientSectionCard(
      title: LocaleKeys.clients_tags.tr(),
      trailing: isUpdating
          ? SizedBox(
              width: 16.w,
              height: 16.w,
              child: CustomLoadingWidget(
                color: AppColors.mint.themeColor,
                size: 16,
              ),
            )
          : null,
      child: categories.isEmpty
          ? AppText(
              LocaleKeys.clients_noCategories.tr(),
              fontSize: 12.sp,
              color: AppColors.textSecondaryColor.themeColor,
            )
          : Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final category in categories)
                  ClientCategoryChip(
                    label: category.name,
                    selected: selectedIds.contains(category.id),
                    onTap: isUpdating ? null : () => onToggle(category),
                  ),
              ],
            ),
    );
  }
}
