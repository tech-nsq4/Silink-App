import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../features/auth/data/models/social_credential.dart';

class SocialAuthService {
  bool _googleReady = false;

  Future<SocialCredential?> signInWithGoogle() async {
    if (!_googleReady) {
      await GoogleSignIn.instance.initialize();
      _googleReady = true;
    }
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) throw StateError('Google idToken is null');
      return SocialCredential(
        provider: SocialProvider.google,
        idToken: idToken,
        fullName: account.displayName,
        email: account.email,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  Future<SocialCredential?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final idToken = credential.identityToken;
      if (idToken == null) throw StateError('Apple identityToken is null');
      final name = [credential.givenName, credential.familyName]
          .whereType<String>()
          .where((part) => part.isNotEmpty)
          .join(' ');
      return SocialCredential(
        provider: SocialProvider.apple,
        idToken: idToken,
        authorizationCode: credential.authorizationCode,
        fullName: name.isEmpty ? null : name,
        email: credential.email,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return null;
      rethrow;
    }
  }

  static bool get isAppleAvailable => Platform.isIOS || Platform.isMacOS;
}
