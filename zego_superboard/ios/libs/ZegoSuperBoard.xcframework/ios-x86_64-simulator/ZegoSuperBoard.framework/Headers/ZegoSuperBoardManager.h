//
//  ZegoSuperBoardManager.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <Foundation/Foundation.h>
#import "ZegoCreateWhiteboardConfig.h"
#import "ZegoCreateFileConfig.h"
#import "ZegoSuperBoardSubView.h"
#import "ZegoSuperBoardDefine.h"
#import "ZegoSuperBoardInitConfig.h"
#import "ZegoSuperBoardView.h"

NS_ASSUME_NONNULL_BEGIN

/// Callback for the call results of APIs in ZegoSuperBoardManager.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the call result of APIs in ZegoSuperBoardManager through the block method.
///
/// Business scenario: Determine whether the call of an API in ZegoSuperBoardManager is successful.
///
/// Callback time: Call this callback after an API in ZegoSuperBoardManagerBlock is called and ZegoSuperBoardManagerBlock is not set to nil.
///
/// Related APIs:  [initWithConfig] and [destroySuperBoardSubView]
typedef void(^ZegoSuperBoardManagerBlock)(ZegoSuperBoardError errorCode);

/// Callback of the whiteboard/file creation API.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the creation result after the createWhiteboardView or createFileView method is called.
///
/// Business scenario: Obtain the creation result after a whiteboard or file is created.
///
/// Calling time: Call this callback after the createWhiteboardView or createFileView method is called.
///
/// Related APIs:  [createWhiteboardView] and [createFileView]
typedef void(^ZegoSuperBoardManagerCreateBlock)(ZegoSuperBoardError errorCode, ZegoSuperBoardSubViewModel *model);

/// Callback of some synchronization information and error information of ZegoSuperBoardManager
///
@protocol ZegoSuperBoardManagerDelegate <NSObject>

@optional

/// Callback notification generated when a Super Board internal error occurs. You can identify the error type based on the error code. For more information about the error codes, see ZegoSuperBoardError.
///
/// Supported version: 2.0.0
///
/// Notification time: Receive an error callback when the ZegoSuperBoard SDK is used.
- (void)onError:(ZegoSuperBoardError)error;

/// Receive a callback of SuperBoardSubView addition.
///
/// Supported version: 2.0.0
///
/// Notification time: The local client will receive this notification when other users in the room successfully create a whiteboard or file by calling the [createWhiteboardView] or [createFileView] API.
///
/// @param model Model of the added SuperBoardSubView
- (void)onRemoteSuperBoardSubViewAdded:(ZegoSuperBoardSubViewModel *)model;

/// Receive a callback of SuperBoardSubView destroying.
///
/// Supported version: 2.0.0
///
/// Notification time: The local client will receive this notification when other users in the room successfully destroy the ZegoSuperBoardSubView by calling the [destroyWhiteboardView] API.
///
/// @param model Model of the SuperBoardSubView
- (void)onRemoteSuperBoardSubViewRemoved:(ZegoSuperBoardSubViewModel *)model;

/// Receive a callback of SuperBoardSubView switching.
///
/// Supported version: 2.0.0
///
/// Notification time: The local client will receive this notification when other users in the room successfully switch the ZegoSuperBoardSubView by calling the [switchSubView] API.
///
/// @param uniqueID Unique ID of the SuperBoardSubView switched to
- (void)onRemoteSuperBoardSubViewSwitched:(NSString *)uniqueID;

/// Receive a callback of SuperBoardSubView operation permission change.
///
/// Supported version: 2.0.0
///
/// Description: This operation permission change callback is used to control whiteboard operations, such as zooming and scrolling.
///
/// Notification time: A permission change notification is received from the backend.
///
/// @param authInfo authInfo contains the scale and scroll keys. The key values are 0 and 1. 0 indicates that the corresponding permission is disabled, and 1 indicates that the corresponding permission is enabled.
- (void)onRemoteSuperBoardAuthChanged:(NSDictionary *)authInfo;

/// Callback of diagram element operation permission change.
/// Operation permissions of diagram elements include diagram element creation, deletion, movement, update, and clearing.
///
/// Supported version: 2.0.0
///
/// Description: Diagram element operation permissions include diagram element creation, deletion, movement, update, and clearing.
///
//// Calling time/Notification time: A permission change notification is received from the backend.
///
/// @param authInfo authInfo includes the create, delete, move, update, and clear keys. The key values are 0 and 1. 0 indicates that the corresponding permission is disabled, and 1 indicates that the corresponding permission is enabled.
- (void)onRemoteSuperBoardGraphicAuthChanged:(NSDictionary *)authInfo;

@end

/// This API class is used to initialize the SDK, set global features in a room, and create file or pure whiteboards.
///
/// Description: This API class is used to initialize the SDK, set global features in a room, and create file or pure whiteboards.
///
/// Business scenario: Initialize the SDK, set whiteboard tools, zooming operation synchronization, and pen effect, obtain the boardView when the boardView mode is enabled, and create file or pure whiteboards.
///
/// Platform difference: none
///
@interface ZegoSuperBoardManager : NSObject

/// Tool (teaching tool) that operates the whiteboard view.
/// Tools include the pen, text, straight line, and laser pen. You can set this attribute to change the tool type.
/// Supported version: 2.0.0
///
/// Description: Set different tool types to draw different diagram elements on a whiteboard.
///
/// Calling time: Call this API after the ZegoSuperBoard SDK is initialized.
@property (nonatomic,assign,readwrite) ZegoSuperBoardTool toolType;

/// Description: Set the pen color for new drawings on the whiteboard after the pen tool is selected.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Note: The set pen color takes effect only on new drawings. The color of previously existing drawings on the whiteboard is not changed.
///
/// Supported version: 2.0.0
@property (nonatomic,strong, readwrite) UIColor *brushColor;

/// Pen size.
@property (nonatomic,assign, readwrite) NSUInteger brushSize;

/// Description: Set the font size for new text on the whiteboard after the text tool is selected.
///
/// Valid values: integers greater than 0
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Note: The set font size takes effect only to text added after setFontSize is called. The font size of previously existing text on the whiteboard is not changed.
///
/// Supported version: 2.0.0
@property (nonatomic,assign, readwrite) NSUInteger fontSize;

/// Description: Set isFontBold to YES to bold newly added text on the whiteboard after the text tool is selected.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Note: Only text added after isFontBold is set to YES is bolded. Previously existing text on the whiteboard is not bolded.
///
/// Supported version: 2.0.0
@property (nonatomic,assign, readwrite) BOOL isFontBold;

/// Description: Determine whether to set the italic effect for newly added text on the whiteboard after the text tool is selected.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Supported version: 2.0.0
@property (nonatomic, assign, readwrite) BOOL isFontItalic;

/// Description: Customize the default text for the custom text tool.
///
/// Supported version: 2.0.0
@property (nonatomic, copy, readwrite) NSString *customText;

/// Description: After enableSyncScale is enabled, whiteboard zooming at the local client can be synchronized with the remote client. Whether the whiteboard of the remote client is zoomed in or out with that at the local client depends on whether enableResponseScale is enabled.
///
/// Business scenario: Synchronize whiteboard zooming operations at the local and remote clients.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Note: To ensure zooming operation synchronization at two clients, set enableSyncScale and enableResponseScale simultaneously.
///
/// Related callbacks: When a zooming operation is performed at the local client, the remote client can call remoteSuperBoardScaleChanged to listen for parameter change.
///
/// Supported version: 2.0.0
@property (nonatomic, assign, readwrite) BOOL enableSyncScale;

/// Description: After enableResponseScale is enabled, the local client can respond to zooming operations performed by other users in the room. The prerequisite is that the remote client synchronizes zooming operations to other users in the room.
///
/// Business scenario: Synchronize whiteboard zooming operations at the local and remote clients.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Note: To ensure zooming operation synchronization at two clients, set enableSyncScale and enableResponseScale simultaneously.
///
/// Related callbacks: When a zooming operation is performed at the local client, the remote client can call remoteSuperBoardScaleChanged to listen for parameter change.
///
/// Supported version: 2.0.0
@property (nonatomic, assign, readwrite) BOOL enableResponseScale;

/// Description: Set whether to enable the handwriting effect for drawings on a whiteboard. If it is set to true, the handwriting effect is enabled for drawings on a whiteboard.
///
/// Business scenario: Adjust the pen size and shape based on the drawing speed to enhance the handwriting effect.
///
/// Calling time/Notification time: Call this API after the SDK is initialized.
///
/// Supported version: 2.0.0
@property (nonatomic, assign, readwrite) BOOL enableHandwriting;


/// Description: Set whether to enable custom cursor. If it is set to true, the custom cursor is displayed. The default value is true.
///
/// Business scenario: Display the cursor during drawing.
///
/// Calling time/Notification time: Call this API after the SDK is initialized.
///
/// Supported version: 2.2.0
@property (nonatomic, assign, readwrite) BOOL enableCustomCursor;


/// Description: Set whether to display the remote cursor. If it is set to true, the remote cursor is displayed. The default value is true.
///
/// Business scenario: Display the remote cursor during drawing.
///
/// Calling time/Notification time: Call this API after the SDK is initialized.
///
/// Supported version: 2.2.0
@property (nonatomic, assign, readwrite) BOOL enableRemoteCursorVisible;

/// Set the ZegoSuperBoardManager agent and implement the corresponding agent methods to listen for addition, destroying, and switching of superBoardSubView objects in the SDK and SDK exceptions.
///
/// Business scenario: Update the UI when a superBoardSubView object is added, destroyed, or switched.
///
/// Supported version: 2.0.0
@property (nonatomic, weak) id<ZegoSuperBoardManagerDelegate> delegate;

/// Description: Obtain the ZegoSuperBoardView object when the ZegoSuperBoardView mode is enabled.
///
/// Business scenario: In ZegoSuperBoardView mode, use methods of the ZegoSuperBoardView object to automatically synchronize whiteboard switching on client A to client B.
///
/// Default value: The ZegoSuperBoardView object is obtained by default.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Note: If the enableSuperBoardView API is used and the parameter is set to false, the ZegoSuperBoardView object cannot be obtained.
///
/// Supported version: 2.0.0
@property (nonatomic, strong,readonly) ZegoSuperBoardView *superBoardView;

/// Description: Use superBoardSubViewModelList to obtain the number of superBoardSubView objects in the current room and superBoardSubView information.
///
/// Business scenario: Obtain the list of superBoardSubView objects in a room after entering the room and switch the currently displayed superBoardSubView.
///
/// Calling time/Notification time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// Supported version: 2.0.0
@property (nonatomic, strong,readonly) NSArray <ZegoSuperBoardSubViewModel *> *superBoardSubViewModelList;

/// Obtain the ZegoSuperBoardManager instance object.
///
/// Supported version: 2.0.0 and above
///
/// Description: Obtain the ZegoSuperBoardManager instance object to call methods in the ZegoSuperBoardManager API.
///
/// Calling time: Call this API after the ZegoSuperBoard SDK is integrated and before it is initialized.
///
/// @return ZegoSuperBoardManager instance object.
+ (ZegoSuperBoardManager *)sharedInstance;

/// Initialize the ZegoSuperBoard SDK.
///
/// Supported version: 2.0.0 and above
///
/// Description: Initialize the ZegoSuperBoard SDK.
///
/// Business scenario: Initialize the ZegoSuperBoard SDK.
///
/// Calling time: Before using the SDK features, call this method to initialize the SDK. If not, the features are unavailable.
///
/// Related APIs: unInit
///
/// @param config Configuration information required for initializing the SDK
/// @param complete Callback of the initialization result
- (void)initWithConfig:(ZegoSuperBoardInitConfig *)config complete:(ZegoSuperBoardManagerBlock)complete;

/// Set configuration items.
/// For example:
/// When the key is logPath, the value is the SDK log directory address.
/// When the key is cachePath, the value is the SDK cache directory address.
///
/// Supported version: 2.0.0 and above
/// Calling time: Call this API before the Superboard SDK is initialized.
///
/// @param value value description
/// @param key  key description
- (void)setCustomizedConfig:(nonnull NSString *)value key:(nonnull NSString *)key;

/// Set whether to use SuperBoardView.
///
/// Supported version: 2.0.0 and above
///
/// Description: Set whether to use SuperBoardView.
///
/// Calling time: Call this API before the SDK is initialized.
///
/// Note: By default, SuperBoardView is enabled.
///
/// @param enable YES indicates that SuperBoardView is used; NO indicates that SuperBoardView is not used. The default value is YES.
- (void)enableSuperBoardView:(BOOL)enable;

/// Create a pure whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: After a pure whiteboard is created, the corresponding SubView is saved and the subViewModel data is returned.
///
/// Calling time: Call this API when a pure whiteboard needs to be created after the ZegoSuperboard SDK is initialized and [loginRoom] is called to log in to the room.
///
/// @param config Configuration parameters related to the pure whiteboard
/// @param complete Callback of the pure whiteboard creation result
- (void)createWhiteboardView:(nonnull ZegoCreateWhiteboardConfig *)config complete:(ZegoSuperBoardManagerCreateBlock)complete;

/// Create a file whiteboard.
///
/// Supported version: 2.0.0 and above
///
/// Description: After a pure whiteboard is created, the corresponding SubView is saved and the subViewModel data is returned.
///
/// Calling time: Call this API when a file whiteboard needs to be created after the ZegoSuperboard SDK is initialized and [loginRoom] is called to log in to the room.
///
/// @param config Configuration parameters required for creating a file whiteboard
/// @param complete Callback of the file whiteboard creation result
- (void)createFileView:(nonnull ZegoCreateFileConfig *)config complete:(ZegoSuperBoardManagerCreateBlock)complete;

/// Destroy the specified SuperBoardSubView.
///
/// Supported version: 2.0.0 and above
///
/// Calling time: Call this API after querySuperBoardSubViewList is called to obtain the list or the number of models obtained through superBoardSubViewModelList is greater than 0.
///
/// @param uniqueID Unique ID of the ZegoSuperBoardSubView object
/// @param complete Callback of the specified SuperBoardSubView destroying result
- (void)destroySuperBoardSubView:(NSString *)uniqueID complete:(ZegoSuperBoardManagerBlock)complete;

/// Query the list of existing SuperBoardSubView objects from the server.
///
/// Supported version: 2.0.0 and above
///
/// Description: Obtain all whiteboards in the current room. The SDK will also load files associated with whiteboards. The SDK will process the relationship between whiteboards and files and add them to the ZegoSuperBoardSubView object. You only need to use ZegoSuperBoardView.
///
/// Calling time: Call this API after the SDK is initialized and you log in to the room.
///
/// @param complete Callback of the SuperBoardSubView list obtaining result
- (void)querySuperBoardSubViewList:(void(^)(ZegoSuperBoardError errorCode,NSArray <ZegoSuperBoardSubViewModel *>*superBoardViewList))complete;

/// Obtain the specified SuperBoardSubView object.
///
/// Supported version: 2.0.0 and above
///
/// Calling time: Call this API after the SDK is initialized, you log in to the room, and the SuperBoardSubView list is obtained.
///
/// Note: This API applies only to scenarios in which SuperBoardView is not used.
///
/// @param uniqueID Unique ID of the ZegoSuperBoardSubView object
- (ZegoSuperBoardSubView *)getSuperBoardSubView:(NSString *)uniqueID;

/// Clear cache resources related to files and whiteboards.
///
/// Supported version: 2.0.0 and above
///
/// Calling time: After the SDK is initialized and you log in to a room, you can proactively call this API to clear resources in the room before leaving the room.
- (void)clearCache;

/// Call this API to clear resources in a room before leaving the room.
///
/// Supported version: 2.0.0 and above
///
/// Description: Clear cached information in a room and stop media playing before leaving the room.
///
/// Calling time: Call this API proactively before leaving a room.
- (void)clear;

/// De-initialize the SDK.
///
/// Supported version: 2.0.0 and above
///
/// Calling time: When you need to re-initialize the SDK, you must call unInit first.
- (void)unInit;

/// Obtain the SDK version number.
///
/// Supported version: 2.0.0 及以上。
///
/// Description: Obtain the SDK version number.
///
/// Business scenario:
/// 1. If you find unexpected results during SDK running, you can submit the issues and related logs to ZEGOCLOUD technical support for locating. ZEGOCLOUD technical support may need the SDK version information to facilitate issue locating.
/// 2. You can collect the SDK version information to collect statistics about SDK versions mapping to different app versions online.
///
/// Calling time: This API can be called at any time.
///
/// @return SDK version number.
- (NSString *)getSDKVersion;

/// Obtain the values of set configuration items.
///
/// Supported version: 2.0.0 and above
///
/// Description: Obtain the values of set configuration items.
///
/// Calling time: Call this API after the Super Board SDK is initialized and the setCustomizedConfig API is called.
///
/// @param key Configuration item whose value is to be obtained
- (NSString *)getCustomizedConfig:(nonnull NSString *)key;

/// Set authentication token
/// 
/// @param token token
- (void)renewToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END

