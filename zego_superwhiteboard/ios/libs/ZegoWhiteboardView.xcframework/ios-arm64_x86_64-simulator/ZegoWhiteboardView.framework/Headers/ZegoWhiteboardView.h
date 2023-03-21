#import <Foundation/Foundation.h>
#import "ZegoWhiteboardDefine.h"
#import "ZegoWhiteboardViewModel.h"
#import "ZegoWhiteboardCursorAttribute.h"

@class ZegoWhiteboardView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZegoWhiteboardScrollBlock)(ZegoWhiteboardViewError errorCode, float horizontalPercent, float verticalPercent, unsigned int pptStep);

/// ZegoWhiteboardView whiteboard synchronization callback protocol
///
@protocol ZegoWhiteboardViewDelegate <NSObject>

/// Implement this method to respond to whiteboard zooming operations.
///
/// After the whiteboard is zoomed in or out, this callback method is called to notify the service layer. Other clients can respond to whiteboard zooming operations based on the method parameters. For example, synchronize the zooming operation of a file on different clients.
///
/// @param scaleFactor Zooming coefficient
/// @param scaleOffsetX Horizontal offset generated during zooming
/// @param scaleOffsetY Vertical offset generated during zooming
/// @param whiteboardView Whiteboard object that is zoomed in or out
- (void)onScaleChangedWithScaleFactor:(CGFloat)scaleFactor scaleOffsetX:(CGFloat)scaleOffsetX scaleOffsetY:(CGFloat)scaleOffsetY whiteboardView:(ZegoWhiteboardView *)whiteboardView;

/// Implement this method to respond to whiteboard scrolling.
///
/// After the whiteboard is scrolled, this callback method is called to notify the SDK users. Other clients can respond to whiteboard scrolling based on the method parameters. For example, synchronize the scrolling effect of a file on different clients.
///
/// @param horizontalPercent Horizontal scrolling percentage of the whiteboard
/// @param verticalPercent Vertical scrolling percentage of the whiteboard
/// @param whiteboardView Whiteboard object that is scrolled
- (void)onScrollWithHorizontalPercent:(CGFloat)horizontalPercent verticalPercent:(CGFloat)verticalPercent whiteboardView:(ZegoWhiteboardView *)whiteboardView;

@end

/// Whiteboard view.
///
@interface ZegoWhiteboardView : UIView

/// Zooming factor.
@property (nonatomic, assign, readonly) CGFloat scaleFactor;

/// Horizontal offset generated by scrolling of the content displayed in the view that is zoomed in or out.
@property (nonatomic, assign, readonly) CGFloat scaleOffsetX;

/// Vertical offset generated by scrolling of the content displayed in the view that is zoomed in or out.
@property (nonatomic, assign, readonly) CGFloat scaleOffsetY;

/// Start point of the display area of the view.
@property (nonatomic, assign, readonly) CGPoint contentOffset;

/// Actual visible area of the view.
@property (nonatomic, assign) CGSize contentSize;

/// Whiteboard view. 对应的 viewModel
@property (nonatomic, strong, readonly) ZegoWhiteboardViewModel *whiteboardModel;

/// ZegoWhiteboardView callback.
@property (nonatomic, weak) id<ZegoWhiteboardViewDelegate> whiteboardViewDelegate;

/// Add images to the whiteboard.
///
/// Note:
/// 1. Supported image types are PNG, JPG, and JPEG.
/// 2. When type is ZegoWhiteboardViewImageGraphic, local and network images are supported and the image size must be less than 10 MB.
/// 3. When type is ZegoWhiteboardViewImageCustom, only network images are supported and the image size must be less than 500 KB.
///
/// @param type Image type. Common images and custom graphs are supported.
/// @param positionX Horizontal offset of the start point of the image insertion position to the top left corner of the viewport, for example, 10. viewport indicates the writable area. Enter 0 for custom graphs.
/// @param positionY Vertical offset of the start point of the image insertion position to the top left corner of the viewport, for example, 10. viewport indicates the writable area. Enter 0 for custom graphs.
/// @param address Image URL. Local and network image URLs are supported. Local images are uploaded to the CDN first. Custom graphs support network image URLs only. (Only network image URLs in the HTTPS format are supported.) Sample URLs: "xxxxxxxxxx.png" and "https://xxxxxxxx.com/xxx.png".
/// @param complete Callback of the image addition result. For more information about the error codes, see ZegoWhiteboardViewError.
- (void)addImage:(ZegoWhiteboardViewImageType)type positionX:(int)positionX positionY:(int)positionY address:(NSString *)address complete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Add text to a whiteboard view.
///
/// @param complete Operation result callback
- (void)addTextEditWithComplete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Add custom text to a whiteboard view.
///
/// When text is added to a whiteboard view, a new text diagram element is created. The keyboard input box is not displayed, and the new text diagram element automatically adapts to the zooming coefficient.
///
/// @param text String content of the text diagram element to be added
/// @param positionX Horizontal offset to the top left corner of the viewport, for example, 10. viewport indicates the writable area.
/// @param positionY Vertical offset to the top left corner of the viewport, for example, 10. viewport indicates the writable area.
/// @param complete Operation result callback
- (void)addText:(NSString *)text positionX:(int)positionX positionY:(int)positionY complete:(void(^)(ZegoWhiteboardViewError errorcode))complete;


/// Clear all diagram elements on a whiteboard.
///
/// @param complete Operation result callback
- (void)clearWithComplete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Remove the background image of a whiteboard.
///
/// @param complete Callback after the background image is cleared
- (void)clearBackgroundImageWithComplete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Clear all diagram elements in the specified coordinate range.
///
/// Calling time: Call this API to clear the current page.
/// Note: To clear the current page, the caller calculates the coordinate range of the current whiteboard page in pure whiteboard mode or calls the corresponding API of the ZegoDocsView SDK to obtain the coordinate range of the current page in file whiteboard mode.
///
/// @param rect Specified whiteboard area to be cleared
/// @param complete Operation result callback
- (void)clear:(CGRect)rect complete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Delete selected diagram elements.
///
/// Calling time: This API is provided for users to delete selected diagram elements. For example, if you select multiple diagram elements for toolType and want to delete selected diagram elements when you switch to the eraser tool, call this API.
///
/// @param complete Operation result callback
- (void)deleteSelectedGraphicsWithComplete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Initialize the whiteboard.
///
/// @param whiteboardModel Whiteboard information
///
/// @return Initialized whiteboard object.
- (instancetype)initWithWhiteboardModel:(ZegoWhiteboardViewModel *)whiteboardModel;

/// Synchronize the animation played in an animated PPT file to other clients.
///
/// Calling time: When an animation in an animated PPT file is clicked at the local client, call this method to synchronize it to other members in the room.
/// Note: Only animated PPT files are supported.
///
/// @param animationInfo Information about the animation played in the animated PPT file
- (void)playAnimation:(NSString *)animationInfo;

/// Restore the previous canceled operation.
- (void)redo;

/// Remove the laser pen.
- (void)removeLaser;

/// Scroll the whiteboard to the specified offset position, which is described in percentage.
///
/// Vertical and horizontal scrolling operations are supported. If the ZegoWhiteboardView content occupies more than one page, you can call this API to scroll to different whiteboard areas.
///
/// Calling time: Call this API after ZegoWhiteboardView is created or obtained.
///
/// The scrolling operation will be synchronized with remote clients through the [ZegoExpressEngine] SDK or [ZegoLiveRoom] SDK. ZegoWhiteboardView automatically synchronizes the scrolling area. You do not need to call APIs.
/// If user A calls this API to scroll to the position with horizontalPercent set to 0.1 and verticalPercent set to 0.2, the ZegoWhiteboardView of user B in the same room will be scrolled to the same position. You do not need to call APIs in this process.
///
/// @param horizontalPercent Horizontal scrolling percentage. The value range is from 0 to 1.0. 0 indicates no offset, and 1 indicates the maximum offset.
/// @param verticalPercent Vertical scrolling percentage. The value range is from 0 to 1.0. 0 indicates no offset, and 1 indicates the maximum offset.
/// @param completionBlock Callback after the scrolling operation is completed. You can process the corresponding logic in the callback.
- (void)scrollToHorizontalPercent:(CGFloat)horizontalPercent verticalPercent:(CGFloat)verticalPercent completionBlock:(ZegoWhiteboardScrollBlock)completionBlock;

/// Scroll the whiteboard to the specified offset position, which is described in percentage.
///
/// Vertical and horizontal scrolling operations are supported, which is similar to UIScrollView.
/// Note: The scrolling operation is synchronized with remote clients through the ZegoExpressEngine or ZegoExpressEngine SDK. You can perform custom operations after the callback is completed.
///
/// @param horizontalPercent Horizontal scrolling percentage. The value range is from 0 to 1.0. 0 indicates no offset, and 1 indicates the maximum offset.
/// @param verticalPercent Vertical scrolling percentage. The value range is from 0 to 1.0. 0 indicates no offset, and 1 indicates the maximum offset.
/// @param pptStep Number of steps of an animated PPT file
/// Note: When the whiteboard SDK is used together with the file transcoding SDK, this parameter is used to synchronize the animation steps of animated PPT files.
/// @param completionBlock Scrolling callback
- (void)scrollToHorizontalPercent:(CGFloat)horizontalPercent verticalPercent:(CGFloat)verticalPercent pptStep:(NSInteger)pptStep completionBlock:(ZegoWhiteboardScrollBlock)completionBlock;

/// Set a background image for a whiteboard.
///
/// @param imagePath URL path of the background image, which can be a local or network path, for example, "xxxxxxxxxx.png" and "https://xxxxxxxx.com/xxx.png". (Only network image URLs in the HTTPS format are supported.)
/// @param mode Padding mode of the background image
/// @param complete Callback after the background image is set
- (void)setBackgroundImageWithPath:(NSString *)imagePath mode:(ZegoWhiteboardViewImageFitMode)mode complete:(void(^)(ZegoWhiteboardViewError errorcode))complete;

/// Set the operation mode of the current whiteboard. For more information, see ZegoWhiteboardOperationMode.
///
/// Calling time: Call this API after ZegoWhiteboardView is created or obtained.
///
/// This API cannot be used together with the [enableUserOperation] or [canDraw] API. (The enableUserOperation and canDraw APIs are obsoleted.)
///
/// You can use the bitwise OR method to set multiple modes simultaneously. For example, you can set ZegoWhiteboardOperationModeZoom | ZegoWhiteboardOperationModeDraw to support both the zooming and drawing modes.
///
/// @param operationMode For more information, see ZegoWhiteboardOperationMode.
- (void)setWhiteboardOperationMode:(ZegoWhiteboardOperationMode)operationMode;

/// Undo the previous drawing operation.
- (void)undo;

/// @deprecated use -[ZegoWhiteboardView addTextEditWithComplete:] instead
///
/// Add text to a whiteboard view.
- (void)addTextEdit DEPRECATED_ATTRIBUTE;

/// @deprecated use -[ZegoWhiteboardView addText:positionX:positionY:complete:] instead
///
/// Add custom text to a whiteboard view.
///
/// When text is added to a whiteboard view, a new text diagram element is created. The keyboard input box is not displayed, and the new text diagram element automatically adapts to the zooming coefficient.
///
/// @param text String content of the text diagram element to be added
/// @param positionX Horizontal offset to the top left corner of the viewport, for example, 10. viewport indicates the writable area.
/// @param positionY Vertical offset to the top left corner of the viewport, for example, 10. viewport indicates the writable area.
- (void)addText:(NSString *)text positionX:(int)positionX positionY:(CGFloat)positionY DEPRECATED_ATTRIBUTE;

/// @deprecated use -[ZegoWhiteboardView clearWithComplete:] instead
///
/// Clear all diagram elements on a whiteboard.
- (void)clear DEPRECATED_ATTRIBUTE;

/// @deprecated use -[ZegoWhiteboardView clear:complete:] instead
///
/// Clear all diagram elements in the specified coordinate range.
///
/// Calling time: Call this API to clear the current page.
/// Note: To clear the current page, the caller calculates the coordinate range of the current whiteboard page in pure whiteboard mode or calls the corresponding API of the ZegoDocsView SDK to obtain the coordinate range of the current page in file whiteboard mode.
///
/// @param rect Specified whiteboard area to be cleared
- (void)clear:(CGRect)rect DEPRECATED_ATTRIBUTE;

/// @deprecated use -[ZegoWhiteboardView deleteSelectedGraphicsWithComplete:] instead
///
/// Delete selected diagram elements.
///
/// Calling time: This API is provided for users to delete selected diagram elements. For example, if you select multiple diagram elements for toolType and want to delete selected diagram elements when you switch to the eraser tool, call this API.
- (void)deleteSelectedGraphics DEPRECATED_ATTRIBUTE;


/// Reset the whiteboard zooming coefficient.
- (void)resetScale;


/// Set the cursor style.
///
/// Supported version: 2.2.0 and above
///
/// Description: Set the pointer icon and hotspot (that is, the actual clicking position of the custom icon) of the local custom cursor.
///
/// Calling time: Call this API after the local custom cursor is enabled.
/// Note:
/// Set the hotspot position of the pointer. We recommend that you set the hotspot position with two positive numbers less than 32 without a unit.
///
/// @param type Tool type. Currently, only the pen tool can be set.
/// @param cursorAttribute Cursor parameter
/// @param complete Callback
- (void)setCustomCursorAttribute:(ZegoWhiteboardViewCursorType)type cursorAttribute:(ZegoWhiteboardCursorAttribute *)cursorAttribute complete:(void(^)(ZegoWhiteboardViewError errorcode))complete;


@end

NS_ASSUME_NONNULL_END

//! Project version number for ZegoWhiteboardView.
FOUNDATION_EXPORT double ZegoWhiteboardViewVersionNumber;

//! Project version string for ZegoWhiteboardView.
FOUNDATION_EXPORT const unsigned char ZegoWhiteboardViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZegoWhiteboardView/PublicHeader.h>

#import <ZegoWhiteboardView/ZegoWhiteboardManager.h>
#import <ZegoWhiteboardView/ZegoWhiteboardDefine.h>
#import <ZegoWhiteboardView/ZegoWhiteboardView.h>
#import <ZegoWhiteboardView/ZegoWhiteboardViewModel.h>
