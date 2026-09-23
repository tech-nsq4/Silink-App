import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// كرت قسم عام بعنوان (ولون مخصص) مع عنصر إضافي اختياري في الرأس.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  title,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondaryColor.themeColor,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          12.height,
          ...children,
        ],
      ),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppText(
              label,
              fontSize: 12.sp,
            ),
            12.width,
            Expanded(
              child: AppText(
                value,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
      ),
      child: AppText(
        label,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// نص placeholder عند عدم وجود عناصر في القسم.
class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: AppText(
        text,
        fontSize: 12.sp,
        textAlign: TextAlign.center,
        color: AppColors.textSecondaryColor.themeColor,
      ),
    );
  }
}

/// زر "+ إضافة" الأخضر في رأس قسم المتابعة/الملاحظات.
class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.mint.themeColor,
        ),
      ),
    );
  }
}
