import 'dart:ui_web' as ui;

void registerViewFactory(String viewId, dynamic cb) {
  ui.platformViewRegistry.registerViewFactory(viewId, cb);
}
