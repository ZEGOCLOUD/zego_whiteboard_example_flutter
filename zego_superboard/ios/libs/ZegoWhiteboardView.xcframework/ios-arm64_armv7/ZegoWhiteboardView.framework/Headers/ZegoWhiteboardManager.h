#import <UIKit/UIKit.h>
#import "ZegoWhiteboardDefine.h"
#import "ZegoWhiteboardViewModel.h"
#import "ZegoWhiteboardView.h"
#import "ZegoWhiteboardConfig.h"

@class ZegoWhiteboardContentView;

NS_ASSUME_NONNULL_BEGIN

/// Whiteboard interaction error callback.
///
/// @param errorCode Error code
typedef void(^ZegoWhiteboardBlock)(ZegoWhiteboardViewError errorCode);

/// Callback for whiteboard creation.
///
/// When errorCode is 0, the creation is successful. In addition, you can obtain the whiteboard view in the callback.
///
/// @param errorCode Error code
/// @param whiteboardView Whiteboard view
typedef void(^ZegoCreateWhiteboardBlock)(ZegoWhiteboardViewError errorCode, ZegoWhiteboardView *whiteboardView);

/// Callback for destroying the whiteboard.
///
/// When errorCode is 0, the whiteboard is destroyed.
///
/// @param errorCode Error code
/// @param whiteboardID ID of the destroyed whiteboard
typedef void(^ZegoDestroyWhiteboardBlock)(ZegoWhiteboardViewError errorCode, ZegoWhiteboardID whiteboardID);

/// Callback for obtaining the whiteboard list.
///
/// When errorCode is 0, the whiteboard list is obtained.
///
/// @param errorCode Error code
/// @param whiteboardViewList Whiteboard
typedef void(^ZegoGetWhiteboardListBlock)(ZegoWhiteboardViewError errorCode, NSArray *whiteboardViewList);

/// Switch whiteboard
///
/// @param errorCode Error code
/// @param whiteboardID WhiteboardID
/// @param zOrder zOrder
typedef void(^ZegoWhiteboardSwitchBlock)(ZegoWhiteboardViewError errorCode, ZegoWhiteboardID whiteboardID,long zOrder);

/// Callback notification generated when a remote client performs whiteboard operations.
///
@protocol ZegoWhiteboardManagerDelegate <NSObject>

/// Notification when a whiteboard is added.
///
/// When a user receives this notification, the user can display the ZegoWhiteboardView in the view.
///
/// Notification time: The local client will receive this notification when other members in the room successfully create a whiteboard by calling the [createWhiteboardView] API.
///
/// @param whiteboardView Newly added ZegoWhiteboardView
- (void)onWhiteboardAdd:(ZegoWhiteboardView *)whiteboardView;

/// Notification when a whiteboard is deleted.
///
/// When a user receives this notification, the user needs to delete the ZegoWhiteboardView of the corresponding whiteboard ID from the view.
///
/// Notification time: The local client will receive this notification when other members in the room successfully destroy the whiteboard by calling the [destroyWhiteboardID] API.
///
/// @param whiteboardID ID of the deleted whiteboard
- (void)onWhiteboardRemoved:(ZegoWhiteboardID)whiteboardID;

/// Receive the callback of animation execution on the remote client.
///
/// Notification generated when an animation of a file (such as an animated PPT file) is played on the remote client. The local client needs to call the playAnimation method of ZegoDocsView to play the animation on the local client synchronously.
///
/// @param animationInfo H5 information related to animation execution. When an animation is played on the local client, this parameter needs to be transferred to the ZegoDocsView SDK to enable the embedded webview to play the animation synchronously.
- (void)onPlayAnimation:(NSString *)animationInfo;

/// Error callback.
///
/// Callback notification generated when a whiteboard internal error occurs. You can identify the error type based on the error code and process the corresponding logic.
///
/// @param error Error codes. You can view the error codes in ZegoWhiteboardDefine.h.
/// @param whiteboardView Whiteboard object for which an error occurs
- (void)onError:(ZegoWhiteboardViewError)error whiteboardView:(ZegoWhiteboardView *)whiteboardView;

/// Callback for whiteboard operation permission change.
///
/// This callback is used to set permissions for controlling whiteboard operations, such as zooming and scrolling.
///
/// @param authInfo authInfo includes the scale and scroll keys. The valid key values are 0 and 1. 0 indicates that the corresponding permission is disabled, and 1 indicates that the corresponding permission is enabled.
- (void)onWhiteboardAuthChanged:(NSDictionary *)authInfo;

/// Callback of diagram element operation permission change.
///
/// Operation permissions of diagram elements include diagram element creation, deletion, movement, update, and clearing.
///
/// @param authInfo authInfo includes the create, delete, move, update, and clear keys. The valid key values are 0 and 1. 0 indicates that the corresponding permission is disabled, and 1 indicates that the corresponding permission is enabled.
- (void)onWhiteboardGraphicAuthChanged:(NSDictionary *)authInfo;


/// Callback after whiteboard switching.
/// @param whiteboardID ID of the switched whiteboard
/// @param zorder Whiteboard server timestamp
- (void)onWhiteboardSwitched:(ZegoWhiteboardID)whiteboardID zorder:(unsigned long long)zorder;

/// Callback for the room status change of the whiteboard.
/// @param roomId Room ID
/// @param roomStatu Room status. (RoomOffline = 0, RoomOnline = 1, RoomTempBroken = 2)
- (void)onWhiteboardRoomStatusChanged:(NSString *)roomId roomStatu:(int)roomStatu;

@end

/// Whiteboard SDK management class
///
/// Create, delete, and obtain whiteboards.
///
@interface ZegoWhiteboardManager : NSObject

/// Tool (teaching tool) that operates the whiteboard view.
/// Tools include the pen, text, straight line, and laser pen. You can set this attribute to change the tool type.
@property (nonatomic, assign, readwrite) ZegoWhiteboardTool toolType;

/// Pen color.
@property (nonatomic, strong, readwrite) UIColor *brushColor;

/// Pen size.
@property (nonatomic, assign, readwrite) NSUInteger brushSize;

/// Text font size.
@property (nonatomic, assign, readwrite) NSUInteger fontSize;

/// Indicates whether the bold font is set.
@property (nonatomic, assign, readwrite) BOOL isFontBold;

/// Indicates whether the italic font is set.
@property (nonatomic, assign, readwrite) BOOL isFontItalic;

/// Indicates whether to synchronize the zooming operation to other members in the room.
@property (nonatomic, assign, readwrite) BOOL enableSyncScale;

/// Indicates whether to respond to the zooming operation performed by other members in the room.
@property (nonatomic, assign, readwrite) BOOL enableResponseScale;

/// Indicates whether to enable the handwriting mode.
@property (nonatomic, assign, readwrite) BOOL enableHandwriting;


/// Whiteboard agent, which will receive a callback when an error occurs or a whiteboard is added or deleted.
@property (nonatomic, weak, readwrite) id<ZegoWhiteboardManagerDelegate> delegate;

/// You can customize the default text of the custom text tool. The default value is @ "text".
@property (nonatomic, copy, readwrite) NSString *customText;

// Indicates whether to enable custom cursor. The default value is YES.
@property (nonatomic, assign, readwrite) BOOL enableCustomCursor;

// Indicates whether to enable the local custom cursor. The default value is YES.
@property (nonatomic, assign, readwrite) BOOL enableRemoteCursorVisible;

// Set the maximum zoom factor of the whiteboard, which is 3 times by default. The range that can be set is [1,10]
@property (nonatomic, assign, readwrite) CGFloat whiteboardMaxScaleFactor;

/// Clear the entire cache directory.
///
/// Call this method when caches need to be cleared. Loaded files can be cleared.
- (void)clearCacheFolder;

/// Create ZegoWhiteboardView.
///
/// You can call this API to create a whiteboard. After the whiteboard is created, add it to the view.
///
/// Calling time: Call this API after the ZegoWhiteboardView SDK is initialized and [loginRoom] of the ZegoExpressEngine SDK is called to log in to the room.
///
/// After the creation is successful, other users will receive a notification in the [onWhiteboardAdd] callback.
///
/// @param whiteboardModel Configuration item for creating the ZegoWhiteboardView. The SDK creates the ZegoWhiteboardView based on this configuration item.
/// @param completeBlock Callback of the ZegoWhiteboardView creation result
///                      If the creation is successful, error code 0 and the ZegoWhiteboardView are returned.
///                      If the creation fails, a non-zero error code is returned. For more information, see Common Error Codes.
- (void)createWhiteboardView:(ZegoWhiteboardViewModel *)whiteboardModel completeBlock:(ZegoCreateWhiteboardBlock)completeBlock;

/// Obtain the SDK version number.
///
/// Calling time: Call this API when the SDK version number needs to be obtained after the SDK is initialized.
///
/// @return Return the current SDK version number.
- (NSString *)getVersion;

/// Destroy the specified ZegoWhiteboardView.
///
/// You can call this API to destroy ZegoWhiteboardView objects created by yourself or others. After a ZegoWhiteboardView object is destroyed, the corresponding view can be deleted.
///
/// Calling time: Call this API after the ZegoWhiteboardView SDK is initialized and [loginRoom] of the ZegoExpressEngine SDK is called to log in to the room.
///
/// If ZegoWhiteboardView of the corresponding whiteboard ID does not exist on the ZEGOCLOUD server, no callback will be returned.
///
/// After the ZegoWhiteboardView is destroyed, other users will receive a notification in the [onWhiteboardRemoved] callback.
///
/// @param whiteboardID ID of the whiteboard to be destroyed
/// @param completeBlock Callback of the whiteboard destroying result
///                      If the whiteboard is destroyed, error code 0 and the whiteboard ID of the destroyed whiteboard are returned.
///                      If the whiteboard fails to be destroyed, a non-zero error code and the whiteboard ID of the destroyed whiteboard are returned.
- (void)destroyWhiteboardID:(ZegoWhiteboardID)whiteboardID completeBlock:(ZegoDestroyWhiteboardBlock)completeBlock;

/// Obtain the ZegoWhiteboardView list.
///
/// When you log in to a room, you can call this API to obtain the list of ZegoWhiteboardView objects created in the room. You can add ZegoWhiteboardView objects to a whiteboard view or save them for later use.
///
/// Calling time: Call this API after the ZegoWhiteboardView SDK is initialized and [loginRoom] is called to log in to the room.
///
/// @param completeBlock Callback of the ZegoWhiteboardView list obtaining result
///                      If the obtaining is successful, error code 0 and the ZegoWhiteboardView array are returned.
///                      If the obtaining fails, a non-zero error code is returned. 
- (void)getWhiteboardListWithCompleteBlock:(ZegoGetWhiteboardListBlock)completeBlock;

/// Clear resources before leaving a room.
///
/// Calling time: After the SDK is initialized and you have logged in to a room, you can proactively call this API to clear resources in the room before leaving the room.
- (void)clear;

/// Initialize the ZegoWhiteboardView SDK.
///
/// Calling time: You need to call this API before calling other APIs of the SDK. In addition, other features can be used only after the callback is successful.
///
/// You must call this API before calling the [loginRoom] API of the ZegoExpressEngine SDK. Otherwise, an error of 112000002 will be returned.
///
/// @param completeBlock Callback of the whiteboard initialization result. If the returned error code is 0, initialization is successful.
- (void)initWithCompleteBlock:(ZegoWhiteboardBlock)completeBlock;

/// De-initialize the SDK.
///
/// Calling time: Call this API after the SDK is initialized.
- (void)uninit;

/// Set whiteboard configuration information.
///
/// Calling time: Call this API before the init() method.
///
/// @param config Configuration information
- (void)setConfig:(ZegoWhiteboardConfig *)config;

/// Customize new fonts.
///
/// Calling time: Call this API after a whiteboard is created.
///
/// Note: Only specific fonts are supported. In addition, you need to embed the font file provided by ZEGOCLOUD into the project. Contact ZEGOCLOUD technical support to obtain the font file and the corresponding font name.
///
/// @param regularFontName Font name of the common font. Contact ZEGOCLOUD technical support to obtain the font name.
/// @param boldFontName Font name of the bold font. Contact ZEGOCLOUD technical support to obtain the font name.
- (void)setCustomFontWithName:(NSString *)regularFontName boldFontName:(NSString *)boldFontName;

/// Management class singleton object
///
/// @return Management class singleton object.
+ (ZegoWhiteboardManager *)sharedInstance;


/// Switch to the specified ZegoWhiteboardView.
/// @param whiteBoardID ID of the whiteboard to be switched to
/// @param completeBlock Callback of the whiteboard switching result
-(void)switchWhiteboardView:(ZegoWhiteboardID)whiteBoardID completeBlock:(ZegoWhiteboardSwitchBlock)completeBlock;


@end

NS_ASSUME_NONNULL_END

