import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuNotifications extends StatelessWidget {
  final List<Widget> children;
  const MenuNotifications({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor.themeColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
          children: List.generate(children.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Divider(
            height: 1,
            color: AppColors.borderColor.themeColor,
            thickness: .5,
          );
        }
        return Padding(
          padding: 16.paddingHorizontal,
          child: children[index ~/ 2],
        );
      })),
    );
  }
}
