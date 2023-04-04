// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:zego_superboard/src/impl/zego_super_board_defines_web.dart';

import 'src/zego_super_board_engine.dart';

/// A web implementation of the ZegoSuperwhiteboardPlatform of the ZegoSuperwhiteboard plugin.
class ZegoSuperBoardWeb {
  /// Constructs a ZegoSuperwhiteboardWeb
  static final StreamController _evenController = StreamController();
  static var isCustomCursorEnabled = false;
  static var isEnableResponseScale = false;
  static var isEnableSyncScale = false;
  static var isRemoteCursorVisibleEnabled = false;

  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'plugins.zego.im/zego_superboard',
      const StandardMethodCodec(),
      registrar,
    );

    // ignore: unused_local_variable
    final eventChannel = PluginEventChannel(
        'plugins.zego.im/zego_superboard_event_handler',
        const StandardMethodCodec(),
        registrar);

    final pluginInstance = ZegoSuperBoardWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
    eventChannel.setController(ZegoSuperBoardWeb._evenController);

    _evenController.stream.listen((event) {
      _eventListener(event);
    });

    // var element = ScriptElement()
    //   ..src = 'assets/packages/zego_superboard/assets/ZegoSuperboardWebFlutterWrapper.js'//'assets/ZegoSuperboardWebFlutterWrapper.js'
    //   ..type = 'application/javascript';
    // document.body!.append(element);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {

    switch (call.method) {
      case 'init':
        ZegoSuperboardFlutterEngine.setEventHandler(
            allowInterop((String event, String data) {
              _evenController.add({'methodName': event, 'data': data});
            }));
        return initWithConfig(json.encode(call.arguments["config"]));
      case 'uninit':
        return ZegoSuperboardFlutterEngine.uninit();
      case 'getSDKVersion':
        return ZegoSuperboardFlutterEngine.getSDKVersion();
      case 'clearCache':
        return ZegoSuperboardFlutterEngine.clearCache();
      case 'clear':
        return ZegoSuperboardFlutterEngine.clear();
      case 'renewToken':
        return ZegoSuperboardFlutterEngine.renewToken(call.arguments["token"]);
      case 'enableRemoteCursorVisible':
        ZegoSuperBoardWeb.isCustomCursorEnabled = call.arguments["visible"];
        return ZegoSuperboardFlutterEngine.enableRemoteCursorVisible(call.arguments["visible"]);
      case 'isCustomCursorEnabled':
        return ZegoSuperBoardWeb.isCustomCursorEnabled;
      case 'isEnableResponseScale':
        return ZegoSuperBoardWeb.isEnableResponseScale;
      case 'isEnableSyncScale':
        return ZegoSuperBoardWeb.isEnableSyncScale;
      case 'isRemoteCursorVisibleEnabled':
        return ZegoSuperBoardWeb.isRemoteCursorVisibleEnabled;
      case 'setCustomizedConfig':
        return ZegoSuperboardFlutterEngine.setCustomizedConfig(json.encode(call.arguments));
      case 'createWhiteboardView':
        return createWhiteboardView(json.encode(call.arguments["config"]));
      case 'createFileView':
        return createFileView(call.arguments["config"]["fileID"]);
      case 'destroySuperBoardSubView':
        return destroySuperBoardSubView(call.arguments["uniqueID"]);
      case 'querySuperBoardSubViewList':
        return querySuperBoardSubViewList();
      case 'getSuperBoardSubViewModelList':
        return getSuperBoardSubViewModelList();
      case 'enableSyncScale':
        ZegoSuperBoardWeb.isEnableSyncScale = call.arguments["enable"];
        return ZegoSuperboardFlutterEngine.enableSyncScale(call.arguments["enable"]);
      case 'enableResponseScale':
        ZegoSuperBoardWeb.isEnableResponseScale = call.arguments["enable"];
        return ZegoSuperboardFlutterEngine.enableResponseScale(call.arguments["enable"]);
      case 'setToolType':
        return ZegoSuperboardFlutterEngine.setToolType(call.arguments["tool"]);
      case 'getToolType':
        return ZegoSuperboardFlutterEngine.getToolType();
      case 'setFontBold':
        return ZegoSuperboardFlutterEngine.setFontBold(call.arguments["bold"]);
      case 'isFontBold':
        return ZegoSuperboardFlutterEngine.isFontBold();
      case 'setFontItalic':
        return ZegoSuperboardFlutterEngine.setFontItalic(call.arguments["italic"]);
      case 'isFontItalic':
        return ZegoSuperboardFlutterEngine.isFontItalic();
      case 'setFontSize':
        return ZegoSuperboardFlutterEngine.setFontSize(call.arguments["size"]);
      case 'getFontSize':
        return ZegoSuperboardFlutterEngine.getFontSize();
      case 'setBrushSize':
        return ZegoSuperboardFlutterEngine.setBrushSize(call.arguments["size"]);
      case 'getBrushSize':
        return ZegoSuperboardFlutterEngine.getBrushSize();
      case 'setBrushColor':
        return ZegoSuperboardFlutterEngine.setBrushColor(call.arguments["color"]);
      case 'getBrushColor':
        return ZegoSuperboardFlutterEngine.getBrushColor();
      case 'switchSuperBoardSubView':
        return switchSuperBoardSubView(call.arguments["uniqueID"]);
      case 'getThumbnailUrlList':
        return getThumbnailUrlList();
      case 'getModel':
        final result = ZegoSuperboardFlutterEngine.getModel();
        Map<dynamic, dynamic> myMap = json.decode(result);
        return myMap;
      case 'inputText':
        return ZegoSuperboardFlutterEngine.inputText();
      case 'addText':
        return addText(json.encode(call.arguments));
      case 'undo':
        return ZegoSuperboardFlutterEngine.undo();
      case 'redo':
        return ZegoSuperboardFlutterEngine.redo();
      case 'clearCurrentPage':
        return ZegoSuperboardFlutterEngine.clearCurrentPage();
      case 'clearAllPage':
        return ZegoSuperboardFlutterEngine.clearAllPage();
      case 'setOperationMode':
        return ZegoSuperboardFlutterEngine.setOperationMode(call.arguments["mode"]);
      case 'flipToPage':
        final result = ZegoSuperboardFlutterEngine.flipToPage(call.arguments["targetPage"]);
        final errorCode = result ? 0 : 1;
        return {"errorCode": errorCode};
      case 'flipToPrePage':
        final result = ZegoSuperboardFlutterEngine.flipToPrePage();
        final errorCode = result ? 0 : 1;
        return {"errorCode": errorCode};
      case 'flipToNextPage':
        final result = ZegoSuperboardFlutterEngine.flipToNextPage();
        final errorCode = result ? 0 : 1;
        return {"errorCode": errorCode};
      case 'getCurrentPage':
        return ZegoSuperboardFlutterEngine.getCurrentPage();
      case 'getPageCount':
        return ZegoSuperboardFlutterEngine.getPageCount();
      case 'getVisibleSize':
        final result = ZegoSuperboardFlutterEngine.getVisibleSize();
        print("getVisibleSize:" + result.toString());
        Map<dynamic, dynamic> myMap = json.decode(result);
        return myMap;
      case 'clearSelected':
        ZegoSuperboardFlutterEngine.clearSelected();
        return {"errorCode": 0};
      case 'setWhiteboardBackgroundColor':
        final result = ZegoSuperboardFlutterEngine.setWhiteboardBackgroundColor(call.arguments["color"]);
        print("setWhiteboardBackgroundColor" + result.toString());
        final errorCode = result ? 0 : -1;
        return {"errorCode": errorCode};
      case 'setScaleFactor':
        return ZegoSuperboardFlutterEngine.setScaleFactor(call.arguments["scaleFactor"]);
      default:
        break;
    }
  }

  Future<Map<dynamic, dynamic>> initWithConfig(String config) async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.initWithConfig(config, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();

    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> createWhiteboardView(String config) async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.createWhiteboardView(config, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> createFileView(String fileID) async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.createFileView(fileID, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> querySuperBoardSubViewList() async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.querySuperBoardSubViewList(completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<List<dynamic>> getSuperBoardSubViewModelList() async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.querySuperBoardSubViewList(completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap["subViewModelList"]);
  }

  Future<Map<dynamic, dynamic>> destroySuperBoardSubView(String uniqueID) async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.destroySuperBoardSubView(uniqueID, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    if (result == null || !(result is Map)) return {"errorCode": -1};
    return Future.value(result);
  }

  Future<Map<dynamic, dynamic>> switchSuperBoardSubView(String uniqueID) async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.switchSuperBoardSubView(uniqueID, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    if (result == null || !(result is Map)) return {"errorCode": -1};
    return Future.value(result);
  }

  Future<List> getThumbnailUrlList() async {
    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.getThumbnailUrlList(completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    if (result == null || !(result is List)) return [];
    return Future.value(result as FutureOr<List>?);
  }

  Future<Map<dynamic, dynamic>> addText(String config) async {

    var result;
    result = await (() {
      Map completerMap = _createCompleter();
      ZegoSuperboardFlutterEngine.addText(config, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    if (result == null || !(result is Map)) return {"errorCode": -1};
    return Future.value(result);
  }

  static _createCompleter() {
    Completer completer = Completer();
    return {
      'completer': completer,
      "success": allowInterop((res) {
        completer.complete(res);
      }),
      "fail": allowInterop((err) {
        completer.completeError(err);
      })
    };
  }

  static void _eventListener(dynamic event) {
    final Map<dynamic, dynamic> map = event;
    final data = jsonDecode(map["data"]);
    var methodName = map["methodName"];
    switch (methodName) {
      case 'onError':
        if (ZegoSuperBoardEngine.onError == null) return;
        ZegoSuperBoardEngine.onError!(data['errorCode']);
        break;
      case 'onRemoteSuperBoardSubViewAdded':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewAdded == null) return;
        Map<String, dynamic> jsonMap = jsonDecode(data['subViewModel']);
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewAdded!(jsonMap);
        break;
      case 'onRemoteSuperBoardSubViewRemoved':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewRemoved == null)
          return;
        Map<String, dynamic> jsonMap = jsonDecode(data['subViewModel']);
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewRemoved!(jsonMap);
        break;
      case 'onRemoteSuperBoardSubViewSwitched':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewSwitched == null)
          return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewSwitched!(data['uniqueID']);
        break;
      case 'onRemoteSuperBoardAuthChanged':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardAuthChanged == null) return;
        ZegoSuperBoardEngine.onRemoteSuperBoardAuthChanged!(data['authInfo']);
        break;
      case 'onRemoteSuperBoardGraphicAuthChanged':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardGraphicAuthChanged == null)
          return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardGraphicAuthChanged!(data['authInfo']);
        break;
      case 'onSuperBoardSubViewScrollChanged':
        if (ZegoSuperBoardEngine.onSuperBoardSubViewScrollChanged == null)
          return;
        ZegoSuperBoardEngine
            .onSuperBoardSubViewScrollChanged!(data['uniqueID'], data['page']);
        break;
      case 'onSuperBoardSubViewScaleChanged':
        if (ZegoSuperBoardEngine.onSuperBoardSubViewScaleChanged == null)
          return;
        ZegoSuperBoardEngine
            .onSuperBoardSubViewScaleChanged!(data['uniqueID'], data['authscaleInfo']);
        break;
      default:
      // TODO: Unknown callback
        break;
    }
  }
}
