import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class FaqTile extends StatefulWidget {
  const FaqTile({
    super.key,
    required this.question,
    required this.answer,
    this.initiallyExpanded = false,
  });

  final String question;
  final String answer;
  final bool initiallyExpanded;

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 13.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    widget.question,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                8.width,
                Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size: 20.sp,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ],
            ),
            if (_expanded) ...[
              8.height,
              AppText(
                widget.answer,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
