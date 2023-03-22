//
//  ZegoSuperBoardView.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <UIKit/UIKit.h>
#import "ZegoSuperBoardSubViewModel.h"
#import "ZegoSuperBoardDefine.h"
#import "ZegoSuperBoardCursorAttribute.h"

NS_ASSUME_NONNULL_BEGIN

/// Callback for the call results of APIs in ZegoSuperBoardSubView.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the call result after an API of ZegoSuperBoardSubView is called.
///
/// Business scenario: After an API of ZegoSuperBoardSubView is called, determine whether the call is successful.
///
/// Callback time: Call this callback after an API of ZegoSuperBoardSubView is called and ZegoSuperBoardManagerBlock is not set to nil.
///
/// Related APIs:  [addTextEditWithComplete], [addText], and [clearCurrentPage]
///
/// @param errorCode Callback error code
typedef void(^ZegoSuperBoardSubViewBlock)(ZegoSuperBoardError errorCode);

/// Callback for the call result of the API for switching Excel sheets in ZegoSuperBoardSubView.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the call result after the API for switching Excel sheets in ZegoSuperBoardSubView is called.
///
/// Business scenario: After the API for switching Excel sheets in ZegoSuperBoardSubView is called, determine whether the call is successful.
///
/// Callback time: Call this callback after the switchExcelSheet API is called and ZegoSuperBoardManagerBlock is not set to nil.
///
/// Related APIs:  [switchExcelSheet]
///
/// @param errorCode Callback error code
/// @param whiteBoardID Whiteboard ID of the sheet switched to
typedef void(^ZegoSuperBoardSubViewSwitchBlock)(ZegoSuperBoardError errorCode, unsigned long long whiteBoardID);

/// Callback of ZegoSuperBoardSubView internal changes.
///
@protocol ZegoSuperBoardSubViewDelegate <NSObject>

@optional

/// Receive the callback of the page change.
///
/// Supported version: 2.0.0
///
/// Description: When the onScrollChange callback is received, the SDK has updated the page number of the whiteboard and file. This callback can be used to obtain the latest page number displayed on the UI.
///
/// Calling time/Notification time: This callback is triggered when scrolling or page turning is performed in a file or whiteboard.
///
/// @param currentPage Current page number after page change
/// @param pageCount Total number of pages
/// @param subViewModel subViewModel of the ZegoSuperBoardSubView object
- (void)onScrollChange:(NSInteger)currentPage pageCount:(NSInteger)pageCount subViewModel:(ZegoSuperBoardSubViewModel *)subViewModel;

/// Callback for the page size change.
///
/// Supported version: 2.0.0
///
/// Description: When the onSizeChange callback is received, the SDK has updated the size of the whiteboard and file. This callback can be used to obtain the visible area size of the current SuperBoardSubView.
///
/// Calling time/Notification time: This callback is triggered when the size of the ZegoSuperBoardSubView is modified.
///
/// @param size Size of the SuperBoardSubView visible area
/// @param subViewModel subViewModel of the ZegoSuperBoardSubView object
- (void)onSizeChange:(CGSize)size subViewModel:(ZegoSuperBoardSubViewModel *)subViewModel;


/// Implement this method to respond to zooming.
///
/// After the zooming operation, this callback method is called to notify the service layer. SDK users obtain the zooming coefficient based on the method parameters.
///
/// @param scaleFactor Zooming coefficient
/// @param scaleOffsetX Horizontal offset generated during zooming
/// @param scaleOffsetY Vertical offset generated during zooming
/// @param subViewModel subViewModel of the ZegoSuperBoardSubView object
- (void)onScaleChangedWithScaleFactor:(CGFloat)scaleFactor scaleOffsetX:(CGFloat)scaleOffsetX scaleOffsetY:(CGFloat)scaleOffsetY subViewModel:(ZegoSuperBoardSubViewModel *)subViewModel;

- (void)onStepChange;

@end

/// Description: This API class is used to describe a pure whiteboard or file whiteboard.
///
/// Business scenario: Operate the currently displayed whiteboard, for example, set the status.
///
/// Note: You need to log in to the room first. Before using the obtained ZegoSuperBoardSubView, check whether it is empty.
///
/// Platform difference: none
///
@interface ZegoSuperBoardSubView : UIView

/// Description: Obtain model data of the ZegoSuperBoardSubView.
///
/// Supported version: 2.0.0 and above
///
/// Business scenario: Obtain model data of the ZegoSuperBoardSubView, such as the ZegoSuperBoardSubView ID, name, and associated file ID.
@property (nonatomic,strong,readonly) ZegoSuperBoardSubViewModel *model;

/// Description: Obtain the total number of pages.
///
/// Supported version: 2.0.0 and above
@property (nonatomic,assign,readonly) NSInteger pageCount;

/// Description: Obtain the names of all sheets in the Excel file.
///
/// Supported version: 2.0.0 and above
///
/// Business scenario: When sheets in an Excel file need to be displayed, use this method to obtain the names of all sheets in the Excel file.
///
/// Note: For non-excel files, nil is returned.
@property (nonatomic,strong,readonly) NSArray <NSString *>*excelSheetNameList;

/// Description: Obtain the name of the currently displayed sheet. For non-excel files, nil is returned.
///
/// Supported version: 2.0.0 and above
@property (nonatomic,copy,readonly) NSString *currentSheetName;

/// Description: Obtain the size of the SuperBoardSubView visible area.
///
/// Supported version: 2.0.0 and above
@property (nonatomic,assign,readonly) CGSize visibleSize;

/// Description: Set the event notification callback. If the parameter is set to nil, the set callback is cleared.
///
/// Supported version: 2.0.0 and above
@property (nonatomic,weak) id<ZegoSuperBoardSubViewDelegate> delegate;

/// Description: Obtain the page number of the currently displayed content.
///
/// Supported version: 2.0.0 and above
@property (nonatomic,assign,readonly) NSInteger currentPage;

/// Description: Obtain the currently displayed zooming ratio.
///
/// Supported version: 2.1.1 and above
@property (nonatomic,assign) CGFloat scaleFactor;

/// Delete selected diagram elements.
///
/// Supported version: 2.0.0 and above
///
/// Description: Select some diagram elements using the selection tool of the whiteboard and call this method to delete the selected diagram elements.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Calling time: Call this API after the SuperBoardSubView list is obtained.
///
/// @param complete Operation result callback
- (void)clearSelected:(ZegoSuperBoardSubViewBlock)complete;

/// Obtain the thumbnail list of the current file. Only PDF, PPT, animated PPT, and H5 files are supported.
///
/// Supported version: 2.0.0 and above
///
/// Description: To preview a file, use this API to obtain the corresponding preview images. You can click the preview images to turn pages.
///
/// Business scenario: Display the preview image of each page in a file.
///
/// Calling time: Call this API after the file is loaded. If not, an empty list is returned.
///
/// Use restriction: Only PDF, PPT, animated PPT, and H5 files are supported. An empty list is returned for other types of files.
///
/// @return URL list for thumbnails of each page in the file.
- (NSArray *)getThumbnailUrlList;

/// Obtain notes on the specified page of a PPT file.
///
/// Supported version: 2.0.0 and above
///
/// Description: Obtain notes on the specified page of a PPT file.
///
/// Business scenario: Obtain notes on the specified page of a PPT file.
///
/// Use restriction: Only PPT and animated PPT files are supported. null is returned for other types of files.
///
/// Calling time: Call this API after loadFile is successful.
///
/// @param page Specified page number, which starts from 1.
///
/// @return Notes on the page. If no notes are available, null is returned.
- (NSString *)getPPTNotes:(NSInteger)page;

/// Add text to a whiteboard view. After this API is called, an input box is displayed from the bottom of the whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Add text to a whiteboard view. After this API is called, an input box is displayed from the bottom of the whiteboard.
///
/// Business scenario: Add text to a whiteboard view. After this API is called, an input box is displayed from the bottom of the whiteboard.
///
/// Default value: The default content in the input box is "Text". You can set the default text using the customText attribute of ZegoSuperBoardManager. By default, the default text is displayed in the middle of the current whiteboard area.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Related APIs: customText attribute of ZegoSuperBoardManager
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback,如果有创建图元的权限，则会成功，否则失败
- (void)addTextEditWithComplete:(nullable ZegoSuperBoardSubViewBlock)complete;

/// Add custom text to a whiteboard view.
///
/// Supported version: 2.0.0 and above
///
/// Description: Add text to a whiteboard view. You can add the text to the specified position of the whiteboard view. The keyboard input box will not be displayed.
///
/// Business scenario: When text is added to the specified position in a whiteboard view, a new text diagram element is created.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param text String content of the text diagram element to be added
/// @param positionX Horizontal offset to the top left corner of the viewport, for example, 10. viewport indicates the writable area.
/// @param positionY Vertical offset to the top left corner of the viewport, for example, 10. viewport indicates the writable area.
/// @param complete Operation result callback,如果有创建图元的权限，则会成功，否则失败
- (void)addText:(NSString *)text positionX:(int)positionX positionY:(int)positionY complete:(ZegoSuperBoardSubViewBlock)complete;

/// Cancel the previous operation on a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Cancel the previous operation on a whiteboard.
///
/// Business scenario: Perform whiteboard-related operations.
///
/// Related APIs: redo
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
- (void)undo;

/// Restore the previous operation canceled on a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Restore the previous operation canceled on a whiteboard.
///
/// Business scenario: Perform whiteboard-related operations.
///
/// Related APIs: undo
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
- (void)redo;

/// Clear diagram elements on the current page of a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Clear diagram elements on the current page of a whiteboard.
///
/// Business scenario: Perform whiteboard-related operations.
///
/// Related APIs: clearAllPage
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback。如果删除当前页的图元成功，则会返回成功，否则失败
- (void)clearCurrentPage:(ZegoSuperBoardSubViewBlock)complete;

/// Clear diagram elements on all pages of a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Clear diagram elements on all pages of a whiteboard.
///
/// Business scenario: Perform whiteboard-related operations.
///
/// Related APIs: clearCurrentPage
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback。如果有删除图元的权限，则会返回成功，否则失败
- (void)clearAllPage:(ZegoSuperBoardSubViewBlock)complete;

/// Set the operation mode of the current whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Set the operation mode of the current whiteboard. For example, disable gesture operations on the whiteboard from clients. You can use the bitwise OR method to set multiple modes simultaneously. For example, you can set ZegoWhiteboardOperationModeZoom | ZegoWhiteboardOperationModeDraw to support both the zooming and drawing modes.
///
/// Business scenario: When setting toolType, you need to call this method to handle the whiteboard. To disable gesture operations on the whiteboard from clients, use this method to set the operation mode to None. To scroll files, set the operation mode to the scrolling mode. To use other whiteboard tools, set the operation mode to the drawing mode.
///
/// Default value: drawing/zooming mode
///
/// Impact scope: When the scrolling mode is set, gestures are identified as scrolling. When the drawing mode is set, gestures are identified as drawing-related operations.
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param mode Operation mode
- (void)setOperationMode:(ZegoSuperBoardOperationMode)mode;

/// Redirect to the specified page.
///
/// Supported version: 2.0.0 and above
///
/// Description: Redirect to the specified page.
///
/// Business scenario: Specify a page to redirect.
///
/// Note: For animated PPT or H5 files, images and animations may need to be downloaded during page turning. Frequent calls may cause a long period of time to turn pages.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Related APIs: flipToPrePage and flipToNextPage
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param targetPage Page number of the target page, which starts from 1.
/// @param complete Operation result callback
- (void)flipToPage:(NSInteger)targetPage complete:(ZegoSuperBoardSubViewBlock)complete;

/// Redirect to the previous page.
///
/// Supported version: 2.0.0 and above
///
/// Description: Redirect to the previous page.
///
/// Note: For animated PPT or H5 files, images and animations may need to be downloaded during page turning. Frequent calls may cause a long period of time to turn pages.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Related APIs: flipToPage and flipToNextPage
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback
- (void)flipToPrePage:(ZegoSuperBoardSubViewBlock)complete;

/// Redirect to the next page.
///
/// Supported version: 2.0.0 and above
///
/// Description: Redirect to the next page.
///
/// Note: For animated PPT or H5 files, images and animations may need to be downloaded during page turning. Frequent calls may cause a long period of time to turn pages.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Related APIs: flipToPage and flipToPrePage
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback
- (void)flipToNextPage:(ZegoSuperBoardSubViewBlock)complete;

/// Redirect to the previous animation step.
///
/// Supported version: 2.0.0 and above
///
/// Description: Redirect to the previous animation step.
///
/// Note: This API takes effect only on animated PPT and H5 files. For other types of files, it has no effect.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Related APIs: nextStep
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback
- (void)preStep:(ZegoSuperBoardSubViewBlock)complete;

/// Redirect to the next animation step.
///
/// Supported version: 2.0.0 and above
///
/// Description: Redirect to the next animation step.
///
/// Note: This API takes effect only on animated PPT and H5 files. For other types of files, it has no effect.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Related APIs: preStep
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param complete Operation result callback
- (void)nextStep:(ZegoSuperBoardSubViewBlock)complete;

/// Switch to the specified sheet in an Excel file.
///
/// Supported version: 2.0.0 and above
///
/// Description: Switch to the specified sheet in an Excel file.
///
/// Default value: When an Excel file is opened, the first sheet is displayed by default.
///
/// Related callbacks: ZegoSuperBoardSubViewSwitchBlock
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param sheetIndex Index of the target sheet in the Excel file
/// @param complete Operation result callback
- (void)switchExcelSheet:(NSInteger)sheetIndex complete:(ZegoSuperBoardSubViewSwitchBlock)complete;

/// Insert images into a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Insert images into a whiteboard. You can directly insert images into a whiteboard to display or set custom graphs.
///
/// Business scenario: After a custom graph is set and you select Custom graph as the whiteboard tool, you can draw the set custom graph on the whiteboard by dragging and dropping.
///
/// Note: Supported image formats are PNG, JPG, and JPEG. When type is set to Graphic, local and network images are supported. The image size must be less than 10 MB. When type is set to Custom, only network images are supported, and the image size must be less than 500 KB.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param type Image type. Common images and custom graphs are supported.
/// @param address Image URL. Local and network image URLs are supported. Local images are uploaded to the CDN first. Custom graphs support network image URLs only. (Only network image URLs in the HTTPS format are supported.) Sample URLs: "xxxxxxxxxx.png" and "https://xxxxxxxx.com/xxx.png".
/// @param positionX Horizontal offset of the start point of the image insertion position to the top left corner of the viewport, for example, 10. viewport indicates the writable area. Enter 0 for custom graphs.
/// @param positionY Vertical offset of the start point of the image insertion position to the top left corner of the viewport, for example, 10. viewport indicates the writable area. Enter 0 for custom graphs.
/// @param complete Callback of the image addition result
- (void)addImage:(ZegoSuperBoardViewImageType)type  address:(NSString *)address positionX:(int)positionX positionY:(int)positionY complete:(ZegoSuperBoardSubViewBlock)complete;

/// Set a background image for a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Set a background image for a whiteboard. The background image can be from a local or network path. The background image setting will be synchronized with other users in the room.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Calling time: Call this API after the SuperBoardSubView list is obtained.
///
/// @param imagePath Path of the background image, which can be a local or network path, for example, "xxxxxxxxxx.png" and "https://xxxxxxxx.com/xxx.png". (Network images support only HTTPS).
/// @param mode Padding mode of the background image
/// @param complete Callback after the background image is set
- (void)setBackgroundImageWithPath:(NSString *)imagePath mode:(ZegoSuperBoardViewImageFitMode)mode complete:(ZegoSuperBoardSubViewBlock)complete;

/// Clear the background image of a whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: Clear the background image of a whiteboard. This action will be synchronized with other users in the room.
///
/// Related callbacks: ZegoSuperBoardSubViewBlock
///
/// Calling time: Call this API after the SuperBoardSubView list is obtained.
///
/// @param complete Callback after the background image is cleared
- (void)clearBackgroundImageWithComplete:(ZegoSuperBoardSubViewBlock)complete;

/// Stop the video playing on the current page of an animated PPT file.
///
/// Supported version: 2.0.0 and above
///
/// Description: Stop the video playing on the current page of an animated PPT file. In normal cases, this API is used to stop the audio or video playing in an animated PPT file during file switching.
///
/// Calling time: Call this API after the file is loaded and the audio or video is playing.
- (void)stopPlayPPTVideo;

/// Set the background color for a whiteboard in the container.
///
/// Supported version: 2.0.0 and above
///
/// Description: Set the background color for a whiteboard. For example, set gray for a pure whiteboard. For a file whiteboard, the set background color will be overwritten by the file content. Therefore, the setting does not take effect. The background color takes effect only on the local client and will not be synchronized with other users.
///
/// Calling time: Call this API after the SuperBoardSubView object is obtained.
///
/// @param color Whiteboard color
- (void)setWhiteboardBackgroundColor:(UIColor *)color;


/// Reset the current zooming coefficient.
///
/// Supported version: 2.1.1 and above
///
/// Description: Reset the zooming coefficient of the current file whiteboard to 1.
///
/// Calling time: Call this API after the file is loaded.
- (void)resetScale;


/// Set the cursor style.
///
/// Supported version: 2.2.0 and above
///
/// Description: Set the cursor image and hotspot.
///
/// Calling time: Call this API when currentSuperBoardSubView exists.
///
/// @param type Tool type. Currently, only the pen tool can be set.
/// @param cursorAttribute Cursor parameter
/// @param complete Callback
- (void)setCustomCursorAttribute:(ZegoSuperBoardViewCursorType)type cursorAttribute:(ZegoSuperBoardCursorAttribute *)cursorAttribute complete:(void(^)(int errorCode))complete;

@end

NS_ASSUME_NONNULL_END

