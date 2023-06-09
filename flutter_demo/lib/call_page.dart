import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_superboard/zego_superboard.dart';

import 'zegocloud_token.dart';
import 'constants.dart';
import 'superboard_widget.dart';

class CallPage extends StatefulWidget {
  const CallPage(
      {key,
      required this.localUserID,
      required this.localUserName,
      required this.roomID});

  final String localUserID;
  final String localUserName;
  final String roomID;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  Widget? localView;
  int? localViewID;
  Widget? remoteView;
  int? remoteViewID;

  final cameraStateNotifier = ValueNotifier<bool>(true);
  final microphoneStateNotifier = ValueNotifier<bool>(true);
  final isWhiteboardReadyNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    startListenEvent();
    loginRoom();
    super.initState();
  }

  @override
  void dispose() {
    stopListenEvent();
    logoutRoom();

    isWhiteboardReadyNotifier.value = false;

    if (localViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
    }
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call Page")),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          var value = 16.0 / 9.0;
          if (kIsWeb) { value = 9.0 / 16.0;};
          var videoViewWidth = constraints.maxWidth / 2 - 10;
          videoViewWidth = videoViewWidth > 300 ? 300 : videoViewWidth;
          final videoViewHeight = value * videoViewWidth;

          final whiteboardWidth = constraints.maxWidth / 2 - 10;
          final whiteboardHeight = constraints.maxHeight - videoViewHeight - 20;

          return Stack(
            children: [
              whiteboardWidget(whiteboardWidth, whiteboardHeight),
              localViewWidget(videoViewWidth, videoViewHeight),
              remoteViewWidget(videoViewWidth, videoViewHeight),
              controlBar(),
            ],

          );
        },
      ),
    );
  }

  Widget localViewWidget(double width, double height) {
    return Positioned(
      bottom: 5,
      left: 5,
      child: SizedBox(
        width: width,
        height: height,
        child: localView ?? Container(color: Colors.transparent),
      ),
    );
  }

  Widget remoteViewWidget(double width, double height) {
    return Positioned(
      bottom: 5,
      right: 5,
      child: SizedBox(
        width: width,
        height: height,
        child: remoteView ?? Container(color: Colors.transparent),
      ),
    );
  }

  Widget whiteboardWidget(double width, double height) {
    return Positioned(
      top: 5,
      left: 5,
      right: 5,
      child: Container(
        width: width,
        height: height,
        child: ValueListenableBuilder<bool>(
          valueListenable: isWhiteboardReadyNotifier,
          builder: (context, isWhiteboardReady, _) {
            return isWhiteboardReady ? const SuperBoardWidget() : Container();
          },
        ),
      ),
    );
  }

  Widget controlBar() {
    const spacingWidth = 10.0;
    const buttonSize = 40.0;

    return Positioned(
      bottom: spacingWidth,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: ValueListenableBuilder(
              valueListenable: cameraStateNotifier,
              builder: (context, isCameraEnabled, _) {
                return IconButton(
                  onPressed: () {
                    cameraStateNotifier.value = !cameraStateNotifier.value;
                    ZegoExpressEngine.instance
                        .enableCamera(cameraStateNotifier.value);
                  },
                  icon: Icon(
                    isCameraEnabled == true ? Icons.camera_alt : Icons.cancel,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: spacingWidth),
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.call_end,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: spacingWidth),
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: microphoneStateNotifier,
              builder: (context, isMicrophoneEnabled, _) {
                return IconButton(
                  onPressed: () {
                    ZegoExpressEngine.instance
                        .muteMicrophone(microphoneStateNotifier.value);
                    microphoneStateNotifier.value =
                        !microphoneStateNotifier.value;
                  },
                  icon: Icon(
                    isMicrophoneEnabled ? Icons.mic : Icons.mic_off,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void loginRoom() {
    // The value of `userID` is generated locally and must be globally unique.
    final user = ZegoUser(widget.localUserID, widget.localUserName);

    // The value of `roomID` is generated locally and must be globally unique.
    final roomID = widget.roomID;

    // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
      ..isUserStatusNotify = true;

    if (kIsWeb) {
      roomConfig.token =
          ZegoTokenUtils.generateToken(appID, serverSecret, widget.localUserID);
    }

    ZegoSuperBoardEngine.instance
        .init(ZegoSuperBoardInitConfig(
      appID: appID,
      appSign: appSign,
      userID: user.userID,
      token: ZegoTokenUtils.generateToken(appID, serverSecret, user.userID),
    ))
        .then((value) {

        ZegoExpressEngine.instance
            .loginRoom(roomID, user, config: roomConfig)
            .then((ZegoRoomLoginResult loginRoomResult) {
          debugPrint(
              'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
          isWhiteboardReadyNotifier.value = true;
          if (loginRoomResult.errorCode == 0) {
            startPreview();
            startPublish();
          } else {
            // Login room failed
          }
        });
    });


    // log in to a room
    // Users must log in to the same room to call each other.

  }

  void logoutRoom() {
    ZegoExpressEngine.instance.logoutRoom(widget.roomID);

    ZegoSuperBoardEngine.instance.uninit();
  }

  void startListenEvent() {
    // Callback for updates on the status of other users in the room.
    // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
    ZegoExpressEngine.onRoomUserUpdate =
        (roomID, updateType, List<ZegoUser> userList) {
      debugPrint(
          'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };
    // Callback for updates on the status of the streams in the room.
    ZegoExpressEngine.onRoomStreamUpdate =
        (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      debugPrint(
          'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };
    // Callback for updates on the current user's room connection status.
    ZegoExpressEngine.onRoomStateUpdate =
        (roomID, state, errorCode, extendedData) {
      debugPrint(
          'onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };

    // Callback for updates on the current user's stream publishing changes.
    ZegoExpressEngine.onPublisherStateUpdate =
        (streamID, state, errorCode, extendedData) {
      debugPrint(
          'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };
  }

  void stopListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  void startPreview() {
    ZegoExpressEngine.instance.createCanvasView((viewID) {
      localViewID = viewID;
      ZegoCanvas previewCanvas =
          ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      setState(() => localView = canvasViewWidget);
    });
  }

  void stopPreview() {
    ZegoExpressEngine.instance.stopPreview();
  }

  void startPublish() {
    // After calling the `loginRoom` method, call this method to publish streams.
    // The StreamID must be unique in the room.
    String streamID = '${widget.roomID}_${widget.localUserID}_call';
    ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  void stopPublish() {
    ZegoExpressEngine.instance.stopPublishingStream();
  }

  void startPlayStream(String streamID) {
    // Start to play streams. Set the view for rendering the remote streams.
    ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((canvasViewWidget) {
      setState(() => remoteView = canvasViewWidget);
    });
  }

  void stopPlayStream(String streamID) {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
    setState(() => remoteView = null);
  }
}
