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
    ui.platformViewRegistry.registerViewFactory(superboardElement, (int id) {
      final html = '<div><div id="zego-superboard-view-flutter"></div></div>';
      final element = htmlPkg.Element.html(html);
      final script = htmlPkg.ScriptElement()
        ..text =
            'document.getElementById("zego-superboard-view-flutter").style.height = "100%";';
      element.firstChild?.append(script);

      final resizeObserver = js.JsObject(js.context['ResizeObserver'], [
        js.JsFunction.withThis((_, entries, observer) {
          ZegoSuperboardFlutterEngine.reloadView();
        })
      ]);
      resizeObserver.callMethod('observe', [element.firstChild]);

      return element;
    });

    return SuperBoardWebWidget(
      view: HtmlElementView(
          key: key,
          viewType: superboardElement,
          onPlatformViewCreated: (int viewID) {
            onViewCreated(viewID);
          }),
    );
  }
}

class SuperBoardWebWidget extends StatefulWidget {
  final HtmlElementView view;

  const SuperBoardWebWidget({Key? key, required this.view}) : super(key: key);

  @override
  _SuperBoardWebWidgetState createState() => _SuperBoardWebWidgetState();
}

class _SuperBoardWebWidgetState extends State<SuperBoardWebWidget> {
  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        final renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        ZegoSuperboardFlutterEngine.onWidgetPosition(position.dx, position.dy);
      },
      child: Container(
        key: _widgetKey,
        child: widget.view,
      ),
    );
  }
}
