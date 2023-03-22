import 'package:flutter/material.dart';
import 'package:zego_sdk_quick_start/superboard_event_mixin.dart';
import 'package:zego_superboard/zego_superboard.dart';

const listWidth = 80.0;
const spaceWidth = 5.0;
const spaceHeight = 5.0;
const buttonHeight = 30.0;
const controlButtonSize = 30.0;

class SuperBoardWidget extends StatefulWidget {
  const SuperBoardWidget({super.key});

  @override
  State<StatefulWidget> createState() => SuperBoardWidgetState();
}

class SuperBoardWidgetState extends State<SuperBoardWidget>
    with TickerProviderStateMixin, SuperBoardEventMixin {
  final isBoardSwitchingNotifier = ValueNotifier<bool>(false);
  final isBoardCreatingNotifier = ValueNotifier<bool>(false);

  final currentBoardModelNotifier =
      ValueNotifier<ZegoSuperBoardSubViewModel?>(null);
  final boardListsNotifier =
      ValueNotifier<List<ZegoSuperBoardSubViewModel>>([]);

  final superBoardViewNotifier = ValueNotifier<Widget?>(null);

  BoxDecoration get buttonDecoration => BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
      );

  int get blankBoardCount => boardListsNotifier.value
      .where((element) => element.fileType == ZegoSuperBoardFileType.unknown)
      .toList()
      .length;

  @override
  void initState() {
    super.initState();

    initEventHandler();

    ZegoSuperBoardEngine.instance.createSuperBoardView((id) {}).then((value) {
      superBoardViewNotifier.value = value;
    });

    syncWhiteboardList().then((value) {
      if (boardListsNotifier.value.isNotEmpty) {
        syncCurrentModel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    uninitEventHandler();
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
            boardList(),
            currentWhiteboard(),
            currentWhiteboardControls(),
            createBoardControls(constraints.maxWidth, constraints.maxHeight),
            closeButton(),
          ],
        );
      }),
    );
  }

  Widget boardList() {
    return Positioned(
      left: spaceWidth,
      top: spaceWidth,
      bottom: 2 * buttonHeight + 3 * spaceHeight,
      child: Container(
        width: listWidth,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
        ),
        child: boardListView(),
      ),
    );
  }

  Widget boardListView() {
    return ValueListenableBuilder<List<ZegoSuperBoardSubViewModel>>(
      valueListenable: boardListsNotifier,
      builder: (context, boardList, _) {
        return Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: boardList.length,
            itemBuilder: (context, index) {
              final board = boardList.elementAt(index);
              return ValueListenableBuilder<bool>(
                valueListenable: isBoardSwitchingNotifier,
                builder: (context, isWhiteboardSwitching, _) {
                  return GestureDetector(
                    onTap: isWhiteboardSwitching
                        ? null
                        : () {
                            switchSuperBoardSubView(board);
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: spaceHeight / 2,
                      ),
                      child:
                          ValueListenableBuilder<ZegoSuperBoardSubViewModel?>(
                        valueListenable: currentBoardModelNotifier,
                        builder: (context, currentModel, _) {
                          return boardListButton(board, currentModel);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget boardListButton(
    ZegoSuperBoardSubViewModel listWhiteboard,
    ZegoSuperBoardSubViewModel? currentModel,
  ) {
    return Container(
      height: buttonHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: spaceWidth,
        vertical: spaceHeight,
      ),
      decoration: BoxDecoration(
        color: listWhiteboard.uniqueID == currentModel?.uniqueID
            ? Colors.blue
            : Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        listWhiteboard.name,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  Widget currentWhiteboard() {
    return Positioned(
      left: spaceWidth + listWidth + spaceWidth,
      right: spaceWidth,
      top: spaceWidth,
      bottom: controlButtonSize + spaceHeight * 2,
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
      left: listWidth + spaceWidth * 2,
      right: spaceWidth,
      bottom: spaceWidth,
      child: ValueListenableBuilder<ZegoSuperBoardSubViewModel?>(
        valueListenable: currentBoardModelNotifier,
        builder: (context, currentModel, _) {
          if (null == currentModel) {
            return Container();
          }

          currentModel.syncCurrentPage();
          currentModel.syncPageCount();

          return Container(
            height: controlButtonSize,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boardControlButton(
                  currentModel: currentModel,
                  iconData: Icons.skip_previous,
                  onPressed: () {
                    currentModel.flipToPrePage();
                  },
                ),
                const SizedBox(width: spaceWidth),
                boardPageInfo(currentModel),
                const SizedBox(width: spaceWidth),
                boardControlButton(
                  currentModel: currentModel,
                  iconData: Icons.skip_next,
                  onPressed: () {
                    currentModel.flipToNextPage();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget boardPageInfo(ZegoSuperBoardSubViewModel currentModel) {
    return Row(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: currentModel.currentPageNotifier,
          builder: (context, currentPage, _) {
            return Text('$currentPage');
          },
        ),
        const Text("/"),
        ValueListenableBuilder<int>(
          valueListenable: currentModel.pageCountNotifier,
          builder: (context, pageCount, _) {
            return Text('$pageCount');
          },
        ),
      ],
    );
  }

  Widget boardControlButton({
    required ZegoSuperBoardSubViewModel currentModel,
    required IconData? iconData,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: controlButtonSize,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(
          controlButtonSize / 6.0,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        iconSize: controlButtonSize / 2.0,
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget createBoardControls(double boardWidth, double boardHeight) {
    return Positioned(
      left: spaceWidth,
      bottom: spaceWidth,
      child: Column(
        children: [
          SizedBox(
            width: listWidth,
            height: buttonHeight,
            child: ValueListenableBuilder<bool>(
              valueListenable: isBoardCreatingNotifier,
              builder: (context, isWhiteboardCreating, _) {
                return OutlinedButton(
                    onPressed: isWhiteboardCreating
                        ? null
                        : () {
                            onBlankWBPressed(boardWidth, boardHeight);
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
              valueListenable: isBoardCreatingNotifier,
              builder: (context, isWhiteboardCreating, _) {
                return OutlinedButton(
                    onPressed: isWhiteboardCreating
                        ? null
                        : () {
                            onFileWBPressed(boardWidth, boardHeight);
                          },
                    child: const Text("File"));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: spaceHeight * 2,
      right: spaceWidth * 2,
      child: SizedBox(
        width: controlButtonSize,
        height: controlButtonSize,
        child: FloatingActionButton(
          onPressed: () {
            final uniqueID = currentBoardModelNotifier.value?.uniqueID ?? '';
            if (uniqueID.isNotEmpty) {
              ZegoSuperBoardEngine.instance
                  .destroySuperBoardSubView(uniqueID)
                  .then((value) {
                boardListsNotifier.value = boardListsNotifier.value
                    .where((model) => model.uniqueID != uniqueID)
                    .toList();
                if (boardListsNotifier.value.isNotEmpty) {
                  switchSuperBoardSubView(boardListsNotifier.value.first);
                } else {
                  currentBoardModelNotifier.value = null;
                }
              });
            }
          },
          backgroundColor: Colors.black.withOpacity(0.5),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void onBlankWBPressed(double boardWidth, double boardHeight) {
    final existedBlankWhiteboardList = boardListsNotifier.value
        .where((element) => element.fileType == ZegoSuperBoardFileType.unknown)
        .toList();
    if (existedBlankWhiteboardList.isNotEmpty) {
      /// blank board is exist, not create anymore, switch
      switchSuperBoardSubView(existedBlankWhiteboardList.first);

      return;
    }

    if (isBoardCreatingNotifier.value) {
      return;
    }
    isBoardCreatingNotifier.value = true;

    ZegoSuperBoardEngine.instance
        .createWhiteboardView(ZegoCreateWhiteboardConfig(
      name: 'Blank_$blankBoardCount',
      perPageWidth: boardWidth.toInt(),
      perPageHeight: boardHeight.toInt(),
      pageCount: 1,
    ))
        .then((result) {
      if (0 != result.errorCode) {
        debugPrint("create normal board error, ${result.errorCode}");
        return;
      }

      if (null != result.subViewModel) {
        isBoardCreatingNotifier.value = false;

        boardListsNotifier.value = [
          ...boardListsNotifier.value,
          result.subViewModel!
        ];
        currentBoardModelNotifier.value = result.subViewModel;
      } else {
        /// force sync list
        syncWhiteboardList().then((value) {
          isBoardCreatingNotifier.value = false;
        });
        currentBoardModelNotifier.value = result.subViewModel;
      }
    });
  }

  void onFileWBPressed(double width, double height) {
    const targetFileID = 'ppEoHhuIKVP7WYoK';

    final existedWhiteboardList = boardListsNotifier.value
        .where((element) => element.fileID == targetFileID)
        .toList();
    if (existedWhiteboardList.isNotEmpty) {
      /// target file id is exist, not create anymore, switch
      switchSuperBoardSubView(existedWhiteboardList.first);

      return;
    }

    if (isBoardCreatingNotifier.value) {
      return;
    }
    isBoardCreatingNotifier.value = true;

    ZegoSuperBoardEngine.instance
        .createFileView(ZegoCreateFileConfig(
      fileID: 'ppEoHhuIKVP7WYoK',
    ))
        .then((result) {
      if (0 != result.errorCode) {
        debugPrint("create file board error, ${result.errorCode}");
        return;
      }

      if (null != result.subViewModel) {
        isBoardCreatingNotifier.value = false;

        boardListsNotifier.value = [
          ...boardListsNotifier.value,
          result.subViewModel!
        ];
        currentBoardModelNotifier.value = result.subViewModel;
      } else {
        /// force sync list
        syncWhiteboardList().then((value) {
          isBoardCreatingNotifier.value = false;
        });
        currentBoardModelNotifier.value = result.subViewModel;
      }
    });
  }

  Future<void> syncWhiteboardList() async {
    await ZegoSuperBoardEngine.instance
        .querySuperBoardSubViewList()
        .then((result) {
      boardListsNotifier.value = result.subViewModelList;
    });
  }

  Future<void> syncCurrentModel() async {
    ZegoSuperBoardEngine.instance.getModel().then((model) {
      currentBoardModelNotifier.value = model;
    });
  }

  void switchSuperBoardSubView(ZegoSuperBoardSubViewModel targetWhiteboard) {
    debugPrint("switchSuperBoardSubView ${targetWhiteboard.name} 1");
    if (isBoardSwitchingNotifier.value) {
      debugPrint("switchSuperBoardSubView ${targetWhiteboard.name} 2");
      return;
    }

    isBoardSwitchingNotifier.value = true;

    debugPrint("switchSuperBoardSubView ${targetWhiteboard.name} 3");
    ZegoSuperBoardEngine.instance
        .switchSuperBoardSubView(
      targetWhiteboard.uniqueID,
    )
        .then((value) {
      debugPrint("switchSuperBoardSubView ${targetWhiteboard.name} 4");
      isBoardSwitchingNotifier.value = false;
      currentBoardModelNotifier.value = targetWhiteboard;
    });
  }

  @override
  void onRemoteSuperBoardSubViewAdded(ZegoSuperBoardSubViewModel subViewModel) {
    boardListsNotifier.value = [...boardListsNotifier.value, subViewModel];

    syncCurrentModel();
  }

  @override
  void onRemoteSuperBoardSubViewRemoved(
      ZegoSuperBoardSubViewModel subViewModel) {
    boardListsNotifier.value = boardListsNotifier.value
        .where((model) => model.uniqueID != subViewModel.uniqueID)
        .toList();

    syncCurrentModel();
  }

  @override
  void onRemoteSuperBoardSubViewSwitched(String uniqueID) {
    final queryList = boardListsNotifier.value
        .where((element) => element.uniqueID == uniqueID)
        .toList();
    if (queryList.isNotEmpty) {
      currentBoardModelNotifier.value = queryList.first;
    } else {
      currentBoardModelNotifier.value = null;
    }
  }
}
