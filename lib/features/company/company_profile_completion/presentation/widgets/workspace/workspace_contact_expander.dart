import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';

class WorkspaceContactExpander extends StatefulWidget {
  const WorkspaceContactExpander({
    super.key,
    required this.title,
    required this.phone,
    required this.email,
  });

  final String title;
  final String phone;
  final String email;

  @override
  State<WorkspaceContactExpander> createState() =>
      _WorkspaceContactExpanderState();
}

class _WorkspaceContactExpanderState extends State<WorkspaceContactExpander> {
  bool _open = false;

  Widget _row(IconData icon, String value) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Icon(icon,
                size: 14.sp, color: AppColors.textSecondaryColor.themeColor),
            8.width,
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppText(
                  value,
                  fontSize: 10.sp,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accentTeal.themeColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white.themeColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: _open
                    ? accent.withValues(alpha: 0.5)
                    : AppColors.studioPanelBorder.themeColor,
                width: _open ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    widget.title,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AnimatedRotation(
                  turns: _open ? -0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.chevron_left_rounded,
                      size: 20.sp,
                      color: AppColors.textSecondaryColor.themeColor),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _open
              ? Container(
                  margin: EdgeInsets.only(top: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.themeColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      _row(Icons.phone_outlined, widget.phone),
                      _row(Icons.mail_outline_rounded, widget.email),
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
