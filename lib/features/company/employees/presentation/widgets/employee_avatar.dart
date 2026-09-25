import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/image/custom_image.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeAvatar extends StatelessWidget {
  const EmployeeAvatar({
    super.key,
    required this.employee,
    required this.size,
    required this.radius,
    required this.gradient,
  });

  final CompanyEmployeeModel employee;
  final double size;
  final double radius;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final imageUrl = employee.imageUrl?.trim() ?? '';
    if (imageUrl.isNotEmpty) {
      return CustomImage(
        image: imageUrl,
        width: size.w,
        height: size.w,
        radius: radius.r,
      );
    }
    return Container(
      width: size.w,
      height: size.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        gradient: gradient,
      ),
      child: AppText(
        employee.initials,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.white.themeColor,
      ),
    );
  }
}
