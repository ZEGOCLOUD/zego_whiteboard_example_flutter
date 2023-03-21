import 'zego_super_board_engine.dart';
import 'impl/zego_super_board_impl.dart';
import 'zego_super_board_defines.dart';

mixin ZegoSuperBoardSubView {
  Future<List<dynamic>> getThumbnailUrlList() async {
    return await ZegoSuperBoardImpl.getThumbnailUrlList();
  }

  Future<Map<dynamic, dynamic>> getModel() async {
    return await ZegoSuperBoardImpl.getModel();
  }

  Future<int> inputText() async {
    return await ZegoSuperBoardImpl.inputText();
  }

  Future<int> addText(String text, int positionX, int positionY) async {
    return ZegoSuperBoardImpl.addText(
      text,
      positionX,
      positionY,
    );
  }

  Future<void> undo() async {
    await ZegoSuperBoardImpl.undo();
  }

  Future<void> redo() async {
    await ZegoSuperBoardImpl.redo();
  }

  Future<void> clearCurrentPage() async {
    await ZegoSuperBoardImpl.clearCurrentPage();
  }

  Future<void> clearAllPage() async {
    await ZegoSuperBoardImpl.clearAllPage();
  }

  Future<void> setOperationMode(int mode) async {
    await ZegoSuperBoardImpl.setOperationMode(mode);
  }

  Future<int> flipToPage(int targetPage) async {
    return await ZegoSuperBoardImpl.flipToPage(targetPage);
  }

  Future<int> flipToPrePage() async {
    return await ZegoSuperBoardImpl.flipToPrePage();
  }

  Future<int> flipToNextPage() async {
    return await ZegoSuperBoardImpl.flipToNextPage();
  }

  Future<int> getCurrentPage() async {
    return await ZegoSuperBoardImpl.getCurrentPage();
  }

  Future<int> getPageCount() async {
    return await ZegoSuperBoardImpl.getPageCount();
  }

  Future<Map<dynamic, dynamic>> getVisibleSize() async {
    return await ZegoSuperBoardImpl.getVisibleSize();
  }

  Future<int> clearSelected() async {
    return await ZegoSuperBoardImpl.clearSelected();
  }

  Future<int> setWhiteboardBackgroundColor(int color) async {
    return await ZegoSuperBoardImpl.setWhiteboardBackgroundColor(color);
  }
}
