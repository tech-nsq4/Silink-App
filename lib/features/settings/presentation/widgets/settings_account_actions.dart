import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../profile/logic/profile_cubit.dart';
import 'settings_confirm_dialog.dart';

class SettingsAccountActions {
  SettingsAccountActions._();

  static Future<void> logout(BuildContext context) async {
    final confirmed = await SettingsConfirmDialog.show(
      context,
      title: LocaleKeys.settings_logout.tr(),
      message: LocaleKeys.settings_logoutConfirm.tr(),
    );
    if (!confirmed || !context.mounted) return;
    context.read<ProfileCubit>().reset();
    await context.read<AuthCubit>().logout();
    if (!context.mounted) return;
    context.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      predicate: (_) => false,
    );
  }

  static Future<void> deleteAccount(BuildContext context) async {
    final confirmed = await SettingsConfirmDialog.show(
      context,
      title: LocaleKeys.settings_deleteAccount.tr(),
      message: LocaleKeys.settings_deleteAccountConfirm.tr(),
    );
    if (confirmed) AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
  }
}
