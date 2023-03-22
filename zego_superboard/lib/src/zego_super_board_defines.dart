import 'package:flutter/material.dart';
import 'dart:io';

import '../zego_superboard.dart';

export 'zego_super_board_enum.dart';
export 'zego_super_board_enum_extension.dart';

/// Detailed Description:
/// Interface parameter construction class used to construct parameters required for initializing the SDK.
///
/// Business Scenario:
/// It needs to be passed in when calling the initialization SDK interface [init].
class ZegoSuperBoardInitConfig {
  /// The application ID issued by ZEGO for developers, please apply from the ZEGO Management Console.
  /// Value Range: 0 - 4294967295.
  int appID;

  /// User ID.
  /// Do not fill in sensitive user information in this field, including but not limited to phone number, ID card number, passport number, real name, etc.
  String userID;

  /// Value Range: '0' ~ '9', 'a' ~ 'z'.
  /// Example: "9dc9a25bh2f2137446897071c8c033fa33b91c3dd2a85e0c000ae82c0dad3".
  /// AppSign in version 2.3.0 and above can be passed as empty or not passed. If passed as empty or not passed, a token can be passed for initialization. Please refer to the Token Authentication for the method of generating tokens.
  String? appSign;

  /// Detailed Description:
  /// Login verification token is obtained by combining the key obtained by registering the project in the ZEGO Console with a specified algorithm.
  /// During the testing phase, it can be obtained through the interface provided by ZEGO, but in the formal environment, users must implement it themselves.
  String? token;

  ZegoSuperBoardInitConfig({
    required this.appID,
    required this.appSign,
    required this.userID,
    this.token,
  });
}

/// Interface parameter construction class used to pass in parameters required to create a whiteboard.
/// Business Scenario: It needs to be passed in when calling the [createWhiteboardView] interface.
class ZegoCreateWhiteboardConfig {
  /// The name of the whiteboard that needs to be set when creating it.
  /// Value Range: Limited to 128 bytes in length, supports Chinese and English.
  String name;

  /// The width of each page of the whiteboard.
  /// Value Range: A positive integer greater than 0.
  int perPageWidth;

  /// The height of each page of the whiteboard.
  /// Value Range: A positive integer greater than 0.
  int perPageHeight;

  /// Total number of pages.
  /// Value Range: A positive integer greater than 0.
  int pageCount;

  ZegoCreateWhiteboardConfig({
    required this.name,
    required this.perPageWidth,
    required this.perPageHeight,
    required this.pageCount,
  });
}

/// Detailed Description:
/// Interface parameter construction class used to pass in parameters required to create a file.
///
/// Business Scenario:
/// It needs to be passed in when calling the [createFileView] interface.
class ZegoCreateFileConfig {
  /// The ID corresponding to the file.
  String fileID;

  ZegoCreateFileConfig({required this.fileID});
}

/// Detailed Description:
/// Data model class that contains the name, creation time, file ID, file type, and unique identifier of the created ZegoSuperBoardSubView.
///
/// Business Scenario:
/// Users can obtain the ID, name, and file information of the corresponding ZegoSuperBoardSubView object.
class ZegoSuperBoardSubViewModel {
  /// The name corresponding to the SuperBoardSubView.
  String name;

  /// The creation time of the whiteboard.
  /// Unix timestamp in milliseconds.
  int createTime;

  /// The unique file ID used when creating a file whiteboard.
  String fileID;

  /// The file type used when creating a file whiteboard. See ZegoSuperBoardFileType for details.
  ZegoSuperBoardFileType fileType;

  /// The ID of SuperBoardSubview is unique.
  String uniqueID;

  /// A list of whiteboard IDs.
  List<String> whiteboardIDList;

  /// biz extension
  /// Notification of current page change.
  ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  /// biz extension
  /// Notification of page count change.
  ValueNotifier<int> pageCountNotifier = ValueNotifier<int>(0);

  ZegoSuperBoardSubViewModel({
    this.name = '',
    this.createTime = 0,
    this.fileID = '',
    this.fileType = ZegoSuperBoardFileType.unknown,
    this.uniqueID = '',
    this.whiteboardIDList = const [],
  });

  @override
  String toString() {
    return '[ZegoSuperBoardSubViewModel] name:$name, '
        'fileID:$fileID, fileType:$fileType, uniqueID:$uniqueID, '
        'whiteboardIDList:$whiteboardIDList';
  }

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

  /// Synchronize current page.
  void syncCurrentPage() {
    debugPrint("syncCurrentPage $name ${DateTime.now().toString()}");
    ZegoSuperBoardEngine.instance.getCurrentPage().then((value) {
      currentPageNotifier.value = value;
      debugPrint("syncCurrentPage $name $value ${DateTime.now().toString()}");
    });
  }

  /// Synchronize total number of pages.
  void syncPageCount() {
    debugPrint("syncPageCount $name ${DateTime.now().toString()}");
    ZegoSuperBoardEngine.instance.getPageCount().then((value) {
      pageCountNotifier.value = value;
      debugPrint("syncPageCount $name $value ${DateTime.now().toString()}");
    });
  }

  /// Jump to the next page.
  void flipToPrePage() {
    ZegoSuperBoardEngine.instance.flipToPrePage().then((value) {
      syncCurrentPage();
    });
  }

  /// Jump to the previous page.
  void flipToNextPage() {
    ZegoSuperBoardEngine.instance.flipToNextPage().then((value) {
      syncCurrentPage();
    });
  }

  /// Jump to a specified page.
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
