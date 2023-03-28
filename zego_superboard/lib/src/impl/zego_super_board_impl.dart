import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../zego_super_board_engine.dart';
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
      MethodChannel('plugins.zego.im/zego_superboard');
  static const EventChannel _event =
      EventChannel('plugins.zego.im/zego_superboard_event_handler');

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
          (result['subViewModelList'] as List<dynamic>).map((subViewModel) {
        return ZegoSuperBoardSubViewModel.fromMap(
            subViewModel as Map<dynamic, dynamic>);
      }).toList(),
      extraInfo: result['extraInfo'] as Map<dynamic, dynamic>,
    );
  }

  static Future<ZegoSuperBoardGetListResult>
      getSuperBoardSubViewModelList() async {
    final List<dynamic> result =
        await _channel.invokeMethod('getSuperBoardSubViewModelList');
    return ZegoSuperBoardGetListResult(
      subViewModelList: result.map((subViewModel) {
        return ZegoSuperBoardSubViewModel.fromMap(
            subViewModel as Map<dynamic, dynamic>);
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

  static Future<void> setToolType(ZegoSuperBoardTool tool) async {
    return await _channel.invokeMethod('setToolType', {
      'tool': tool.id,
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

  static Future<void> setBrushColor(Color color) async {
    if (Platform.isIOS) {
      return await _channel.invokeMethod('setBrushColor', {
        'color': '0x${color.value.toRadixString(16).substring(2)}',
      });
    } else {
      return await _channel.invokeMethod('setBrushColor', {
        'color': int.tryParse(color.value.toRadixString(16), radix: 16) ??
            0xFF000000,
      });
    }
  }

  static Future<Color> getBrushColor() async {
    final hexValue = await _channel.invokeMethod('getBrushColor');
    if (Platform.isIOS) {
      return Color(
          int.tryParse(hexValue as String? ?? '', radix: 16) ?? 0xFF000000);
    }

    return Color(hexValue as int? ?? 0xFF000000);
  }

  static Future<int> switchSuperBoardSubView(String uniqueID) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('switchSuperBoardSubView', {
      'uniqueID': uniqueID,
    });

    return result['errorCode'];
  }

  /// subview
  static Future<List<dynamic>> getThumbnailUrlList() async {
    return await _channel.invokeMethod('getThumbnailUrlList');
  }

  static Future<Map<dynamic, dynamic>> getModel() async {
    return await _channel.invokeMethod('getModel');
  }

  static Future<int> inputText() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('inputText');

    return result['errorCode'];
  }

  static Future<int> addText(String text, int positionX, int positionY) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('addText', {
      'text': text,
      'positionX': positionX,
      'positionY': positionY,
    });
    return result['errorCode'];
  }

  static Future<void> undo() async {
    await _channel.invokeMethod('undo');
  }

  static Future<void> redo() async {
    await _channel.invokeMethod('redo');
  }

  static Future<void> clearCurrentPage() async {
    await _channel.invokeMethod('clearCurrentPage');
  }

  static Future<void> clearAllPage() async {
    await _channel.invokeMethod('clearAllPage');
  }

  static Future<void> setOperationMode(ZegoSuperBoardOperationMode mode) async {
    await _channel.invokeMethod('setOperationMode', {
      'mode': mode.id,
    });
  }

  static Future<int> flipToPage(int targetPage) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('flipToPage', {
      'targetPage': targetPage,
    });
    return result['errorCode'];
  }

  static Future<int> flipToPrePage() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('flipToPrePage');
    return result['errorCode'];
  }

  static Future<int> flipToNextPage() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('flipToNextPage');
    return result['errorCode'];
  }

  static Future<int> getCurrentPage() async {
    return await _channel.invokeMethod('getCurrentPage');
  }

  static Future<int> getPageCount() async {
    return await _channel.invokeMethod('getPageCount');
  }

  static Future<Map<dynamic, dynamic>> getVisibleSize() async {
    return await _channel.invokeMethod('getVisibleSize');
  }

  static Future<int> clearSelected() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('clearSelected');
    return result['errorCode'];
  }

  static Future<int> setWhiteboardBackgroundColor(Color color) async {
    Map<dynamic, dynamic> result = {};

    if (Platform.isIOS) {
      result = await _channel.invokeMethod('setWhiteboardBackgroundColor', {
        'color': '0x${color.value.toRadixString(16).substring(2)}',
      });
    } else {
      result = await _channel.invokeMethod('setWhiteboardBackgroundColor', {
        'color': int.tryParse(color.value.toRadixString(16), radix: 16) ??
            0xFF000000,
      });
    }

    return result['errorCode'];
  }

  /// EventHandler
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
      case 'onError':
        if (ZegoSuperBoardEngine.onError == null) return;
        ZegoSuperBoardEngine.onError!(map['errorCode']);
        break;
      case 'onRemoteSuperBoardSubViewAdded':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewAdded == null) return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewAdded!(map['subViewModel']);
        break;
      case 'onRemoteSuperBoardSubViewRemoved':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewRemoved == null)
          return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewRemoved!(map['subViewModel']);
        break;
      case 'onRemoteSuperBoardSubViewSwitched':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardSubViewSwitched == null)
          return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardSubViewSwitched!(map['uniqueID']);
        break;
      case 'onRemoteSuperBoardAuthChanged':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardAuthChanged == null) return;
        ZegoSuperBoardEngine.onRemoteSuperBoardAuthChanged!(map['authInfo']);
        break;
      case 'onRemoteSuperBoardGraphicAuthChanged':
        if (ZegoSuperBoardEngine.onRemoteSuperBoardGraphicAuthChanged == null)
          return;
        ZegoSuperBoardEngine
            .onRemoteSuperBoardGraphicAuthChanged!(map['authInfo']);
        break;
      default:
        // TODO: Unknown callback
        break;
    }
  }
}
