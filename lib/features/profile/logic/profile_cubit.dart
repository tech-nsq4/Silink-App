import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/services/push_token_service.dart';
import '../../../core/utils/app_constants.dart';
import '../../../features/auth/data/auth_repo.dart';
import '../../../features/auth/data/models/user_model.dart';
import '../../account/data/account_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo, this._accountRepo, this._pushTokenService)
      : super(const ProfileInitial());

  final AuthRepo _repo;
  final AccountRepo _accountRepo;
  final PushTokenService _pushTokenService;
  String? _uploadedFcmToken;
  StreamSubscription<String>? _tokenRefreshSub;

  Future<void> getProfile() async {
    emit(const ProfileLoading());
    try {
      final user = await _repo.getProfile();
      kUserModel = user;
      emit(ProfileSuccess(user));
    } catch (e) {
      // Any profile fetch failure should drop cached user in app-wide guest checks.
      kUserModel = null;
      final msg = e is NetworkException ? e.message : e.toString();
      emit(ProfileError(msg));
    }
  }

  Future<void> registerFcmToken() async {
    final token = await _pushTokenService.getToken();
    print('Fcm Token: $token');
    if (token != null) await _uploadFcmToken(token);
    _tokenRefreshSub ??=
        _pushTokenService.onTokenRefresh.listen(_uploadFcmToken);
  }

  Future<void> _uploadFcmToken(String token) async {
    if (token.isEmpty || token == _uploadedFcmToken || kUserModel == null) {
      return;
    }
    try {
      await _accountRepo.updateFcmToken(token);
      _uploadedFcmToken = token;
    } catch (_) {}
  }

  void setUser(UserModel user) {
    kUserModel = user;
    emit(ProfileSuccess(user));
  }

  void reset() {
    kUserModel = null;
    _uploadedFcmToken = null;
    emit(const ProfileInitial());
  }

  @override
  Future<void> close() {
    _tokenRefreshSub?.cancel();
    return super.close();
  }
}
