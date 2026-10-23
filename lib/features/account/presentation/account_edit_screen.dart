import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/photo_source_sheet.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../auth/data/models/user_model.dart';
import '../../profile/logic/profile_cubit.dart';
import '../logic/account_edit_cubit.dart';
import '../widgets/account_avatar.dart';
import '../widgets/account_edit_field.dart';
import '../widgets/account_save_chip.dart';
import '../widgets/account_section_divider.dart';

class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _formKey = GlobalKey<FormState>();
  late final AccountEditCubit _cubit = getIt<AccountEditCubit>();
  late final TextEditingController _nameCtrl =
      TextEditingController(text: widget.user.fullName)..addListener(_refresh);
  late final TextEditingController _phoneCtrl =
      TextEditingController(text: widget.user.phone);
  late final TextEditingController _emailCtrl =
      TextEditingController(text: widget.user.email ?? '');
  File? _image;

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.trim().isEmpty)
          ? LocaleKeys.validation_required.tr()
          : null;

  String? _emailValidator(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty || _emailPattern.hasMatch(text)) return null;
    return LocaleKeys.validation_invalidEmail.tr();
  }

  Future<void> _pickPhoto() async {
    final source = await PhotoSourceSheet.show(context);
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() => _image = File(picked.path));
    } catch (_) {
      if (!mounted) return;
      AppOverlay.showError(
        LocaleKeys.profile_type_basic_info_photo_pick_error.tr(),
      );
    }
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _cubit.updateProfile(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      image: _image,
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = _nameCtrl.text.trim();
    return BlocConsumer<AccountEditCubit, AccountEditState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is AccountEditSuccess) {
          context.read<ProfileCubit>().setUser(state.user);
          context.pop();
        }
      },
      builder: (context, state) {
        final loading = state is AccountEditLoading;
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                ScreenHeaderBar(
                  title: LocaleKeys.account_editTitle.tr(),
                  trailing: AccountSaveChip(
                    label: LocaleKeys.clients_save.tr(),
                    loading: loading,
                    onTap: _save,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: AccountAvatar(
                            imageUrl: widget.user.photoUrl,
                            imageFile: _image,
                            initial: name.isEmpty ? '' : name.characters.first,
                            onEditTap: loading ? null : _pickPhoto,
                          ),
                        ),
                        24.height,
                        AccountEditField(
                          label: LocaleKeys.account_fullName.tr(),
                          hint: LocaleKeys.account_fullName.tr(),
                          controller: _nameCtrl,
                          validator: _requiredValidator,
                        ),
                        16.height,
                        AccountEditField(
                          label: LocaleKeys.auth_phone.tr(),
                          hint: LocaleKeys.account_phoneHint.tr(),
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          validator: _requiredValidator,
                        ),
                        16.height,
                        AccountEditField(
                          label: LocaleKeys.account_email.tr(),
                          hint: LocaleKeys.account_emailHint.tr(),
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: _emailValidator,
                        ),
                        const AccountSectionDivider(),
                        AppText(
                          LocaleKeys.auth_password.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        12.height,
                        CustomButton(
                          onTap: () =>
                              context.pushNamed(Routes.changePasswordScreen),
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
                        const AccountSectionDivider(),
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
      },
    );
  }
}
