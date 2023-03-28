import 'package:flutter/cupertino.dart';

import 'impl/zego_super_board_platform_view_impl.dart'
    if (dart.library.html) 'impl/zego_super_board_platform_view_impl_web.dart';
import 'zego_super_board_engine.dart';
import 'impl/zego_super_board_impl.dart';
import 'zego_super_board_defines.dart';

mixin ZegoSuperBoardView {
  /// Create a Super Whiteboard Container that manages the lifecycle of switchSuperBoardSubView internally.
  /// @onViewCreated  Callback after the container is created.
  Future<Widget?> createSuperBoardView(Function(int uniqueID) onViewCreated,
      {Key? key}) async {
    print("call createSuperBoardView method");
    if (ZegoSuperBoardImpl.isEngineCreated) {
      return ZegoSuperBoardPlatformViewImpl.createSuperBoardView(onViewCreated,
          key: key);
    }

    return Container();
  }

  /// Switch to the specified SuperBoardSubView.
  /// @param uniqueID
  ///
  /// @return error code
  Future<int> switchSuperBoardSubView(String uniqueID) async {
    return await ZegoSuperBoardImpl.switchSuperBoardSubView(uniqueID);
  }
}
