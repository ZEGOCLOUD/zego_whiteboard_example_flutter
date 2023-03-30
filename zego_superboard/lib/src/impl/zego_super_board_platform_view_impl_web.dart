import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:html' as htmlPkg;
import 'dart:ui' as ui;
import 'dart:js' as js;

import 'package:zego_superboard/src/impl/zego_super_board_defines_web.dart';

/// Web implementation of [createPlatformView]
class ZegoSuperBoardPlatformViewImpl {
  /// Create a PlatformView and return the view ID
  static Widget? createSuperBoardView(Function(int viewID) onViewCreated,
      {Key? key}) {
    print("call createSuperBoardView method");
    String superboardElement = 'plugins.zego.im/zego_superboard_view';

    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        superboardElement,
            (int id) {
              final html = '<div><div id="zego-superboard-view-flutter"></div></div>';
              final element =  htmlPkg.Element.html(html);
              final script = htmlPkg.ScriptElement()
                ..text = 'document.getElementById("zego-superboard-view-flutter").style.height = "100%";';
              element.firstChild?.append(script);

              final resizeObserver = js.JsObject(js.context['ResizeObserver'], [
                js.JsFunction.withThis((_, entries, observer) {
                  ZegoSuperboardFlutterEngine.reloadView();
                })
              ]);
              resizeObserver.callMethod('observe', [element.firstChild]);

              return element;
            }
    );
    return HtmlElementView(
        key: key,
        viewType: superboardElement,
        onPlatformViewCreated: (int viewID) {
          onViewCreated(viewID);
        });
  }
}
