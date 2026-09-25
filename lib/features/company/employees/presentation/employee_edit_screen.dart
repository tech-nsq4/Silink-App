import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/employees/data/models/company_employee_model.dart';
import 'package:Silink/features/company/employees/logic/company_team_member_cubit.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_form_field.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeEditScreen extends StatefulWidget {
  const EmployeeEditScreen({super.key, required this.employee});

  final CompanyEmployeeModel employee;

  @override
  State<EmployeeEditScreen> createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  late final CompanyTeamMemberCubit _cubit = getIt<CompanyTeamMemberCubit>();
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.employee.name);
  late final _emailController =
      TextEditingController(text: widget.employee.email);
  late final _phoneController =
      TextEditingController(text: widget.employee.phone);
  late final _whatsappController =
      TextEditingController(text: widget.employee.whatsapp);
  late final _positionController =
      TextEditingController(text: widget.employee.position);
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _cubit.close();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _positionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _save() {
    if (_cubit.state is CompanyTeamMemberLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _cubit.updateMember(
      widget.employee,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      whatsapp: _whatsappController.text.trim(),
      position: _positionController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  void _onMemberState(BuildContext context, CompanyTeamMemberState state) {
    if (state is! CompanyTeamMemberSaved) return;
    AppOverlay.showSuccess(LocaleKeys.company_employee_updated.tr());
    Navigator.of(context).pop(state.member);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyTeamMemberCubit, CompanyTeamMemberState>(
      bloc: _cubit,
      listener: _onMemberState,
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.backgroundColor.themeColor,
        body: Column(
          children: [
            ScreenHeaderBar(
              title: LocaleKeys.company_employee_edit_title.tr(),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EmployeeFormField(
                        label: LocaleKeys.company_full_name_star.tr(),
                        controller: _nameController,
                        validator: EmployeeValidators.required,
                      ),
                      16.height,
                      EmployeeFormField(
                        label: LocaleKeys.company_email_star.tr(),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: EmployeeValidators.email,
                      ),
                      16.height,
                      EmployeeFormField(
                        label: LocaleKeys.company_phone_number.tr(),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      16.height,
                      EmployeeFormField(
                        label: LocaleKeys.company_whatsapp.tr(),
                        controller: _whatsappController,
                        keyboardType: TextInputType.phone,
                      ),
                      16.height,
                      EmployeeFormField(
                        label: LocaleKeys.company_job_title_star.tr(),
                        controller: _positionController,
                        validator: EmployeeValidators.required,
                      ),
                      16.height,
                      EmployeeFormField(
                        label: LocaleKeys.company_new_password.tr(),
                        hint: LocaleKeys.company_password_keep_hint.tr(),
                        controller: _passwordController,
                        isPassword: true,
                        validator: EmployeeValidators.optionalPassword,
                      ),
                    ],
                  ),
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
            loading: state is CompanyTeamMemberLoading,
          ),
        ),
      ),
    );
  }
}
