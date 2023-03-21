import 'package:flutter/material.dart';
import '../utils/zego_super_board_utils.dart';

/// Native implementation of [createSuperBoardView]
class ZegoSuperBoardPlatformViewImpl {
  /// Create a PlatformView and return the view ID
  static Widget? createSuperBoardView(Function(int viewID) onViewCreated,
      {Key? key}) {
    if (kIsIOS || kIsMacOS) {
      return UiKitView(
          key: key,
          viewType: 'plugins.zego.im/zego_superboard_view',
          onPlatformViewCreated: (int viewID) {
            onViewCreated(viewID);
          });
    } else if (kIsAndroid) {
      return AndroidView(
          key: key,
          viewType: 'plugins.zego.im/zego_superboard_view',
          onPlatformViewCreated: (int viewID) {
            onViewCreated(viewID);
          });
    }
    return null;
  }
}
