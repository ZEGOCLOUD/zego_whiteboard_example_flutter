import 'package:flutter/material.dart';
import 'package:zego_superwhiteboard/zego_superwhiteboard.dart';

const listWidth = 50.0;
const spaceWidth = 5.0;
const buttonHeight = 30.0;

class WhiteboardWidget extends StatefulWidget {
  const WhiteboardWidget({super.key});

  @override
  State<StatefulWidget> createState() => WhiteboardWidgetState();
}

class WhiteboardWidgetState extends State<WhiteboardWidget>
    with TickerProviderStateMixin {
  final currentModelNotifier = ValueNotifier<ZegoSuperBoardSubViewModel?>(null);
  final whiteboardListsNotifier =
      ValueNotifier<List<ZegoSuperBoardSubViewModel>>([]);

  BoxDecoration get buttonDecoration => BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
      );

  @override
  void initState() {
    super.initState();

    List<ZegoSuperBoardSubViewModel> subViewModelList = [];

    //  test
    for (int i = 0; i < 5; i++) {
      subViewModelList.add(ZegoSuperBoardSubViewModel(name: 'wb_$i'));
    }
    whiteboardListsNotifier.value = subViewModelList;

    ZegoSuperBoardEngine.instance
        .querySuperBoardSubViewList()
        .then((result) {
      whiteboardListsNotifier.value = result.subViewModelList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.8)),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            whiteboardList(),
            currentWhiteboard(),
            controlBar(constraints.maxWidth, constraints.maxHeight),
          ],
        );
      }),
    );
  }

  Widget whiteboardList() {
    return Positioned(
        left: spaceWidth,
        top: spaceWidth,
        bottom: spaceWidth,
        child: SizedBox(
          width: listWidth,
          child: ValueListenableBuilder(
            valueListenable: whiteboardListsNotifier,
            builder: (context, whiteboardList, _) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: whiteboardList.length,
                itemBuilder: (context, index) {
                  final whiteboard = whiteboardList.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      currentModelNotifier.value = whiteboard;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        whiteboard.name,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }

  Widget currentWhiteboard() {
    return Positioned(
      left: spaceWidth + listWidth + spaceWidth,
      right: spaceWidth,
      top: spaceWidth,
      bottom: spaceWidth,
      child: ValueListenableBuilder(
        valueListenable: currentModelNotifier,
        builder: (context, whiteboard, _) {
          if (null == whiteboard) {
            return const Text("whiteboard is null");
          }

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              color: Colors.black.withOpacity(0.05),
            ),
            child: Text(whiteboard.name),
          );
        },
      ),
    );
  }

  Widget controlBar(double width, double height) {
    return Positioned(
      left: spaceWidth,
      bottom: spaceWidth,
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              onNormalWBPressed(width, height);
            },
            child: const Text("Normal"),
          ),
          const SizedBox(height: spaceWidth),
          OutlinedButton(
            onPressed: () {
              onFileWBPressed(width, height);
            },
            child: const Text("File"),
          ),
        ],
      ),
    );
  }

  void onNormalWBPressed(double width, double height) {
    ZegoSuperBoardEngine.instance
        .createWhiteboardView(ZegoCreateWhiteboardConfig(
      name: 'WhiteBoard',
      perPageWidth: width.toInt(),
      perPageHeight: height.toInt(),
      pageCount: 1,
    ))
        .then((result) {
      if (0 != result.errorCode) {
        debugPrint("create normal whiteboard error, ${result.errorCode}");
        return;
      }

      /// todo@yuyj
      result.subViewModel;
    });
  }

  void onFileWBPressed(double width, double height) {
    ZegoSuperBoardEngine.instance
        .createFileView(ZegoCreateFileConfig(
      fileID: 'ppEoHhuIKVP7WYoK',
    ))
        .then((result) {
      if (0 != result.errorCode) {
        debugPrint("create file whiteboard error, ${result.errorCode}");
        return;
      }

      /// todo@yuyj
      result.subViewModel;
    });
  }
}
