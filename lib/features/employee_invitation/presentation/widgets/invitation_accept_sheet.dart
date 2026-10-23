import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_form_field.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_validators.dart';
import 'package:Silink/features/employee_invitation/data/models/invitation_details_model.dart';
import 'package:Silink/features/employee_invitation/logic/employee_invitation_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationAcceptSheet extends StatefulWidget {
  const InvitationAcceptSheet({super.key, required this.employee});

  final InvitationEmployee employee;

  static Future<void> show(
    BuildContext context, {
    required EmployeeInvitationCubit cubit,
    required InvitationEmployee employee,
  }) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.primaryColor.themeColor.withValues(alpha: 0.55),
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: InvitationAcceptSheet(employee: employee),
        ),
      );

  @override
  State<InvitationAcceptSheet> createState() => _InvitationAcceptSheetState();
}

class _InvitationAcceptSheetState extends State<InvitationAcceptSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.employee.name);
  late final _emailController =
      TextEditingController(text: widget.employee.email);
  late final _phoneController =
      TextEditingController(text: widget.employee.phone);
  late final _positionController =
      TextEditingController(text: widget.employee.position);
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _confirm() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<EmployeeInvitationCubit>().accept(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          position: _positionController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  Widget _header() {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mintSoft.themeColor,
          ),
          child: Icon(
            Icons.verified_user_rounded,
            size: 28.sp,
            color: AppColors.brandGreen.themeColor,
          ),
        ),
        12.height,
        AppText(
          LocaleKeys.invitation_sheetTitle.tr(),
          fontSize: 17.sp,
          fontWeight: FontWeight.w800,
        ),
        6.height,
        AppText(
          LocaleKeys.invitation_sheetSubtitle.tr(),
          fontSize: 12.sp,
          height: 1.5,
          textAlign: TextAlign.center,
          color: AppColors.textSecondaryColor.themeColor,
        ),
      ],
    );
  }

  Widget _fields() {
    return Column(
      children: [
        EmployeeFormField(
          label: LocaleKeys.invitation_name.tr(),
          controller: _nameController,
          validator: EmployeeValidators.required,
        ),
        14.height,
        EmployeeFormField(
          label: LocaleKeys.invitation_email.tr(),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: EmployeeValidators.email,
        ),
        14.height,
        EmployeeFormField(
          label: LocaleKeys.invitation_phone.tr(),
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          validator: EmployeeValidators.required,
        ),
        14.height,
        EmployeeFormField(
          label: LocaleKeys.invitation_jobTitle.tr(),
          controller: _positionController,
          validator: EmployeeValidators.required,
        ),
        14.height,
        EmployeeFormField(
          label: LocaleKeys.invitation_password.tr(),
          hint: LocaleKeys.invitation_passwordHint.tr(),
          controller: _passwordController,
          isPassword: true,
          validator: EmployeeValidators.password,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.9.sh),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor.themeColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 8.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [_header(), 20.height, _fields()],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                child: BlocBuilder<EmployeeInvitationCubit,
                    EmployeeInvitationState>(
                  builder: (context, state) => CustomButton(
                    onTap: _confirm,
                    title: LocaleKeys.invitation_confirm.tr(),
                    loading: state is EmployeeInvitationSubmitting ||
                        state is EmployeeInvitationAccepted,
                    height: 52,
                    radius: 16,
                    color: AppColors.primaryColor.themeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
