@JS('ZegoSuperboardFlutterEngine')
library ZegoSuperboardFlutterEngine;

import 'package:js/js.dart';
import 'dart:js_util';

@JS('ZegoSuperboardFlutterEngine')
class ZegoSuperboardFlutterEngine {
  external static initWithConfig(String config, dynamic success, dynamic fail);
  external static setEventHandler(Function handler);
  external static uninit();
  external static getSDKVersion();
  external static clearCache();
  external static clear();
  external static renewToken(String token);
  external static enableRemoteCursorVisible(bool enable);
  external static setCustomizedConfig(dynamic config);
  external static createWhiteboardView(dynamic config, dynamic success, dynamic fail);
  external static createFileView(String fileID, dynamic success, dynamic fail);
  external static destroySuperBoardSubView(String uniqueID, dynamic success, dynamic fail);
  external static querySuperBoardSubViewList(dynamic success, dynamic fail);
  external static getSuperBoardSubViewModelList(dynamic success, dynamic fail);
  external static enableSyncScale(bool enable);
  external static enableResponseScale(bool enable);
  external static setToolType(int toolType);
  external static getToolType();
  external static setFontBold(bool isBold);
  external static isFontBold();
  external static setFontItalic(bool isItalic);
  external static isFontItalic();
  external static setFontSize(dynamic size);
  external static getFontSize();
  external static setBrushSize(dynamic size);
  external static setBrushColor(String color);
  external static getBrushSize();
  external static getBrushColor();
  external static switchSuperBoardSubView(String uniqueID, dynamic success, dynamic fail);
  external static getThumbnailUrlList(dynamic success, dynamic fail);
  external static getModel();
  external static inputText();
  external static addText(dynamic config, dynamic success, dynamic fail);
  external static undo();
  external static redo();
  external static clearCurrentPage();
  external static clearAllPage();
  external static setOperationMode(int mode);
  external static flipToPage(int targetPage);
  external static flipToPrePage();
  external static flipToNextPage();
  external static getCurrentPage();
  external static getPageCount();
  external static getVisibleSize();
  external static clearSelected();
  external static setWhiteboardBackgroundColor(String color);
  external static reloadView();
  external static setScaleFactor(double scaleFactor);
  external static onWidgetPosition(double x, double y);
}