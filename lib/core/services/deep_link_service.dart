import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';

import '../../app/router/navigation_services.dart';
import '../../app/router/routes.dart';
import '../di/injection.dart';
import '../storage/local_storage.dart';

class DeepLinkService {
  DeepLinkService._();

  static const String _scheme = 'silink';
  static const String _webHost = 'silink-api.nasaq4.com';
  static const String _handledKey = 'last_handled_deep_link';
  static const String _invitationSegment = 'employee-invitations';

  static final AppLinks _appLinks = AppLinks();
  static String? _lastHandled;
  static DateTime? _lastHandledAt;
  static String? _pendingToken;
  static bool _ready = false;

  static bool isInvitationRoute(String? routeName) =>
      routeName != null && routeName.startsWith('/$_invitationSegment');

  static Future<void> init() async {
    WidgetsBinding.instance.addObserver(_SystemRouteBlocker());
    final initial = await _appLinks.getInitialLink();
    if (initial != null) await _handle(initial, coldStart: true);
    _appLinks.uriLinkStream.listen((uri) => _handle(uri, coldStart: false));
  }

  static String? invitationToken(Uri uri) {
    final isCustomScheme =
        uri.scheme == _scheme && uri.host == _invitationSegment;
    final isWebLink = (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host == _webHost &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == _invitationSegment;
    if (!isCustomScheme && !isWebLink) return null;
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return null;
    final token = segments.last;
    return token == _invitationSegment ? null : token;
  }

  static Future<void> clearHandled() =>
      getIt<LocalStorage>().remove(_handledKey);

  static void markReady() {
    _ready = true;
    final token = _pendingToken;
    _pendingToken = null;
    if (token != null) _openInvitation(token);
  }

  static Future<void> _handle(Uri uri, {required bool coldStart}) async {
    final token = invitationToken(uri);
    if (token == null) return;
    final storage = getIt<LocalStorage>();
    if (coldStart && storage.read<String>(_handledKey) == uri.toString()) {
      return;
    }
    await storage.write(_handledKey, uri.toString());
    final now = DateTime.now();
    final isDuplicate = _lastHandled == uri.toString() &&
        now.difference(_lastHandledAt ?? now) < const Duration(seconds: 3);
    if (isDuplicate) return;
    _lastHandled = uri.toString();
    _lastHandledAt = now;

    if (!_ready) {
      _pendingToken = token;
      return;
    }
    _openInvitation(token);
  }

  static void _openInvitation(String token) {
    if (NavigationService.navigationKey.currentContext == null) return;
    NavigationService.push(Routes.employeeInvitation,
        arguments: {'token': token});
  }
}

class _SystemRouteBlocker with WidgetsBindingObserver {
  @override
  Future<bool> didPushRouteInformation(
          RouteInformation routeInformation) async =>
      DeepLinkService.invitationToken(routeInformation.uri) != null;
}
