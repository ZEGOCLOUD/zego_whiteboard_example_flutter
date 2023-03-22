import 'dart:ui';

import 'impl/zego_super_board_impl.dart';
import 'zego_super_board_defines.dart';

/// describe a pure whiteboard or file whiteboard.
mixin ZegoSuperBoardSubView {
  /// Get a list of thumbnails for the current file, supporting file formats such as PDF, PPT, dynamic PPT, and H5.
  Future<List<dynamic>> getThumbnailUrlList() async {
    return await ZegoSuperBoardImpl.getThumbnailUrlList();
  }

  /// Get the model data corresponding to the whiteboard.
  Future<ZegoSuperBoardSubViewModel> getModel() async {
    final modelMap = await ZegoSuperBoardImpl.getModel();
    return ZegoSuperBoardSubViewModel.fromMap(modelMap);
  }

  /// Add text to the whiteboard view. After calling, an input box will pop up from the bottom of the whiteboard.
  ///
  /// @return error code
  Future<int> inputText() async {
    return await ZegoSuperBoardImpl.inputText();
  }

  /// Add custom text to the whiteboard.
  ///
  /// @return error code
  Future<int> addText(String text, int positionX, int positionY) async {
    return ZegoSuperBoardImpl.addText(
      text,
      positionX,
      positionY,
    );
  }

  /// Undo the previous operation on the whiteboard.
  Future<void> undo() async {
    await ZegoSuperBoardImpl.undo();
  }

  /// Redo the operation that was previously undone on the whiteboard.
  Future<void> redo() async {
    await ZegoSuperBoardImpl.redo();
  }

  /// Clear the graphics on the current page of the whiteboard.
  Future<void> clearCurrentPage() async {
    await ZegoSuperBoardImpl.clearCurrentPage();
  }

  /// Clear the graphics on all pages of the whiteboard.
  Future<void> clearAllPage() async {
    await ZegoSuperBoardImpl.clearAllPage();
  }

  /// Set the operation mode of the current whiteboard.
  Future<void> setOperationMode(ZegoSuperBoardOperationMode mode) async {
    await ZegoSuperBoardImpl.setOperationMode(mode);
  }

  /// Jump to the specified page on the whiteboard.
  ///
  /// @return error code
  Future<int> flipToPage(int targetPage) async {
    return await ZegoSuperBoardImpl.flipToPage(targetPage);
  }

  /// Jump to the previous page on the whiteboard.
  ///
  /// @return error code
  Future<int> flipToPrePage() async {
    return await ZegoSuperBoardImpl.flipToPrePage();
  }

  /// Jump to the next page on the whiteboard.
  ///
  /// @return error code
  Future<int> flipToNextPage() async {
    return await ZegoSuperBoardImpl.flipToNextPage();
  }

  ///  Get the page number of the currently displayed content.
  ///
  /// @return current page
  Future<int> getCurrentPage() async {
    return await ZegoSuperBoardImpl.getCurrentPage();
  }

  /// Get the total number of pages on the whiteboard.
  ///
  /// @return page count
  Future<int> getPageCount() async {
    return await ZegoSuperBoardImpl.getPageCount();
  }

  /// Get the size of the visible area.
  ///
  /// @return map<'width'/'height', value>
  Future<Map<dynamic, dynamic>> getVisibleSize() async {
    return await ZegoSuperBoardImpl.getVisibleSize();
  }

  /// Delete the selected graphics on the whiteboard.
  ///
  /// @return error code
  Future<int> clearSelected() async {
    return await ZegoSuperBoardImpl.clearSelected();
  }

  /// Set the background color of the whiteboard.
  ///
  /// @return error code
  Future<void> setWhiteboardBackgroundColor(Color color) async {
    return await ZegoSuperBoardImpl.setWhiteboardBackgroundColor(color);
  }
}
