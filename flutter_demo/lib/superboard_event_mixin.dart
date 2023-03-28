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

  void onError(int errorCode) {}

  void onRemoteSuperBoardSubViewAdded(Map<dynamic, dynamic> subViewModel) {}

  void onRemoteSuperBoardSubViewRemoved(Map<dynamic, dynamic> subViewModel) {}

  void onRemoteSuperBoardSubViewSwitched(String uniqueID) {}

  void onRemoteSuperBoardAuthChanged(Map<String, int> authInfo) {}

  void onRemoteSuperBoardGraphicAuthChanged(Map<String, int> authInfo) {}
}
