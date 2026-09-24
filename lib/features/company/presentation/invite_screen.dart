import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _jobCtrl = TextEditingController();
  final _deptCtrl = TextEditingController();

  bool _loading = false;
  String? _sentName;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _jobCtrl.dispose();
    _deptCtrl.dispose();
    super.dispose();
  }

  bool get _valid =>
      _nameCtrl.text.trim().isNotEmpty &&
      _emailCtrl.text.trim().isNotEmpty &&
      _jobCtrl.text.trim().isNotEmpty;

  Future<void> _submit() async {
    if (!_valid) return;
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _loading = false;
      _sentName = _nameCtrl.text.trim();
    });
  }

  void _reset() {
    setState(() {
      _sentName = null;
      _nameCtrl.clear();
      _emailCtrl.clear();
      _phoneCtrl.clear();
      _jobCtrl.clear();
      _deptCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.company_invite_title.tr(),
          ),
          Expanded(
            child: _sentName != null
                ? _buildSuccess()
                : SingleChildScrollView(
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
                        _field(
                          LocaleKeys.company_full_name_star.tr(),
                          _nameCtrl,
                        ),
                        14.height,
                        _field(
                          LocaleKeys.company_email_star.tr(),
                          _emailCtrl,
                          keyboard: TextInputType.emailAddress,
                        ),
                        14.height,
                        _field(
                          LocaleKeys.company_phone_number.tr(),
                          _phoneCtrl,
                          hint: '+966 5X XXX XXXX',
                          keyboard: TextInputType.phone,
                        ),
                        14.height,
                        _field(
                          LocaleKeys.company_job_title_star.tr(),
                          _jobCtrl,
                        ),
                        14.height,
                        _field(
                          LocaleKeys.company_department.tr(),
                          _deptCtrl,
                          hint: LocaleKeys.company_department_hint.tr(),
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
          onTap: () {
            if (_valid && !_loading) _submit();
          },
          title: LocaleKeys.company_send_invite.tr(),
          height: 48,
          radius: 14,
          color: _valid && !_loading ? null : Color(0xFFcbd5e1),
          loading: _loading,
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    String? hint,
    TextInputType? keyboard,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, fontSize: 13.sp, fontWeight: FontWeight.w600),
        8.height,
        CustomTextField(
          hint: hint ?? '',
          controller: ctrl,
          keyboardType: keyboard,
          onChanged: (_) => setState(() {}),
          borderColor: AppColors.borderColor.themeColor,
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFF0FDFA), Color(0xFFDCFCE7)],
                ),
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 42.sp,
                color: const Color(0xFF0D9488),
              ),
            ),
            20.height,
            AppText(
              LocaleKeys.company_invite_sent.tr(),
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
            8.height,
            AppText(
              LocaleKeys.company_invite_sent_desc.tr(args: [_sentName ?? '']),
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
              height: 1.5,
            ),
            28.height,
            CustomButton(
              onTap: () => NavigationService.pushNamedAndRemoveUntil(
                Routes.companyEmployees,
              ),
              title: LocaleKeys.company_view_employees_list.tr(),
              height: 48,
              radius: 14,
              color: AppColors.blue.themeColor,
              fontSize: 15,
            ),
            12.height,
            CustomButton(
              onTap: _reset,
              title: LocaleKeys.company_invite_another.tr(),
              isOutlined: true,
              color: Colors.transparent,
              borderColor: AppColors.borderColor.themeColor,
              textColor: AppColors.textPrimaryColor.themeColor,
              height: 48,
              radius: 14,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
