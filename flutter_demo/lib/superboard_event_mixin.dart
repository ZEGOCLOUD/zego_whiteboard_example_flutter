import 'package:flutter/cupertino.dart';
import 'package:zego_superboard/zego_superboard.dart';

mixin SuperBoardEventMixin {
  void initEventHandler() {
    ZegoSuperBoardEngine.onError = onError;
    ZegoSuperBoardEngine.onRemoteSuperBoardSubViewAdded =
        onRemoteSuperBoardSubViewAdded;
    ZegoSuperBoardEngine.onRemoteSuperBoardSubViewRemoved =
        onRemoteSuperBoardSubViewRemoved;
    ZegoSuperBoardEngine.onRemoteSuperBoardSubViewSwitched =
        onRemoteSuperBoardSubViewSwitched;
    ZegoSuperBoardEngine.onRemoteSuperBoardAuthChanged =
        onRemoteSuperBoardAuthChanged;
    ZegoSuperBoardEngine.onRemoteSuperBoardGraphicAuthChanged =
        onRemoteSuperBoardGraphicAuthChanged;
  }

  void uninitEventHandler() {
    ZegoSuperBoardEngine.onError = null;
    ZegoSuperBoardEngine.onRemoteSuperBoardSubViewAdded = null;
    ZegoSuperBoardEngine.onRemoteSuperBoardSubViewRemoved = null;
    ZegoSuperBoardEngine.onRemoteSuperBoardSubViewSwitched = null;
    ZegoSuperBoardEngine.onRemoteSuperBoardAuthChanged = null;
    ZegoSuperBoardEngine.onRemoteSuperBoardGraphicAuthChanged = null;
  }

  void onError(int errorCode) {
    debugPrint('onError errorCode:$errorCode');
  }

  void onRemoteSuperBoardSubViewAdded(ZegoSuperBoardSubViewModel subViewModel) {
    debugPrint("onRemoteSuperBoardSubViewAdded ${subViewModel.toString()}");
  }

  void onRemoteSuperBoardSubViewRemoved(
      ZegoSuperBoardSubViewModel subViewModel) {
    debugPrint("onRemoteSuperBoardSubViewRemoved ${subViewModel.toString()}");
  }

  void onRemoteSuperBoardSubViewSwitched(String uniqueID) {
    debugPrint('onRemoteSuperBoardSubViewSwitched uniqueID:$uniqueID');
  }

  void onRemoteSuperBoardAuthChanged(Map<dynamic, dynamic> authInfo) {}

  void onRemoteSuperBoardGraphicAuthChanged(Map<dynamic, dynamic> authInfo) {}
}
