import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/data/models/company_employee.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeEditScreen extends StatefulWidget {
  const EmployeeEditScreen({super.key, required this.employee});

  final CompanyEmployeeItem employee;

  @override
  State<EmployeeEditScreen> createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.employee.fullName);
  late final TextEditingController _emailController =
      TextEditingController(text: widget.employee.email);
  late final TextEditingController _phoneController =
      TextEditingController(text: widget.employee.phone);
  late final TextEditingController _jobController =
      TextEditingController(text: widget.employee.jobTitle);
  late final TextEditingController _departmentController =
      TextEditingController(text: widget.employee.department);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  void _save() {
    final employee = widget.employee.copyWith(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      jobTitle: _jobController.text.trim(),
      department: _departmentController.text.trim(),
    );
    Navigator.of(context).pop(employee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_employee_edit_title.tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText(
                    LocaleKeys.company_full_name_star.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  8.height,
                  CustomTextField(
                    hint: widget.employee.fullName,
                    controller: _nameController,
                    borderRadius: 14,
                  ),
                  16.height,
                  AppText(
                    LocaleKeys.company_email_star.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  8.height,
                  CustomTextField(
                    hint: widget.employee.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    borderRadius: 14,
                  ),
                  16.height,
                  AppText(
                    LocaleKeys.company_phone_number.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  8.height,
                  CustomTextField(
                    hint: widget.employee.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    borderRadius: 14,
                  ),
                  16.height,
                  AppText(
                    LocaleKeys.company_job_title_star.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  8.height,
                  CustomTextField(
                    hint: widget.employee.jobTitle,
                    controller: _jobController,
                    borderRadius: 14,
                  ),
                  16.height,
                  AppText(
                    LocaleKeys.company_department.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  8.height,
                  CustomTextField(
                    hint: LocaleKeys.company_department_hint.tr(),
                    controller: _departmentController,
                    borderRadius: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
        child: CustomButton(
          onTap: _save,
          title: LocaleKeys.company_save_changes.tr(),
          height: 48,
          radius: 14,
        ),
      ),
    );
  }
}
