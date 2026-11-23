import 'package:equatable/equatable.dart';

enum SocialProvider { google, apple }

class SocialCredential extends Equatable {
  const SocialCredential({
    required this.provider,
    required this.idToken,
    this.authorizationCode,
    this.fullName,
    this.email,
  });

  final SocialProvider provider;
  final String idToken;
  final String? authorizationCode;
  final String? fullName;
  final String? email;

  Map<String, dynamic> toJson() => {
        'idToken': idToken,
        if (authorizationCode != null) 'authorizationCode': authorizationCode,
        if (fullName != null && fullName!.isNotEmpty) 'fullName': fullName,
        if (email != null && email!.isNotEmpty) 'email': email,
      };

  @override
  List<Object?> get props =>
      [provider, idToken, authorizationCode, fullName, email];
}
