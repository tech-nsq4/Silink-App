import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';

class ClientHeaderActions extends StatelessWidget {
  const ClientHeaderActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(20.r),
          child: Icon(
            Icons.edit_outlined,
            size: 21.sp,
            color: AppColors.textPrimaryColor.themeColor,
          ),
        ),
        14.width,
        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(20.r),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 22.sp,
            color: AppColors.errorColor.themeColor,
          ),
        ),
      ],
    );
  }
}
