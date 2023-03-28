// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html show window;
import 'dart:html';
import 'dart:js';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:zego_superboard/src/impl/zego_super_board_defines_web.dart';

import 'src/zego_super_board_engine.dart';

/// A web implementation of the ZegoSuperwhiteboardPlatform of the ZegoSuperwhiteboard plugin.
class ZegoSuperBoardWeb {
  /// Constructs a ZegoSuperwhiteboardWeb
  static final StreamController _evenController = StreamController();
  static void registerWith(Registrar registrar) {
    print("=====Regester web channel");
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

    var element = ScriptElement()
      ..src = 'assets/ZegoSuperboardWebFlutterWrapper.js'
      ..type = 'application/javascript';
    document.body!.append(element);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {

    switch (call.method) {
      case 'init':
        // ZegoSuperboardFlutterEngine.setEventHandler(
        //     allowInterop((String event, String data) {
        //       _evenController.add({'methodName': event, 'data': data});
        //     }));
        // var result = await ZegoSuperboardFlutterEngine.initWithConfig();
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
        return ZegoSuperboardFlutterEngine.enableRemoteCursorVisible(call.arguments["visible"]);
      case 'isCustomCursorEnabled':
        return ZegoSuperboardFlutterEngine.isCustomCursorEnabled();
      case 'isEnableResponseScale':
        return ZegoSuperboardFlutterEngine.isEnableResponseScale();
      case 'isEnableSyncScale':
        return ZegoSuperboardFlutterEngine.isEnableSyncScale();
      case 'isRemoteCursorVisibleEnabled':
        return ZegoSuperboardFlutterEngine.isRemoteCursorVisibleEnabled();
      case 'setCustomizedConfig':
        return ZegoSuperboardFlutterEngine.setCustomizedConfig(call.arguments);
      case 'createWhiteboardView':
        return createWhiteboardView(json.encode(call.arguments["config"]));
      case 'createFileView':
        return createFileView(call.arguments["config"]["fileID"]);
      case 'destroySuperBoardSubView':
        return ZegoSuperboardFlutterEngine.destroySuperBoardSubView(call.arguments["uniqueID"]);
      case 'querySuperBoardSubViewList':
        return querySuperBoardSubViewList();
      case 'getSuperBoardSubViewModelList':
        return getSuperBoardSubViewModelList();
      case 'enableSyncScale':
        return ZegoSuperboardFlutterEngine.enableSyncScale(call.arguments["enable"]);
      case 'enableResponseScale':
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
        return ZegoSuperboardFlutterEngine.getThumbnailUrlList();
      case 'inputText':
        return ZegoSuperboardFlutterEngine.inputText();
      case 'addText':
        return ZegoSuperboardFlutterEngine.addText(call.arguments);
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
        return ZegoSuperboardFlutterEngine.flipToPage(call.arguments["targetPage"]);
      case 'flipToPrePage':
        return ZegoSuperboardFlutterEngine.flipToPrePage();
      case 'flipToNextPage':
        return ZegoSuperboardFlutterEngine.flipToNextPage();
      case 'getCurrentPage':
        return ZegoSuperboardFlutterEngine.getCurrentPage();
      case 'getPageCount':
        return ZegoSuperboardFlutterEngine.getPageCount();
      case 'getVisibleSize':
        return ZegoSuperboardFlutterEngine.getVisibleSize();
      case 'clearSelected':
        return ZegoSuperboardFlutterEngine.clearSelected();
      case 'setWhiteboardBackgroundColor':
        return ZegoSuperboardFlutterEngine.setWhiteboardBackgroundColor(call.arguments["color"]);
      default:
        break;
    }
  }

  Future<Map<dynamic, dynamic>> initWithConfig(String config) async {
    var result;
    result = await (() {
      Map completerMap = createCompleter();
      ZegoSuperboardFlutterEngine.initWithConfig(config, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();

    print("+++++++++ Call Web init Method:" + config);
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> createWhiteboardView(String config) async {
    var result;
    result = await (() {
      Map completerMap = createCompleter();
      ZegoSuperboardFlutterEngine.createWhiteboardView(config, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    print("+++++++++ createWhiteboardView:" + result);
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> createFileView(String fileID) async {
    var result;
    result = await (() {
      Map completerMap = createCompleter();
      ZegoSuperboardFlutterEngine.createFileView(fileID, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    print("+++++++++ createFileView:" + result);
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> querySuperBoardSubViewList() async {
    var result;
    result = await (() {
      Map completerMap = createCompleter();
      ZegoSuperboardFlutterEngine.querySuperBoardSubViewList(completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    print("+++++++++ querySuperBoardSubViewList:" + result);
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> getSuperBoardSubViewModelList() async {
    var result;
    result = await (() {
      Map completerMap = createCompleter();
      ZegoSuperboardFlutterEngine.querySuperBoardSubViewList(completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    print("+++++++++ getSuperBoardSubViewModelList:" + result);
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  Future<Map<dynamic, dynamic>> switchSuperBoardSubView(String uniqueID) async {
    var result;
    result = await (() {
      Map completerMap = createCompleter();
      ZegoSuperboardFlutterEngine.switchSuperBoardSubView(uniqueID, completerMap["success"], completerMap["fail"]);
      return completerMap["completer"].future;
    })();
    print("+++++++++ getSuperBoardSubViewModelList:" + result);
    Map<dynamic, dynamic> myMap = json.decode(result);
    return Future.value(myMap);
  }

  static createCompleter() {
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
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewAdded!(data['subViewModel']);
        break;
      case 'onRemoteSuperBoardSubViewRemoved':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewRemoved == null)
          return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewRemoved!(data['subViewModel']);
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
      default:
      // TODO: Unknown callback
        break;
    }
  }
}
