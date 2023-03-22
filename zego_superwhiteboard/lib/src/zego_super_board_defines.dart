import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';

import '../zego_superwhiteboard.dart';

export 'zego_super_board_enum.dart';
export 'zego_super_board_enum_extension.dart';

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

