import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';

import '../zego_superwhiteboard.dart';
import 'zego_super_board_enum_extension.dart';

class ZegoSuperBoardInitConfig {
  int appID;
  String userID;
  String? appSign;
  String? token;

  ZegoSuperBoardInitConfig({
    required this.appID,
    required this.appSign,
    required this.userID,
    this.token,
  });
}

/// tool type definition
enum ZegoSuperBoardTool {
  /// There is no setup tool, the functionality normally used for scrolling files
  none, //  (0)
  /// Brush tool, set to draw lines
  pen, //  (1)
  /// Text tool, after setting the pop-up text input box, displayed in the specific position of the whiteboard
  text, //  (2)
  /// Line tool, set to draw a line
  line, //  (4)
  /// Rectangle tool, set to draw a hollow rectangle
  rect, //  (8)
  /// Ellipse tool, set and draw ellipses
  ellipse, //  (16)
  /// Select tool, after setting, you can select the element to operate, such as moving
  selector, //  (32)
  /// Erase tool, after setting, click the image element to erase
  eraser, //  (64)
  /// Laser pointer tool, display laser pointer trajectory after setting
  laser, //  (128)
  /// Click tool, which is mainly used to click the content of dynamic ppt and H5 files
  click, //  (256)
  /// Custom graph, after setting this type, drawing on the whiteboard will draw the custom graph passed by the addImage interface
  customImage, //  (512)
}

class ZegoCreateWhiteboardConfig {
  String name;
  int perPageWidth;
  int perPageHeight;
  int pageCount;

  ZegoCreateWhiteboardConfig({
    required this.name,
    required this.perPageWidth,
    required this.perPageHeight,
    required this.pageCount,
  });
}

class ZegoCreateFileConfig {
  String fileID;

  ZegoCreateFileConfig({required this.fileID});
}

enum ZegoSuperBoardFileType {
  unknown, // (0)
  ppt, // (1)
  doc, // (2)
  els, // (4)
  pdf, // (8)
  img, // (16)
  txt, // (32)
  pdfAndImages, // (256)
  dynamicPPTH5, // (512)
  customH5, // (4096)
}

class ZegoSuperBoardSubViewModel {
  String name;
  int createTime;
  String fileID;
  ZegoSuperBoardFileType fileType;
  String uniqueID;
  List<String> whiteboardIDList;

  /// biz extension
  ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> pageCountNotifier = ValueNotifier<int>(0);

  ZegoSuperBoardSubViewModel({
    this.name = '',
    this.createTime = 0,
    this.fileID = '',
    this.fileType = ZegoSuperBoardFileType.unknown,
    this.uniqueID = '',
    this.whiteboardIDList = const [],
  });

  static ZegoSuperBoardSubViewModel fromMap(Map<dynamic, dynamic> params) {
    final model = ZegoSuperBoardSubViewModel();
    model.name = params['name'] ?? '';
    model.createTime = params['createTime'] ?? 0;
    model.fileID = params['fileID'] ?? '';
    model.fileType =
        ZegoSuperBoardFileTypeExtension.valueMap[params['fileType'] as int] ??
            ZegoSuperBoardFileType.unknown;
    model.uniqueID = params['uniqueID'] ?? '';
    if (Platform.isIOS) {
      model.whiteboardIDList = (params['whiteboardIDList'] as List<dynamic>)
          .map((e) => (e as int).toString())
          .toList();
    } else {
      model.whiteboardIDList = (params['whiteboardIDList'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    }
    return model;
  }

  /// biz extension
  void syncCurrentPage() {
    debugPrint("syncCurrentPage $name ${DateTime.now().toString()}");
    ZegoSuperBoardEngine.instance.getCurrentPage().then((value) {
      currentPageNotifier.value = value;
      debugPrint("syncCurrentPage $name $value ${DateTime.now().toString()}");
    });
  }

  void syncPageCount() {
    debugPrint("syncPageCount $name ${DateTime.now().toString()}");
    ZegoSuperBoardEngine.instance.getPageCount().then((value) {
      pageCountNotifier.value = value;
      debugPrint("syncPageCount $name $value ${DateTime.now().toString()}");
    });
  }

  void flipToPrePage() {
    ZegoSuperBoardEngine.instance.flipToPrePage().then((value) {
      syncCurrentPage();
    });
  }

  void flipToNextPage() {
    ZegoSuperBoardEngine.instance.flipToNextPage().then((value) {
      syncCurrentPage();
    });
  }

  void flipToPage(int targetPage) {
    ZegoSuperBoardEngine.instance.flipToPage(targetPage).then((value) {
      syncCurrentPage();
    });
  }
}

class ZegoSuperBoardQueryListResult {
  int errorCode;
  List<ZegoSuperBoardSubViewModel> subViewModelList;
  Map<dynamic, dynamic> extraInfo;

  ZegoSuperBoardQueryListResult({
    this.errorCode = 0,
    this.subViewModelList = const [],
    this.extraInfo = const {},
  });
}

class ZegoSuperBoardGetListResult {
  List<ZegoSuperBoardSubViewModel> subViewModelList;

  ZegoSuperBoardGetListResult({
    this.subViewModelList = const [],
  });
}

class ZegoSuperBoardCreateWhiteboardViewResult {
  int errorCode;
  ZegoSuperBoardSubViewModel? subViewModel;

  ZegoSuperBoardCreateWhiteboardViewResult({
    this.errorCode = 0,
    this.subViewModel,
  });
}

typedef ZegoSuperBoardCreateFileViewResult
    = ZegoSuperBoardCreateWhiteboardViewResult;

/// Business scenario: When set to scroll mode, the gesture will be
/// recognized as file scrolling.
/// When set to draw, the gesture is recognized as a function of the drawing tool, such as brush, line, rectangle, etc.
/// Set to None, which will not respond to any gesture.
enum ZegoSuperBoardOperationMode {
  /// Do not respond to any gestures
  none,

  /// Gestures are recognized as functions of drawing tools such as brushes, lines, rectangles, erasers, etc
  draw,

  /// Gestures are recognized as file scrolling
  scroll,

  /// Recognize the zoom gesture; if not set, it will not zoom with the gesture
  zoom,
}
