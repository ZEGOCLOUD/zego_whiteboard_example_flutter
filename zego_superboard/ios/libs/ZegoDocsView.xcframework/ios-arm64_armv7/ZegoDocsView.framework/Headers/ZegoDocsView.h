#import <UIKit/UIKit.h>
#import "ZegoDocsViewConstants.h"
#import "ZegoDocsViewManager.h"
#import "ZegoDocsViewConfig.h"
#import "ZegoDocsViewPage.h"

NS_ASSUME_NONNULL_BEGIN

/// Callback of the loadFile method.
///
/// @param errorCode Callback error code. 0 indicates successful execution. For more information, see ZegoDocsViewError.
typedef void(^ZegoDocsViewLoadFileBlock)(ZegoDocsViewError errorCode);

/// Callback of the position redirection event in the view.
///
/// @param isScrollSuccess Indicates whether the redirection is successful. When the page number or offset percentage introduced by the API method exceeds the range, false is returned.
typedef void(^ZegoDocsViewScrollCompleteBlock)(BOOL isScrollSuccess);

@protocol ZegoDocsViewDelegate <NSObject>

/// @param isScrollFinish Indicates whether scrolling is stopped.
- (void)onScroll:(BOOL)isScrollFinish;

/// Notification for step change.
- (void)onStepChange;

/// Notification for file display exceptions, such as network timeout.
///
/// @param errorCode Error code
- (void)onError:(ZegoDocsViewError)errorCode;

/// Callback generated when users tap animations in an animated PPT file with fingers. It takes effect only on animated PPT files.
///
/// Notification time: A user proactively taps an animation in an animated PPT file.
///
/// This notification is valid only for animated PPT files with the animation effect (ZegoDocsViewRenderTypeDynamicPPTH5).
///
/// When a user calls the API to play an animation, this notification is not triggered.
///
/// If you want to synchronize file animation playing at clients A and B, implement it as follows:
/// When the user at client A taps an animation in an animated PPT file with fingers, the user at client B will receive this notification. Client A sends [animationInfo] to client B through the Express SDK or other communication channels.
/// When the user at client B receives [animationInfo], the user calls [playAnimation] to introduce [animationInfo]. In this case, the file animation at client B is synchronized with that at client A.
///
/// @param animationInfo Played animation information (with the element ID)
- (void)onPlayAnimation:(NSString *)animationInfo;

/// Step change notification triggered when a user proactively taps an animation in an animated PPT file.
///
/// Notification time: A user proactively taps an animation in an animated PPT file to change the step.
///
/// This notification is valid only for animated PPT files with steps (ZegoDocsViewRenderTypeDynamicPPTH5).
///
/// When you call [nextStep], [previousStep], [flipPage], or other APIs to change the step of an animated PPT file, you will receive the [onStepChange] notification.
- (void)onStepChangeForClick;

@end

/// ZegoDocsView
///
@interface ZegoDocsView : UIView

/// Obtain the file ID corresponding to the current view, which is the same as the file ID introduced through loadFile.
@property (nonatomic, copy, readonly) NSString *fileID;

/// Obtain the type of the currently loaded file. For more information about supported file types, see ZegoDocsViewConstants.
@property (nonatomic, assign, readonly) ZegoDocsViewFileType fileType;

/// Obtain the page number of the intermediate position on the current screen, which starts from 1.
@property (nonatomic, assign, readonly) NSInteger currentPage;

/// Obtain the name of the current file.
@property (nonatomic, copy, readonly) NSString *fileName;

/// Obtain the animation step on the current page of the animated PPT file, which starts from 1.
@property (nonatomic, assign, readonly) NSInteger currentStep;

/// Obtain the total number of pages.
@property (nonatomic, assign, readonly) NSInteger pageCount;

/// Obtain the vertical offset percentage. The value range is from 0.00 to 1.00.
@property (nonatomic, assign, readonly) CGFloat verticalPercent;

/// Obtain the width and height of the current file.
@property (nonatomic, assign, readonly) CGSize visibleSize;

/// Obtain the width and height of the file content. The total height is obtained based on the set display width.
@property (nonatomic, assign, readonly) CGSize contentSize;

/// Obtain the list of sheets in an Excel file.
@property (nonatomic, copy, readonly) NSArray <NSString *> *sheetNameList;

/// ID of the associated whiteboard.
@property (nonatomic, assign, readwrite) long associatedWhiteboardID;

/// Estimated width and height of a view.
@property (nonatomic, assign, readwrite) CGSize estimatedSize;

/// Agent
@property (nonatomic, weak, readwrite) id <ZegoDocsViewDelegate> delegate;

/// Redirect to the specified page of a file.
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
///
/// Note: When this method is called frequently, the next method is executed only when the previous method is completed (serial execution).
///
/// @param page Target page redirected to, which starts from 1. The value range is from 1 to the maximum page number. If the page number exceeds this range, the redirection fails.
/// @param completionBlock Redirection completion callback, which can be null.
- (void)flipPage:(NSInteger)page completionBlock:(nullable ZegoDocsViewScrollCompleteBlock)completionBlock;

/// Redirect to the specified page of a file.和指定步骤(step)
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
///
/// This method is valid only for animated PPT files with steps (ZegoDocsViewRenderTypeDynamicPPTH5).
///
/// If the redirection is successful, you will receive a callback in completionBlock and a notification in [onStepChange] of ZegoDocsViewDelegate.
///
/// Note: When this method is called frequently, the next method is executed only when the previous method is completed (serial execution).
///
/// @param page Target page redirected to, which starts from 1. The value range is from 1 to the maximum page number. If the page number exceeds this range, the redirection fails.
/// @param page Animation step of the target page redirected to, which starts from 1. The value range is from 1 to the maximum page number. If the page number exceeds this range, the redirection fails.
/// @param completionBlock Callback after page turning is completed, which can be null.
- (void)flipPage:(NSInteger)page step:(NSInteger)step completionBlock:(nullable ZegoDocsViewScrollCompleteBlock)completionBlock;

/// Obtain information of the current file page.
///
/// @return Information on the current file page.
- (ZegoDocsViewPage *)getCurrentPageInfo;

/// Obtain the thumbnail list of the current file. Only PDF, PPT, and animated PPT files are supported.
/// Calling time: Call this API after loadFile is successful.
///
/// @return File thumbnail URL list. (NSArray<NSString *> *)
- (NSArray *)getThumbnailUrlList;

/// Load and display the file.
///
/// Prerequisites: The width and height of ZegoDocsView need to be greater than 0. Before loading a file, set the size of ZegoDocsView.
/// After a file is loaded, related ZegoDocsView attributes, such as content size, are updated automatically based on the file content.
/// You can call APIs for operating the file content, such as [flipPage], [scrollTo], and [playAnimation], only after the file is loaded successfully.
/// If you do not need to display a file after it is loaded, call [unloadFile] to unload the file from the view.
///
/// @param fileID Unique ID of the target file, which is obtained after format conversion. The business server needs to associate the file ID with a certain business, for example, a class, person, or role.
/// @param authKey File sharing authentication key generated by the algorithm negotiated by the business server and ZegoDocs service.
///                If the authentication feature is disabled, authKey can be null. If the authentication feature is enabled, loadFile fails when authentication fails.
/// @param completionBlock Callback of whether the file is loaded successfully
- (void)loadFileWithFileID:(NSString *)fileID authKey:(NSString *)authKey completionBlock:(ZegoDocsViewLoadFileBlock)completionBlock;

/// Redirect to the next animation step of an animated PPT file.
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
///
/// This method is valid only for animated PPT files with steps (ZegoDocsViewRenderTypeDynamicPPTH5).
///
/// If the current step is the last step on the current page, call this API will redirect to the next page.
///
/// If the redirection is successful, you will receive a callback in completionBlock and a notification in [onStepChange] of ZegoDocsViewDelegate.。
///
/// Note: When this method is called frequently, the next method is executed only when the previous method is completed (serial execution).
///
/// @param completionBlock Redirection completion callback, which can be null.
- (void)nextStepWithCompletionBlock:(nullable ZegoDocsViewScrollCompleteBlock)completionBlock;

/// Play the animation step in an animated PPT file based on [animationInfo]. It is valid only for animated PPT files with animation effects.
///
/// If you want to synchronize file animation playing at clients A and B, implement it as follows:
/// When the user at client A taps an animation in an animated PPT file with fingers, the user at client B will receive the [onPlayAnimation] notification. Client A sends received [animationInfo] to client B through the Express SDK or other communication channels.
/// When the user at client B receives [animationInfo], the user calls this API to introduce [animationInfo]. In this case, the file animation at client B is synchronized with that at client A.
///
/// This notification is valid only for animated PPT files with the animation effect (ZegoDocsViewRenderTypeDynamicPPTH5).。
///
/// @param animationInfo Detailed animation information This call is invalid if the animation corresponding to [animationInfo] does not exist in the file.
- (void)playAnimation:(NSString *)animationInfo;

/// Obtain notes on the specified page of a PPT file.
///
/// Calling time: Call this API after loadFile is successful.
///
/// @param page Specified page number, which starts from 1.
///
/// @return Notes on the page. If no notes are available, null is returned.
- (NSString *)pptNotesOfPage:(NSInteger)page;

/// Redirect to the previous animation step of an animated PPT file.
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
///
/// This method is valid only for animated PPT files with steps (ZegoDocsViewRenderTypeDynamicPPTH5).
///
/// If the current step is the first step on the current page, calling this API will redirect to the previous page. If the current step is the first step on the first page, this API is invalid.
///
/// If the redirection is successful, you will receive a callback in completionBlock and a notification in [onStepChange] of ZegoDocsViewDelegate.。
///
/// Note: When this method is called frequently, the next method is executed only when the previous method is completed (serial execution).
///
/// @param completionBlock Redirection completion callback, which can be null.
- (void)previousStepWithCompletionBlock:(nullable ZegoDocsViewScrollCompleteBlock)completionBlock;

/// Re-load a file. This method is called during switching between the horizontal and vertical screen modes.
///
/// Calling time: Call this API after loadFile is successful.
/// Note: Call this method after the width or height of DocsView is modified.
///
/// @param completionBlock Callback of whether the file is loaded successfully.
- (void)reloadFileWithCompletionBlock:(nullable ZegoDocsViewLoadFileBlock)completionBlock;

/// Synchronization operation, including the zooming, offset, and scrolling scopes. Business scenario: Synchronize with whiteboard operations.
///
/// Calling time: Call this API after loadFile is successful.
/// Note: To synchronize the whiteboard zooming operation with the view, call this API when the whiteboard is zoomed in or out to ensure synchronous zooming operation of DocView. For more information, see the demo (contact technical support).
///
/// @param scaleFactor Zooming ratio
/// @param scaleOffsetX Zooming offset along the X-axis
/// @param scaleOffsetY Zooming offset along the Y-axis
- (void)scaleDocsViewWithScaleFactor:(CGFloat)scaleFactor scaleOffsetX:(CGFloat)scaleOffsetX scaleOffsetY:(CGFloat)scaleOffsetY;

/// Redirect to the specified offset position (vertical offset) of a file.
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
///
/// @param verticalPercent Vertical offset percentage. The value range is from 0.00 to 1.00. For example, to redirect to the intermediate position of a file, set this parameter to 0.50.
/// @param completionBlock Redirection completion callback, which can be null.
- (void)scrollTo:(CGFloat)verticalPercent completionBlock:(nullable ZegoDocsViewScrollCompleteBlock)completionBlock;

/// Set whether manual scrolling is allowed.
///
/// @param enable true: Manual scrolling is allowed; false: Manual scrolling is not allowed.
- (void)setManualScrollEnable:(BOOL)enable;

/// Set the operation permission of ZegoDocsView.
///
/// This API needs to be used together with the [onWhiteboardAuthChange:] callback method of the ZegoWhiteboardView SDK. When the [onWhiteboardAuthChange:] callback method is received, call this method to ensure that the permission of ZegoDocsView is consistent with that of ZegoWhiteboardView.
///
/// @param authInfo Permission setting information Introduce the dictionary of the [onWhiteboardAuthChange:] parameter in the ZegoWhiteboardView SDK.
- (void)setOperationAuth:(NSDictionary *)authInfo;

/// Set whether to support zooming.
///
/// For example, after the whiteboard is zoomed in and this method is called with the parameter set to false, the whiteboard can no longer be zoomed in or out. If the parameter is set to true again, you can continue to zoom in or out of the whiteboard.
///
/// @param enable Zooming is supported
- (void)setScaleEnable:(BOOL)enable;

/// Stop audio or video playing on a page of an animated PPT file on the local client.
///
/// In normal cases, this API is used to stop the audio or video playing in an animated PPT file during file switching.
///
/// @param pageNumber When this parameter is set to 0, the audio or video playing on the current page is stopped. Otherwise, the audio or video playing on the specified page is stopped.
- (void)stopPlay:(NSInteger)pageNumber;

/// Switch to a specific sheet in an Excel file.
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
///
/// This method is valid only for Excel files.
///
/// @param sheetIndex Subscript of a sheet, which starts from 0.
- (void)switchSheet:(int)sheetIndex;

/// Unload a file from a view.
///
/// Prerequisites: Call this API after the file is loaded by calling [loadFile].
/// When you have called [loadFile] to load a file to the current DocsView and you want to load another file, we recommend that you call this API to unload the file first.
/// If you do not call this API to release the file handle, the corresponding file cache cannot be cleared when you call [clearCacheFolder] to clear the cache.
- (void)unloadFile;

@end

NS_ASSUME_NONNULL_END

