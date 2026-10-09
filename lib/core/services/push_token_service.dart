import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushTokenService {
  bool? _available;

  Future<bool> _ensureInitialized() async {
    final available = _available;
    if (available != null) return available;
    try {
      if (Firebase.apps.isEmpty) await Firebase.initializeApp();
      return _available = true;
    } catch (_) {
      return _available = false;
    }
  }

  Future<String?> getToken() async {
    if (!await _ensureInitialized()) return null;
    try {
      await FirebaseMessaging.instance.requestPermission();
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  Stream<String> get onTokenRefresh => _available == true
      ? FirebaseMessaging.instance.onTokenRefresh
      : const Stream.empty();
}
