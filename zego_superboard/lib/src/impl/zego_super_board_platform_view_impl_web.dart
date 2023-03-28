import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;

/// Web implementation of [createPlatformView]
class ZegoSuperBoardPlatformViewImpl {
  /// Create a PlatformView and return the view ID
  static Widget? createSuperBoardView(Function(int viewID) onViewCreated,
      {Key? key}) {
    print("call createSuperBoardView method");
    String superboardElement = 'plugins.zego.im/zego_superboard_view';

    final width = 200;
    final height = 300;

    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        superboardElement,
            (int id) => DivElement()
          ..id = "zego-superboard-view-flutter"
              ..style.width = "500px"
              ..style.height = "500px",
    );
    return HtmlElementView(
        key: key,
        viewType: superboardElement,
        onPlatformViewCreated: (int viewID) {
          onViewCreated(viewID);
        });
  }
}
