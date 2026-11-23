import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../card_studio/data/models/studio_item.dart';
import 'workspace_review_empty.dart';
import 'workspace_review_item_row.dart';
import 'workspace_review_section.dart';

class WorkspaceReviewCatalog extends StatelessWidget {
  const WorkspaceReviewCatalog({
    super.key,
    required this.items,
    required this.onEdit,
  });

  static const int maxPreview = 4;

  final List<StudioItem> items;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final preview = items.take(maxPreview).toList();
    final hidden = items.length - preview.length;
    return WorkspaceReviewSection(
      title: LocaleKeys.companyWorkspace_reviewCatalog.tr(),
      onEdit: onEdit,
      child: items.isEmpty
          ? WorkspaceReviewEmpty(
              text: LocaleKeys.companyWorkspace_reviewEmptyCatalog.tr(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (index, item) in preview.indexed)
                  WorkspaceReviewItemRow(item: item, index: index),
                if (hidden > 0)
                  AppText(
                    LocaleKeys.companyWorkspace_reviewMore
                        .tr(args: ['$hidden']),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentTeal.themeColor,
                  ),
              ],
            ),
    );
  }
}
