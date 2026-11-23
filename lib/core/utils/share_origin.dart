import 'package:flutter/widgets.dart';

import '../../app/router/navigation_services.dart';

class ShareOrigin {
  ShareOrigin._();

  static Rect of([BuildContext? context]) {
    final renderObject = context?.findRenderObject();
    if (renderObject is RenderBox &&
        renderObject.hasSize &&
        !renderObject.size.isEmpty) {
      return renderObject.localToGlobal(Offset.zero) & renderObject.size;
    }
    return _screenCenter();
  }

  static Rect _screenCenter() {
    final rootContext = NavigationService.navigationKey.currentContext;
    final screen = rootContext == null
        ? const Size(1, 1)
        : MediaQuery.sizeOf(rootContext);
    return Rect.fromCenter(
      center: Offset(screen.width / 2, screen.height / 2),
      width: 1,
      height: 1,
    );
  }
}
