import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/services/social_auth_service.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/auth_repo.dart';
import '../data/models/social_credential.dart';
import '../data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo, this._social) : super(const AuthInitial());

  final AuthRepo _repo;
  final SocialAuthService _social;

  Future<void> socialLogin(SocialProvider provider) async {
    emit(const AuthLoading());
    try {
      final credential = provider == SocialProvider.google
          ? await _social.signInWithGoogle()
          : await _social.signInWithApple();
      if (credential == null) {
        emit(const AuthInitial());
        return;
      }
      final user = await _repo.socialLogin(credential);
      kUserModel = user;
      emit(AuthSuccess(user));
    } catch (e) {
      final msg = e is NetworkException
          ? e.message
          : LocaleKeys.auth_socialSignInFailed.tr();
      AppOverlay.showError(msg);
      emit(AuthError(msg));
    }
  }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.login(phone: phone, password: password);
      kUserModel = user;
      emit(AuthSuccess(user));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(AuthError(msg));
    }
  }

  Future<void> registerCompany({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final ticket = await _repo.registerCompany(
        fullName: fullName,
        phone: phone,
        email: email,
        password: password,
      );
      emit(AuthRegistrationPending(
        registrationId: ticket.registrationId,
        phone: ticket.phone,
        expiresAt: ticket.expiresAt,
      ));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(AuthError(msg));
    }
  }

  Future<void> registerPersonal({
    required String usageIntent,
    required String profileType,
    required String fullName,
    required String jobTitle,
    String? company,
    String? bio,
    String? address,
    double? lat,
    double? lng,
    required String phone,
    String? email,
    String? password,
    File? photo,
  }) async {
    emit(const AuthLoading());
    try {
      final ticket = await _repo.registerPersonal(
        usageIntent: usageIntent,
        profileType: profileType,
        fullName: fullName,
        jobTitle: jobTitle,
        company: company,
        bio: bio,
        address: address,
        lat: lat,
        lng: lng,
        phone: phone,
        email: email,
        password: password,
        photo: photo,
      );
      emit(AuthRegistrationPending(
        registrationId: ticket.registrationId,
        phone: ticket.phone,
        expiresAt: ticket.expiresAt,
      ));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(AuthError(msg));
    }
  }

  Future<void> verifyOtp({
    required String registrationId,
    required String code,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.verifyOtp(
        registrationId: registrationId,
        code: code,
      );
      kUserModel = user;
      emit(AuthSuccess(user));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(AuthError(msg));
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    emit(const AuthInitial());
  }
}
