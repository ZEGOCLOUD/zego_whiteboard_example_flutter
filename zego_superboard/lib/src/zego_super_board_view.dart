import 'package:flutter/cupertino.dart';

import 'impl/zego_super_board_platform_view_impl.dart';
import 'impl/zego_super_board_impl.dart';

/// This class mainly realizes the function of switching SuperBoardSubView and Excel file sheet in SuperBoardSubView.
/// After initializing SDK, You can get the ZegoSuperBoardView object directly using the ZegoSuperBoardManager,
/// through the outside of the class does not need to deal with the ZegoSuperBoardView switching and synchronization logic,
/// ZegoSuperBoardView handles the logic for switching synchronised presentations internally.
mixin ZegoSuperBoardView {
  /// Create a Super Whiteboard Container that manages the lifecycle of switchSuperBoardSubView internally.
  /// @onViewCreated  Callback after the container is created.
  Future<Widget?> createSuperBoardView(Function(int uniqueID) onViewCreated,
      {Key? key}) async {
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

  Future<int> switchSuperBoardSubExcelView(
      String uniqueID, int sheetIndex) async {
    return await ZegoSuperBoardImpl.switchSuperBoardSubExcelView(
      uniqueID,
      sheetIndex,
    );
  }
}
