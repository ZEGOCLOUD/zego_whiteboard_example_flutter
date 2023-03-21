import 'package:flutter/material.dart';
import 'package:zego_superwhiteboard/zego_superwhiteboard.dart';

const listWidth = 80.0;
const spaceWidth = 5.0;
const spaceHeight = 5.0;
const buttonHeight = 30.0;
const controlButtonWidth = 50.0;

class WhiteboardWidget extends StatefulWidget {
  const WhiteboardWidget({super.key});

  @override
  State<StatefulWidget> createState() => WhiteboardWidgetState();
}

class WhiteboardWidgetState extends State<WhiteboardWidget>
    with TickerProviderStateMixin {
  final isWhiteboardCreatingNotifier = ValueNotifier<bool>(false);

  final currentModelNotifier = ValueNotifier<ZegoSuperBoardSubViewModel?>(null);
  final whiteboardListsNotifier =
      ValueNotifier<List<ZegoSuperBoardSubViewModel>>([]);

  final superBoardViewNotifier = ValueNotifier<Widget?>(null);

  BoxDecoration get buttonDecoration => BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
      );

  int get blankWBCount => whiteboardListsNotifier.value
      .where((element) => element.fileType == ZegoSuperBoardFileType.unknown)
      .toList()
      .length;

  @override
  void initState() {
    super.initState();

    ZegoSuperBoardEngine.instance.createSuperBoardView((id) {}).then((value) {
      superBoardViewNotifier.value = value;
    });

    syncWhiteboardList();
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
            currentWhiteboardControls(),
            createControls(constraints.maxWidth, constraints.maxHeight),
          ],
        );
      }),
    );
  }

  Widget whiteboardList() {
    return Positioned(
        left: spaceWidth,
        top: spaceWidth,
        bottom: 2 * buttonHeight + 3 * spaceHeight,
        child: Container(
          width: listWidth,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
          ),
          child: ValueListenableBuilder(
            valueListenable: whiteboardListsNotifier,
            builder: (context, whiteboardList, _) {
              return Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: whiteboardList.length,
                  itemBuilder: (context, index) {
                    final whiteboard = whiteboardList.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        currentModelNotifier.value = whiteboard;

                        ZegoSuperBoardEngine.instance.switchSuperBoardSubView(
                          whiteboard.uniqueID,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: spaceHeight / 2,
                        ),
                        child:
                            ValueListenableBuilder<ZegoSuperBoardSubViewModel?>(
                          valueListenable: currentModelNotifier,
                          builder: (context, currentModel, _) {
                            return Container(
                              height: buttonHeight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: spaceWidth,
                                vertical: spaceHeight,
                              ),
                              decoration: BoxDecoration(
                                color: whiteboard.uniqueID ==
                                        currentModel?.uniqueID
                                    ? Colors.blue
                                    : Colors.blue.withOpacity(0.1),
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                whiteboard.name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
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
      bottom: buttonHeight + spaceWidth,
      child: ValueListenableBuilder<Widget?>(
        valueListenable: superBoardViewNotifier,
        builder: (context, superBoardView, _) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.3)),
            ),
            child: superBoardView,
          );
        },
      ),
    );
  }

  Widget currentWhiteboardControls() {
    return Positioned(
      left: listWidth + spaceWidth,
      right: spaceWidth,
      bottom: spaceWidth,
      child: ValueListenableBuilder<ZegoSuperBoardSubViewModel?>(
        valueListenable: currentModelNotifier,
        builder: (context, currentModel, _) {
          if (null == currentModel) {
            return Container();
          }

          currentModel.syncCurrentPage();
          currentModel.syncPageCount();

          return Container(
            height: buttonHeight,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: controlButtonWidth,
                  height: buttonHeight,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {
                      currentModel.flipToPrePage();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: spaceWidth),
                Row(
                  children: [
                    ValueListenableBuilder<int>(
                        valueListenable: currentModel.currentPageNotifier,
                        builder: (context, currentPage, _) {
                          return Text('$currentPage');
                        }),
                    const Text("/"),
                    ValueListenableBuilder<int>(
                        valueListenable: currentModel.pageCountNotifier,
                        builder: (context, pageCount, _) {
                          return Text('$pageCount');
                        }),
                  ],
                ),
                Container(
                  width: controlButtonWidth,
                  height: buttonHeight,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {
                      currentModel.flipToNextPage();
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget createControls(double whiteboardWidth, double whiteboardHeight) {
    return Positioned(
      left: spaceWidth,
      bottom: spaceWidth,
      child: Column(
        children: [
          SizedBox(
            width: listWidth,
            height: buttonHeight,
            child: ValueListenableBuilder<bool>(
              valueListenable: isWhiteboardCreatingNotifier,
              builder: (context, isWhiteboardCreating, _) {
                return OutlinedButton(
                    onPressed: isWhiteboardCreating
                        ? null
                        : () {
                            onBlankWBPressed(whiteboardWidth, whiteboardHeight);
                          },
                    child: const Text("Blank"));
              },
            ),
          ),
          const SizedBox(height: spaceWidth),
          SizedBox(
            width: listWidth,
            height: buttonHeight,
            child: ValueListenableBuilder<bool>(
              valueListenable: isWhiteboardCreatingNotifier,
              builder: (context, isWhiteboardCreating, _) {
                return OutlinedButton(
                    onPressed: isWhiteboardCreating
                        ? null
                        : () {
                            onFileWBPressed(whiteboardWidth, whiteboardHeight);
                          },
                    child: const Text("File"));
              },
            ),
          ),
        ],
      ),
    );
  }

  void onBlankWBPressed(double whiteboardWidth, double whiteboardHeight) {
    final existedBlankWhiteboardList = whiteboardListsNotifier.value
        .where((element) => element.fileType == ZegoSuperBoardFileType.unknown)
        .toList();
    if (existedBlankWhiteboardList.isNotEmpty) {
      /// blank whiteboard is exist, not create anymore, switch
      currentModelNotifier.value = existedBlankWhiteboardList.first;
      ZegoSuperBoardEngine.instance.switchSuperBoardSubView(
        currentModelNotifier.value!.uniqueID,
      );

      return;
    }

    if (isWhiteboardCreatingNotifier.value) {
      return;
    }
    isWhiteboardCreatingNotifier.value = true;

    ZegoSuperBoardEngine.instance
        .createWhiteboardView(ZegoCreateWhiteboardConfig(
      name: 'Blank_$blankWBCount',
      perPageWidth: whiteboardWidth.toInt(),
      perPageHeight: whiteboardHeight.toInt(),
      pageCount: 1,
    ))
        .then((result) {
      if (0 != result.errorCode) {
        debugPrint("create normal whiteboard error, ${result.errorCode}");
        return;
      }

      currentModelNotifier.value = result.subViewModel;
      syncWhiteboardList().then((value) {
        isWhiteboardCreatingNotifier.value = false;
      });
    });
  }

  void onFileWBPressed(double width, double height) {
    const targetFileID = 'ppEoHhuIKVP7WYoK';

    final existedWhiteboardList = whiteboardListsNotifier.value
        .where((element) => element.fileID == targetFileID)
        .toList();
    if (existedWhiteboardList.isNotEmpty) {
      /// target file id is exist, not create anymore, switch
      currentModelNotifier.value = existedWhiteboardList.first;
      ZegoSuperBoardEngine.instance.switchSuperBoardSubView(
        currentModelNotifier.value!.uniqueID,
      );

      return;
    }

    if (isWhiteboardCreatingNotifier.value) {
      return;
    }
    isWhiteboardCreatingNotifier.value = true;

    ZegoSuperBoardEngine.instance
        .createFileView(ZegoCreateFileConfig(
      fileID: 'ppEoHhuIKVP7WYoK',
    ))
        .then((result) {
      if (0 != result.errorCode) {
        debugPrint("create file whiteboard error, ${result.errorCode}");
        return;
      }

      currentModelNotifier.value = result.subViewModel;
      syncWhiteboardList().then((value) {
        isWhiteboardCreatingNotifier.value = false;
      });
    });
  }

  Future<void> syncWhiteboardList() async {
    await ZegoSuperBoardEngine.instance
        .querySuperBoardSubViewList()
        .then((result) {
      whiteboardListsNotifier.value = result.subViewModelList;
    });
  }
}
