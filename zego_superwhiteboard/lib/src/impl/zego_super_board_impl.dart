import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../zego_super_board_api.dart';
import '../zego_super_board_defines.dart';
import '../zego_super_board_enum_extension.dart';
import '../utils/zego_super_board_utils.dart';

// ignore_for_file: deprecated_member_use_from_same_package, curly_braces_in_flow_control_structures

class Global {
  static String pluginVersion = "0.0.1";
}

class ZegoSuperBoardImpl {
  /// Method Channel
  static const MethodChannel _channel =
      MethodChannel('plugins.zego.im/zego_superwhiteboard');
  static const EventChannel _event =
      EventChannel('plugins.zego.im/zego_superwhiteboard_event_handler');

  /// Used to receive the native event stream
  static StreamSubscription<dynamic>? _streamSubscription;

  /// Private constructor
  ZegoSuperBoardImpl._internal();

  /// Singleton instance
  static final ZegoSuperBoardImpl instance = ZegoSuperBoardImpl._internal();

  /// Exposing methodChannel to other files
  static MethodChannel get methodChannel => _channel;

  // is create engine
  static bool isEngineCreated = false;

  // enablePlatformView
  static bool _enablePlatformView = false;

  static bool shouldUsePlatformView() {
    bool use = ZegoSuperBoardImpl._enablePlatformView;
    // Web only supports PlatformView
    use |= kIsWeb;
    // TODO: PlatformView support on Windows has not yet been implemented
    // Ref: https://github.com/flutter/flutter/issues/31713
    use &= !kIsWindows;
    // TODO: PlatformView support on macOS has a crash issue, don't use it now
    // Ref: https://github.com/flutter/flutter/issues/96668
    use &= !kIsMacOS;
    return use;
  }

  /* Main */

  static Future<int> init(ZegoSuperBoardInitConfig config) async {
    _registerEventHandler();

    final Map<dynamic, dynamic> result = await _channel.invokeMethod('init', {
      'config': {
        'appID': config.appID,
        'appSign': config.appSign,
        'userID': config.userID,
        'token': config.token,
      }
    });

    if (0 == result['errorCode']) {
      isEngineCreated = true;
    }

    return result['errorCode'];
  }

  static Future<void> uninit() async {
    await _channel.invokeMethod('uninit');

    _unregisterEventHandler();

    isEngineCreated = false;
  }

  static Future<String> getSDKVersion() async {
    return await _channel.invokeMethod('getSDKVersion');
  }

  static Future<void> clearCache() async {
    return await _channel.invokeMethod('clearCache');
  }

  static Future<void> clear() async {
    return await _channel.invokeMethod('clear');
  }

  static Future<void> renewToken(String token) async {
    return await _channel.invokeMethod('renewToken', {
      'token': token,
    });
  }

  static Future<void> enableRemoteCursorVisible(bool visible) async {
    return await _channel.invokeMethod('enableRemoteCursorVisible', {
      'visible': visible,
    });
  }

  static Future<bool> isCustomCursorEnabled() async {
    return await _channel.invokeMethod('isCustomCursorEnabled');
  }

  static Future<bool> isEnableResponseScale() async {
    return await _channel.invokeMethod('isEnableResponseScale');
  }

  static Future<bool> isEnableSyncScale() async {
    return await _channel.invokeMethod('isEnableSyncScale');
  }

  static Future<bool> isRemoteCursorVisibleEnabled() async {
    return await _channel.invokeMethod('isRemoteCursorVisibleEnabled');
  }

  static Future<void> setCustomizedConfig(String key, String value) async {
    return await _channel.invokeMethod('setCustomizedConfig', {
      'key': key,
      'value': value,
    });
  }

  static Future<ZegoSuperBoardCreateWhiteboardViewResult> createWhiteboardView(
      ZegoCreateWhiteboardConfig config) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('createWhiteboardView', {
      'config': {
        'name': config.name,
        'perPageWidth': config.perPageWidth,
        'perPageHeight': config.perPageHeight,
        'pageCount': config.pageCount,
      },
    });

    return ZegoSuperBoardCreateWhiteboardViewResult(
      errorCode: result['errorCode'],
      subViewModel: ZegoSuperBoardSubViewModel.fromMap(
          result['subViewModel'] as Map<dynamic, dynamic>),
    );
  }

  static Future<ZegoSuperBoardCreateFileViewResult> createFileView(
      ZegoCreateFileConfig config) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('createFileView', {
      'config': {
        'fileID': config.fileID,
      },
    });

    return ZegoSuperBoardCreateWhiteboardViewResult(
      errorCode: result['errorCode'],
      subViewModel: ZegoSuperBoardSubViewModel.fromMap(
          result['subViewModel'] as Map<dynamic, dynamic>),
    );
  }

  static Future<int> destroySuperBoardSubView(String uniqueID) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('destroySuperBoardSubView', {
      'uniqueID': uniqueID,
    });

    return result['errorCode'];
  }

  static Future<ZegoSuperBoardQueryListResult>
      querySuperBoardSubViewList() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('querySuperBoardSubViewList');
    return ZegoSuperBoardQueryListResult(
      errorCode: result['errorCode'] as int,
      subViewModelList:
          (result['subViewModelList'] as List<Map<dynamic, dynamic>>)
              .map((subViewModel) {
        return ZegoSuperBoardSubViewModel.fromMap(subViewModel);
      }).toList(),
      extraInfo: result['extraInfo'] as Map<dynamic, dynamic>,
    );
  }

  //
  // @SuppressWarnings("unused")
  // public static
  //
  // void getSuperBoardView(MethodCall call, Result result) {
  //   ZegoSuperBoardManager.getInstance().getSuperBoardView();
  //
  //   result.success(null);
  // }
  //
  // @SuppressWarnings("unused")
  // public static
  //
  // void getSuperBoardSubView(MethodCall call, Result result) {
  //   String uniqueID = call.argument("uniqueID");
  //   ZegoSuperBoardManager.getInstance().getSuperBoardSubView(uniqueID);
  //
  //   result.success(null);
  // }

  static Future<ZegoSuperBoardGetListResult>
      getSuperBoardSubViewModelList() async {
    final List<dynamic> result =
        await _channel.invokeMethod('getSuperBoardSubViewModelList');
    return ZegoSuperBoardGetListResult(
      subViewModelList: result.map((subViewModel) {
        return ZegoSuperBoardSubViewModel.fromMap(subViewModel as Map<dynamic, dynamic>);
      }).toList(),
    );
  }

  static Future<void> enableSyncScale(bool enable) async {
    return await _channel.invokeMethod('enableSyncScale', {
      'enable': enable,
    });
  }

  static Future<void> enableResponseScale(bool enable) async {
    return await _channel.invokeMethod('enableResponseScale', {
      'enable': enable,
    });
  }

  static Future<void> setToolType(int tool) async {
    return await _channel.invokeMethod('setToolType', {
      'tool': tool,
    });
  }

  static Future<ZegoSuperBoardTool> getToolType() async {
    final toolType = await _channel.invokeMethod('getToolType');
    return ZegoSuperBoardToolExtension.valueMap[toolType] ??
        ZegoSuperBoardTool.none;
  }

  static Future<void> setFontBold(bool bold) async {
    return await _channel.invokeMethod('setFontBold', {
      'bold': bold,
    });
  }

  static Future<bool> isFontBold() async {
    return await _channel.invokeMethod('isFontBold');
  }

  static Future<void> setFontItalic(bool italic) async {
    return await _channel.invokeMethod('setFontItalic', {
      'italic': italic,
    });
  }

  static Future<bool> isFontItalic() async {
    return await _channel.invokeMethod('isFontItalic');
  }

  static Future<void> setFontSize(int size) async {
    return await _channel.invokeMethod('setFontSize', {
      'size': size,
    });
  }

  static Future<int> getFontSize() async {
    return await _channel.invokeMethod('getFontSize');
  }

  static Future<void> setBrushSize(int size) async {
    return await _channel.invokeMethod('setBrushSize', {
      'size': size,
    });
  }

  static Future<int> getBrushSize() async {
    return await _channel.invokeMethod('getBrushSize');
  }

  static Future<void> setBrushColor(int color) async {
    return await _channel.invokeMethod('setBrushColor', {
      'color': color,
    });
  }

  static Future<int> getBrushColor() async {
    return await _channel.invokeMethod('getBrushColor');
  }

  /* EventHandler */

  static void _registerEventHandler() async {
    _streamSubscription =
        _event.receiveBroadcastStream().listen(_eventListener);
  }

  static void _unregisterEventHandler() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  static void _eventListener(dynamic data) {
    final Map<dynamic, dynamic> map = data;
    switch (map['method']) {
      // case 'onDebugError':
      //   if (ZegoSuperBoardEngine.onDebugError == null) return;
      //
      //   ZegoSuperBoardEngine.onDebugError!(
      //       map['errorCode'], map['funcName'], map['info']);
      //   break;
      default:
        // TODO: Unknown callback
        break;
    }
  }
}
