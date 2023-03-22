# zego_superboard


## API

### ZegoSuperBoardEngine

| API | Description|
| ---- | :---- |
| `init(ZegoSuperBoardInitConfig config) => Future<int>` | Before using ZegoSuperBoard SDK for functional calls, it is necessary to initialize the SDK first.   |
| `uninit() => Future<void>`    | Uninitialize the SDK.|
| `getSDKVersion() => Future<String>`| Obtain the SDK version number. |
| `clearCache() => Future<void>`| Clear cache resources related to files and whiteboards. |
| `clear() => Future<void>`| Empty resources in the room called upon checkout.  |
| `renewToken(String token) => Future<void>`   | Call time: after initializing the SDK, with the help of the upcoming expiration callback [tokenwillexpire] interface of zego SDK, receive the upcoming expiration callback of the token, and actively update the file service token of the super whiteboard. Scope of influence: the expiration time contained in the token will trigger the [tokenwillexpire] callback 30s before expiration. Related callback: [tokenwillexpire]. Related interfaces: None. |
| `enableRemoteCursorVisible(bool visible) => Future<void>`   | Set whether to enable the display of remote custom cursor.   |
| `isCustomCursorEnabled() => Future<bool>`    | Whether to turn on the cursor display.   |
| `isEnableResponseScale() => Future<bool>`    | Get whether it will respond to the zoom factor synchronized by other users. |
| `isEnableSyncScale() => Future<bool>`   | Get whether the current zoom factor will be synchronized to others.    |
| `isRemoteCursorVisibleEnabled() => Future<bool>`  | Whether the remote cursor is on.    |
| `setCustomizedConfig(String key, String value) => Future<void>`  | Set configuration items, such as "logPath" for the directory address where the SDK logs are stored, and "cachePath" for the directory address where the SDK caches are stored.  |
| `createWhiteboardView(ZegoCreateWhiteboardConfig config) => Future<ZegoSuperBoardCreateWhiteboardViewResult>` | Creating a pure whiteboard.    |
| `createFileView(ZegoCreateFileConfig config) => Future<ZegoSuperBoardCreateFileViewResult>`    | Create a file.  |
| `destroySuperBoardSubView(String uniqueID) => Future<int>`  | Destroy a specified SuperBoardSubView view.   |
| `querySuperBoardSubViewList() => Future<ZegoSuperBoardQueryListResult>`    | Query the server for the list of SuperBoardSubView that currently exists.   |
| `getSuperBoardSubViewModelList() => Future<ZegoSuperBoardGetListResult>`   | Get information about the superBoardSubView saved by the SDK.|
| `enableSyncScale(bool enable) => Future<void>`    | Set whether to synchronize the scaling to other members in the room.   |
| `enableResponseScale(bool enable) => Future<void>`| Set whether to respond to the scaling of other members in the room.    |
| `setToolType(ZegoSuperBoardTool tool) => Future<void>` | Set the whiteboard tool type.  |
| `getToolType() => Future<ZegoSuperBoardTool>`| Get the current whiteboard tool type being used.   |
| `setFontBold(bool bold) => Future<void>`| Set text bold.  |
| `isFontBold() => Future<bool>`| Get whether the text is bold.  |
| `setFontItalic(bool italic) => Future<void>` | Set whether the text tool is in italic.  |
| `isFontItalic()`    | Get whether the text is in italic.  |
| `setFontSize(int size)`  | Set the text size.   |
| `getFontSize()`| Get the text size.   |
| `setBrushSize(int size)` | Set the brush size.  |
| `getBrushSize()`    | Get the brush size.  |
| `setBrushColor(Color color)`  | Set the brush color. |
| `getBrushColor()`   | Get the brush color. |

### ZegoSuperBoardView

This class mainly realizes the function of switching SuperBoardSubView and Excel file sheet in SuperBoardSubView.
After initializing SDK, You can get the ZegoSuperBoardView object directly using the ZegoSuperBoardManager, through the outside of the class does not need to deal with the ZegoSuperBoardView switching and synchronization logic, ZegoSuperBoardView handles the logic for switching synchronised presentations internally.

| API  | Description  |
| ---- | :---- |
| `createSuperBoardView(Function(int uniqueID) onViewCreated, {Key? key})` | Create a Super Whiteboard Container that manages the lifecycle of switchSuperBoardSubView internally. Callback after the container is created. |
| `switchSuperBoardSubView(String uniqueID)` | Switch to the specified SuperBoardSubView. |
| `switchSuperBoardSubExcelView(String uniqueID, int sheetIndex)`| Switch to the specified Excel view.   |

### ZegoSuperBoardSubView

describe a pure whiteboard or file whiteboard.


| API  | Description    |
| --- | :----|
| `getThumbnailUrlList()`| Get a list of thumbnails for the current file, supporting file formats such as PDF, PPT, dynamic PPT, and H5. |
| `getModel()` | Get the model data corresponding to the whiteboard.    |
| `inputText()`| Add text to the whiteboard view. After calling, an input box will pop up from the bottom of the whiteboard.   |
| `addText(String text, int positionX, int positionY)` | Add custom text to the whiteboard. |
| `undo()`| Undo the previous operation on the whiteboard.    |
| `redo()`| Redo the operation that was previously undone on the whiteboard. |
| `clearCurrentPage()`   | Clear the graphics on the current page of the whiteboard.   |
| `clearAllPage()`  | Clear the graphics on all pages of the whiteboard.|
| `setOperationMode(ZegoSuperBoardOperationMode mode)` | Set the operation mode of the current whiteboard. |
| `flipToPage(int targetPage)`| Jump to the specified page on the whiteboard.|
| `flipToPrePage()` | Jump to the previous page on the whiteboard. |
| `flipToNextPage()`| Jump to the next page on the whiteboard.|
| `getCurrentPage()`| Get the page number of the currently displayed content.|
| `getPageCount()`  | Get the total number of pages on the whiteboard.  |
| `getVisibleSize()`| Get the size of the visible area.  |
| `clearSelected()` | Delete the selected graphics on the whiteboard.   |
| `setWhiteboardBackgroundColor(Color color)`| Set the background color of the whiteboard.  |


