import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/employees/logic/company_team_member_cubit.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_form_field.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_invite_success_view.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInviteScreen extends StatefulWidget {
  const EmployeeInviteScreen({super.key});

  @override
  State<EmployeeInviteScreen> createState() => _EmployeeInviteScreenState();
}

class _EmployeeInviteScreenState extends State<EmployeeInviteScreen> {
  late final CompanyTeamMemberCubit _cubit = getIt<CompanyTeamMemberCubit>();
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _whatsappCtrl = TextEditingController();
  final _positionCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _hasCreated = false;

  @override
  void dispose() {
    _cubit.close();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _whatsappCtrl.dispose();
    _positionCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_cubit.state is CompanyTeamMemberLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _cubit.createMember(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      whatsapp: _whatsappCtrl.text.trim(),
      position: _positionCtrl.text.trim(),
    );
  }

  void _onMemberState(BuildContext context, CompanyTeamMemberState state) {
    if (state is CompanyTeamMemberSaved) _hasCreated = true;
  }

  void _close() => Navigator.of(context).pop(_hasCreated);

  void _reset() {
    _nameCtrl.clear();
    _emailCtrl.clear();
    _phoneCtrl.clear();
    _whatsappCtrl.clear();
    _positionCtrl.clear();
    _passwordCtrl.clear();
    _cubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: BlocConsumer<CompanyTeamMemberCubit, CompanyTeamMemberState>(
        bloc: _cubit,
        listener: _onMemberState,
        builder: (context, state) => Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(
                title: LocaleKeys.company_invite_title.tr(),
                onBack: _close,
              ),
              Expanded(
                child: state is CompanyTeamMemberSaved
                    ? EmployeeInviteSuccessView(
                        name: state.member.name,
                        onViewList: _close,
                        onInviteAnother: _reset,
                      )
                    : Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                LocaleKeys.company_invite_subtitle.tr(),
                                fontSize: 13.sp,
                                color: AppColors.textSecondaryColor.themeColor,
                              ),
                              16.height,
                              EmployeeFormField(
                                label: LocaleKeys.company_full_name_star.tr(),
                                controller: _nameCtrl,
                                validator: EmployeeValidators.required,
                              ),
                              14.height,
                              EmployeeFormField(
                                label: LocaleKeys.company_email_star.tr(),
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                validator: EmployeeValidators.email,
                              ),
                              14.height,
                              AppText(
                                LocaleKeys.company_phone_number.tr(),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              8.height,
                              CustomTextFieldPhoneCode(
                                controller: _phoneCtrl,
                                initialCountryCode: 'SA',
                                isRequired: false,
                                borderRadius: 14,
                                borderColor: AppColors.borderColor.themeColor,
                              ),
                              14.height,
                              EmployeeFormField(
                                label: LocaleKeys.company_whatsapp.tr(),
                                controller: _whatsappCtrl,
                                keyboardType: TextInputType.phone,
                              ),
                              14.height,
                              EmployeeFormField(
                                label: LocaleKeys.company_job_title_star.tr(),
                                controller: _positionCtrl,
                                validator: EmployeeValidators.required,
                              ),
                              14.height,
                              EmployeeFormField(
                                label: LocaleKeys.company_password_star.tr(),
                                controller: _passwordCtrl,
                                isPassword: true,
                                validator: EmployeeValidators.password,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
          bottomNavigationBar: state is CompanyTeamMemberSaved
              ? null
              : Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
                  child: CustomButton(
                    onTap: _submit,
                    title: LocaleKeys.company_send_invite.tr(),
                    height: 48,
                    radius: 14,
                    loading: state is CompanyTeamMemberLoading,
                  ),
                ),
        ),
      ),
    );
  }
}
