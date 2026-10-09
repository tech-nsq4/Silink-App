import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../auth/data/models/user_model.dart';
import '../data/account_repo.dart';

part 'account_edit_state.dart';

class AccountEditCubit extends Cubit<AccountEditState> {
  AccountEditCubit(this._repo) : super(const AccountEditInitial());

  final AccountRepo _repo;

  Future<void> updateProfile({
    required String name,
    required String phone,
    String? email,
    File? image,
  }) async {
    if (state is AccountEditLoading) return;
    emit(const AccountEditLoading());
    try {
      final user = await _repo.updateProfile(
        name: name,
        phone: phone,
        email: email,
        image: image,
      );
      AppOverlay.showSuccess(LocaleKeys.account_profileUpdated.tr());
      emit(AccountEditSuccess(user));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(AccountEditError(msg));
    }
  }
}
