import 'dart:ui';

import 'impl/zego_super_board_impl.dart';
import 'zego_super_board_subview.dart';
import 'zego_super_board_view.dart';
import 'zego_super_board_defines.dart';

class ZegoSuperBoardEngine with ZegoSuperBoardView, ZegoSuperBoardSubView {
  /// Private constructor
  ZegoSuperBoardEngine._internal();

  /// Engine singleton instance
  static final ZegoSuperBoardEngine instance = ZegoSuperBoardEngine._internal();

  /// Before using ZegoSuperBoard SDK for functional calls, it is necessary to initialize the SDK first.
  Future<int> init(ZegoSuperBoardInitConfig config) async {
    return await ZegoSuperBoardImpl.init(config);
  }

  Future<void> uninit() async {
    return await ZegoSuperBoardImpl.uninit();
  }

  Future<String> getSDKVersion() async {
    return await ZegoSuperBoardImpl.getSDKVersion();
  }

  Future<void> clearCache() async {
    return await ZegoSuperBoardImpl.clearCache();
  }

  Future<void> clear() async {
    return await ZegoSuperBoardImpl.clear();
  }

  Future<void> renewToken(String token) async {
    return await ZegoSuperBoardImpl.renewToken(token);
  }

  Future<void> enableRemoteCursorVisible(bool visible) async {
    return await ZegoSuperBoardImpl.enableRemoteCursorVisible(visible);
  }

  Future<bool> isCustomCursorEnabled() async {
    return await ZegoSuperBoardImpl.isCustomCursorEnabled();
  }

  Future<bool> isEnableResponseScale() async {
    return await ZegoSuperBoardImpl.isEnableResponseScale();
  }

  Future<bool> isEnableSyncScale() async {
    return await ZegoSuperBoardImpl.isEnableSyncScale();
  }

  Future<bool> isRemoteCursorVisibleEnabled() async {
    return await ZegoSuperBoardImpl.isRemoteCursorVisibleEnabled();
  }

  Future<void> setCustomizedConfig(String key, String value) async {
    return await ZegoSuperBoardImpl.setCustomizedConfig(key, value);
  }

  Future<ZegoSuperBoardCreateWhiteboardViewResult> createWhiteboardView(
    ZegoCreateWhiteboardConfig config,
  ) async {
    return await ZegoSuperBoardImpl.createWhiteboardView(config);
  }

  Future<ZegoSuperBoardCreateFileViewResult> createFileView(
    ZegoCreateFileConfig config,
  ) async {
    return await ZegoSuperBoardImpl.createFileView(config);
  }

  Future<int> destroySuperBoardSubView(String uniqueID) async {
    return await ZegoSuperBoardImpl.destroySuperBoardSubView(uniqueID);
  }

  Future<ZegoSuperBoardQueryListResult> querySuperBoardSubViewList() async {
    return await ZegoSuperBoardImpl.querySuperBoardSubViewList();
  }

  Future<ZegoSuperBoardGetListResult> getSuperBoardSubViewModelList() async {
    return await ZegoSuperBoardImpl.getSuperBoardSubViewModelList();
  }

  Future<void> enableSyncScale(bool enable) async {
    return await ZegoSuperBoardImpl.enableSyncScale(enable);
  }

  Future<void> enableResponseScale(bool enable) async {
    return await ZegoSuperBoardImpl.enableResponseScale(enable);
  }

  Future<void> setToolType(ZegoSuperBoardTool tool) async {
    return await ZegoSuperBoardImpl.setToolType(tool);
  }

  Future<ZegoSuperBoardTool> getToolType() async {
    return await ZegoSuperBoardImpl.getToolType();
  }

  Future<void> setFontBold(bool bold) async {
    return await ZegoSuperBoardImpl.setFontBold(bold);
  }

  Future<bool> isFontBold() async {
    return await ZegoSuperBoardImpl.isFontBold();
  }

  Future<void> setFontItalic(bool italic) async {
    return await ZegoSuperBoardImpl.setFontItalic(italic);
  }

  Future<bool> isFontItalic() async {
    return await ZegoSuperBoardImpl.isFontItalic();
  }

  Future<void> setFontSize(int size) async {
    return await ZegoSuperBoardImpl.setFontSize(size);
  }

  Future<int> getFontSize() async {
    return await ZegoSuperBoardImpl.getFontSize();
  }

  Future<void> setBrushSize(int size) async {
    return await ZegoSuperBoardImpl.setBrushSize(size);
  }

  Future<int> getBrushSize() async {
    return await ZegoSuperBoardImpl.getBrushSize();
  }

  Future<void> setBrushColor(Color color) async {
    return await ZegoSuperBoardImpl.setBrushColor(color);
  }

  Future<Color> getBrushColor() async {
    return await ZegoSuperBoardImpl.getBrushColor();
  }

  // only support web
  Future<void> setScaleFactor(double scaleFactor) async {
    return await ZegoSuperBoardImpl.setScaleFactor(scaleFactor);
  }

  Future<void> setSuperBoardMaxScaleFactor(double maxScaleFactor) async {
    return await ZegoSuperBoardImpl.setSuperBoardMaxScaleFactor(maxScaleFactor);
  }


  static void Function(int errorCode)? onError;
  static void Function(Map<dynamic, dynamic> subViewModel)? onRemoteSuperBoardSubViewAdded;
  static void Function(Map<dynamic, dynamic> subViewModel)? onRemoteSuperBoardSubViewRemoved;
  static void Function(String uniqueID)? onRemoteSuperBoardSubViewSwitched;
  static void Function(Map<String, int> authInfo)? onRemoteSuperBoardAuthChanged;
  static void Function(Map<String, int> authInfo)? onRemoteSuperBoardGraphicAuthChanged;
  static void Function(String uniqueID, int page)? onSuperBoardSubViewScrollChanged;
  static void Function(String uniqueID, double scale)? onSuperBoardSubViewScaleChanged;
}
