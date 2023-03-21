import 'package:flutter/material.dart';
import 'dart:typed_data';

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

enum ZegoSuperBoardTool {
  none, //  (0)
  pen, //  (1)
  text, //  (2)
  line, //  (4)
  rect, //  (8)
  ellipse, //  (16)
  selector, //  (32)
  eraser, //  (64)
  laser, //  (128)
  click, //  (256)
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
    model.whiteboardIDList = (params['whiteboardIDList'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
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
