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

  /// Uninitialize the SDK
  Future<void> uninit() async {
    return await ZegoSuperBoardImpl.uninit();
  }

  /// Obtain the SDK version number
  Future<String> getSDKVersion() async {
    return await ZegoSuperBoardImpl.getSDKVersion();
  }

  /// Clear cache resources related to files and whiteboards
  Future<void> clearCache() async {
    return await ZegoSuperBoardImpl.clearCache();
  }

  /// Empty resources in the room called upon checkout
  Future<void> clear() async {
    return await ZegoSuperBoardImpl.clear();
  }

  /// Call time: after initializing the SDK, with the help of the upcoming expiration callback [tokenwillexpire] interface of zego SDK, receive the upcoming expiration callback of the token, and actively update the file service token of the super whiteboard.
  /// Scope of influence: the expiration time contained in the token will trigger the [tokenwillexpire] callback 30s before expiration
  /// Related callback: [tokenwillexpire]
  /// Related interfaces: None
  Future<void> renewToken(String token) async {
    return await ZegoSuperBoardImpl.renewToken(token);
  }

  /// Set whether to enable the display of remote custom cursor
  Future<void> enableRemoteCursorVisible(bool visible) async {
    return await ZegoSuperBoardImpl.enableRemoteCursorVisible(visible);
  }

  /// Whether to turn on the cursor display
  Future<bool> isCustomCursorEnabled() async {
    return await ZegoSuperBoardImpl.isCustomCursorEnabled();
  }

  /// Get whether it will respond to the zoom factor synchronized by other users
  Future<bool> isEnableResponseScale() async {
    return await ZegoSuperBoardImpl.isEnableResponseScale();
  }

  /// Get whether the current zoom factor will be synchronized to others
  Future<bool> isEnableSyncScale() async {
    return await ZegoSuperBoardImpl.isEnableSyncScale();
  }

  /// Whether the remote cursor is on
  Future<bool> isRemoteCursorVisibleEnabled() async {
    return await ZegoSuperBoardImpl.isRemoteCursorVisibleEnabled();
  }

  /// Set configuration items, such as "logPath" for the directory address where the SDK logs are stored, and "cachePath" for the directory address where the SDK caches are stored.
  Future<void> setCustomizedConfig(String key, String value) async {
    return await ZegoSuperBoardImpl.setCustomizedConfig(key, value);
  }

  /// Creating a pure whiteboard
  Future<ZegoSuperBoardCreateWhiteboardViewResult> createWhiteboardView(
    ZegoCreateWhiteboardConfig config,
  ) async {
    return await ZegoSuperBoardImpl.createWhiteboardView(config);
  }

  /// Create a file
  Future<ZegoSuperBoardCreateFileViewResult> createFileView(
    ZegoCreateFileConfig config,
  ) async {
    return await ZegoSuperBoardImpl.createFileView(config);
  }

  /// Destroy a specified SuperBoardSubView view.
  ///
  /// @return error code
  Future<int> destroySuperBoardSubView(String uniqueID) async {
    return await ZegoSuperBoardImpl.destroySuperBoardSubView(uniqueID);
  }

  /// Query the server for the list of SuperBoardSubView that currently exists
  Future<ZegoSuperBoardQueryListResult> querySuperBoardSubViewList() async {
    return await ZegoSuperBoardImpl.querySuperBoardSubViewList();
  }

  /// Get information about the superBoardSubView saved by the SDK.
  Future<ZegoSuperBoardGetListResult> getSuperBoardSubViewModelList() async {
    return await ZegoSuperBoardImpl.getSuperBoardSubViewModelList();
  }

  /// Set whether to synchronize the scaling to other members in the room.
  Future<void> enableSyncScale(bool enable) async {
    return await ZegoSuperBoardImpl.enableSyncScale(enable);
  }

  /// Set whether to respond to the scaling of other members in the room.
  Future<void> enableResponseScale(bool enable) async {
    return await ZegoSuperBoardImpl.enableResponseScale(enable);
  }

  /// Set the whiteboard tool type.
  Future<void> setToolType(ZegoSuperBoardTool tool) async {
    return await ZegoSuperBoardImpl.setToolType(tool);
  }

  /// Get the current whiteboard tool type being used.
  Future<ZegoSuperBoardTool> getToolType() async {
    return await ZegoSuperBoardImpl.getToolType();
  }

  /// Set text bold.
  Future<void> setFontBold(bool bold) async {
    return await ZegoSuperBoardImpl.setFontBold(bold);
  }

  /// Get whether the text is bold.
  Future<bool> isFontBold() async {
    return await ZegoSuperBoardImpl.isFontBold();
  }

  /// Set whether the text tool is in italic.
  Future<void> setFontItalic(bool italic) async {
    return await ZegoSuperBoardImpl.setFontItalic(italic);
  }

  /// Get whether the text is in italic.
  Future<bool> isFontItalic() async {
    return await ZegoSuperBoardImpl.isFontItalic();
  }

  /// Set the text size.
  Future<void> setFontSize(int size) async {
    return await ZegoSuperBoardImpl.setFontSize(size);
  }

  /// Get the text size.
  Future<int> getFontSize() async {
    return await ZegoSuperBoardImpl.getFontSize();
  }

  /// Set the brush size.
  Future<void> setBrushSize(int size) async {
    return await ZegoSuperBoardImpl.setBrushSize(size);
  }

  /// Get the brush size.
  Future<int> getBrushSize() async {
    return await ZegoSuperBoardImpl.getBrushSize();
  }

  /// Set the brush color.
  Future<void> setBrushColor(Color color) async {
    return await ZegoSuperBoardImpl.setBrushColor(color);
  }

  /// Get the brush color.
  Future<Color> getBrushColor() async {
    return await ZegoSuperBoardImpl.getBrushColor();
  }

  static void Function(int errorCode)? onError;
  static void Function(ZegoSuperBoardSubViewModel)?
      onRemoteSuperBoardSubViewAdded;
  static void Function(ZegoSuperBoardSubViewModel)?
      onRemoteSuperBoardSubViewRemoved;
  static void Function(String uniqueID)? onRemoteSuperBoardSubViewSwitched;
  static void Function(Map<dynamic, dynamic> authInfo)?
      onRemoteSuperBoardAuthChanged;
  static void Function(Map<dynamic, dynamic> authInfo)?
      onRemoteSuperBoardGraphicAuthChanged;
}
