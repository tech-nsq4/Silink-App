import 'package:Silink/core/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../../features/auth/data/models/user_model.dart';
import '../../../features/profile/logic/profile_cubit.dart';
import '../widgets/account_avatar.dart';
import '../widgets/account_edit_field.dart';

class AccountEditScreen extends StatefulWidget {
  final UserModel user;
  const AccountEditScreen({super.key, required this.user});

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    final u = widget.user;
    _nameCtrl = TextEditingController(text: u.fullName);
    _phoneCtrl = TextEditingController(text: u.phone);
    _emailCtrl = TextEditingController(text: u.email ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  UserModel _buildEditedUser() => UserModel(
        id: widget.user.id,
        fullName: _nameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        photoUrl: widget.user.photoUrl,
        status: widget.user.status,
        createdAt: widget.user.createdAt,
      );

  void _save() {
    context.read<ProfileCubit>().setUser(_buildEditedUser());
    AppOverlay.showSuccess(LocaleKeys.stats_saved.tr());
    context.pop();
  }
GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          children: [
            ScreenHeaderBar(
              title: LocaleKeys.account_editTitle.tr(),
              trailing: InkWell(
                onTap: _save,
                child: Container(
                  padding: 16.paddingHorizontal + 4.paddingVert,
                  decoration: BoxDecoration(
                    color: AppColors.successColor.themeColor
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: AppText(
                    LocaleKeys.stats_saved.tr(),
                    color: AppColors.successColor.themeColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: AccountAvatar(
                        badge: true,
                        initial:
                            _nameCtrl.text.isEmpty ? '' : _nameCtrl.text[0],
                      ),
                    ),
                    24.height,
                    AccountEditField(
                      label: LocaleKeys.account_fullName.tr(),
                      hint: LocaleKeys.account_fullName.tr(),
                      controller: _nameCtrl,
                    ),
                    16.height,
                    AccountEditField(
                      label: LocaleKeys.auth_phone.tr(),
                      hint: LocaleKeys.account_phoneHint.tr(),
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                    ),
                    16.height,
                    AccountEditField(
                      label: LocaleKeys.account_email.tr(),
                      hint: LocaleKeys.account_emailHint.tr(),
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _divider(),
                    AppText(
                      LocaleKeys.auth_password.tr(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    12.height,
                    CustomButton(
                      onTap: _save,
                      color: AppColors.backgroundColor.themeColor,
                      borderColor: AppColors.borderColor.themeColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppImages.iconsLock),
                          6.width,
                          AppText(
                            LocaleKeys.account_changePassword.tr(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mint.themeColor,
                          ),
                        ],
                      ),
                    ),
                    _divider(),
                    AppText(
                      LocaleKeys.account_editNote.tr(),
                      fontSize: 12.sp,
                      textAlign: TextAlign.center,
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _divider() {
    return Padding(
      padding: 24.paddingVert,
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.dividerColor.themeColor.withValues(alpha: 0.6),
      ),
    );
  }
}
