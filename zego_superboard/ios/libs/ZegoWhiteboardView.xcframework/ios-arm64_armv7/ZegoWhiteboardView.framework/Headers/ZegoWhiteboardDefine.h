//
//  ZegoWhiteboardDefine.h
//  ZegoWhiteboardView
//
//  Created by zego on 2020/4/13.
//  Copyright © 2020 zego. All rights reserved.
//



#ifndef ZegoWhiteboardDefine_h
#define ZegoWhiteboardDefine_h

#define ZEGO_WHITEBOARD_VIEW_VERSION @"ZegoWhiteboardView_v2.3.5.137_221219_163420_ios"
#define ZEGO_WHITEBOARD_MATCH_VERSION @"2.3.5"

/** Whiteboard ID type, which uniquely identifies a whiteboard. */
typedef unsigned long long ZegoWhiteboardID;

NS_ASSUME_NONNULL_BEGIN

/// Whiteboard operation tools (teaching tools)
///
typedef NS_ENUM(NSUInteger, ZegoWhiteboardTool) {

    /// Drawing
    ZegoWhiteboardViewToolPen = 1,

    /// Text box
    ZegoWhiteboardViewToolText = 2,

    /// Straight line
    ZegoWhiteboardViewToolLine = 4,

    /// Outlined rectangle
    ZegoWhiteboardViewToolRect = 8,

    /// Outlined ellipse
    ZegoWhiteboardViewToolEllipse = 16,

    /// Selection tool
    ZegoWhiteboardViewToolSelector = 32,

    /// Eraser
    ZegoWhiteboardViewToolEraser = 64,

    /// Laser pen
    ZegoWhiteboardViewToolLaser = 128,

    /// Animated PPT file click tool
    ZegoWhiteboardViewToolClick = 256,

    /// Custom graph tool
    ZegoWhiteboardViewToolCustomImage = 512,

    /// Unknown type
    ZegoWhiteboardViewToolNone = 0,
    
    /// Cursor
    ZegoWhiteboardViewToolCursor = 1024,

};

/// Whiteboard error code enumeration
///
typedef NS_ENUM(NSUInteger, ZegoWhiteboardViewError) {

    /// Success.
    ZegoWhiteboardViewSuccess = 0,

    /// Internal error.
    ZegoWhiteboardViewErrorInternal = 3000001,

    /// Incorrect parameter.
    ZegoWhiteboardViewErrorParamInvalid = 3000002,

    /// Network timeout.
    ZegoWhiteboardViewErrorNetworkTimeout = 3000003,

    /// Network interruption.
    ZegoWhiteboardViewErrorNetworkDisconnect = 3000004,

    /// Network packet return error.
    ZegoWhiteboardViewErrorInvalidRsp = 3000005,

    /// Too frequent requests.
    ZegoWhiteboardViewErrorRequestTooMany = 3000006,
    
    /// Initialization failed.， Whiteboard and liveroom versions do not match
    ZegoWhiteboardViewErrorVersionMismatch = 3000007,
    
    /// Initialization failed.， Whiteboard and express versions do not match
    ZegoWhiteboardViewErrorExpressImcompatible = 3000008,
    
    /// Token expired
    ZegoWhiteboardViewErrorTokenInvalid = 3000009,

    /// You have not logged in to the room.
    ZegoWhiteboardViewErrorNoLoginRoom = 3010001,

    /// The user does not exist.
    ZegoWhiteboardViewErrorUserNotExist = 3010002,

    /// The whiteboard view does not exist.
    ZegoWhiteboardViewErrorViewNotExist = 3020001,

    /// Failed to create the whiteboard view.
    ZegoWhiteboardViewErrorViewCreateFail = 3020002,

    /// Failed to modify the whiteboard view.
    ZegoWhiteboardViewErrorViewModifyFail = 3020003,

    /// The whiteboard view name is too long.
    ZegoWhiteboardViewErrorViewNameLimit = 3020004,

    /// The parent container of the whiteboard view does not exist.
    ZegoWhiteboardViewErrorViewParentNotExist = 3020005,

    /// The number of whiteboards exceeds the upper limit.
    ZegoWhiteboardViewErrorViewNumLimit = 3020006,
    
    /// The animation information is too long.
    ZegoWhiteboardViewErrorAnimationInfoLimit = 3020007,

    /// The diagram element does not exist.
    ZegoWhiteboardViewErrorGraphicNotExist = 3030001,

    /// Diagram element creation error.
    ZegoWhiteboardViewErrorGraphicCreateFail = 3030002,

    /// Diagram element modification error.
    ZegoWhiteboardViewErrorGraphicModifyFail = 3030003,

    /// Drawing is disabled.
    ZegoWhiteboardViewErrorGraphicUnableDraw = 3030004,

    /// The data size of a single diagram element exceeds the limit.
    ZegoWhiteboardViewErrorGraphicDataLimit = 3030005,

    /// The number of diagram elements exceeds the upper limit.
    ZegoWhiteboardViewErrorGraphicNumLimit = 3030006,

    /// The text content exceeds the maximum value.
    ZegoWhiteboardViewErrorGraphicTextLimit = 3030007,

    /// Initialization failed.
    ZegoWhiteboardViewErrorInitFail = 3040001,

    /// Failed to obtain the whiteboard view list.
    ZegoWhiteboardViewErrorGetListFail = 3040002,

    /// Failed to create the whiteboard view.
    ZegoWhiteboardViewErrorCreateFail = 3040003,

    /// Failed to destroy the whiteboard view.
    ZegoWhiteboardViewErrorDestroyFail = 3040004,

    /// Failed to attach the whiteboard view.
    ZegoWhiteboardViewErrorAttachFail = 3040005,

    /// Failed to clear the whiteboard view
    ZegoWhiteboardViewErrorClearFail = 3040006,

    /// Failed to scroll through the whiteboard view.
    ZegoWhiteboardViewErrorScrollFail = 3040007,

    /// Undo operation failed.
    ZegoWhiteboardViewErrorUndoFail = 3040008,

    /// Redo operation failed.
    ZegoWhiteboardViewErrorRedoFail = 3040009,
    
    /// Unable to create or write the log directory set during initialization.
    ZegoWhiteboardViewErrorLogPathNotAccess = 3040010,
    
    /// Unable to create or write the cache directory set during initialization.
    ZegoWhiteboardViewErrorCacheFolderNotAccess = 3040011,
    
    /// Whiteboard switching failed.
    ZegoWhiteboardViewErrorSwitchFail = 3040012,

    /// The size of the image diagram element exceeds the upper limit.
    ZegoWhiteboardViewErrorGraphicImageSizeLimit = 3030008,

    /// Unsupported image type.
    ZegoWhiteboardViewErrorGraphicImageTypeNotSupport = 3030009,

    /// Invalid image URL.
    ZegoWhiteboardViewErrorGraphicIllegalAddress = 3030010,
    
    // The set cursor offset exceeds the limit.
    ZegoWhiteboardViewErrorGraphicCursorOffsetLimit = 3030011,
    
    /// @deprecated
    /// Use ZegoWhiteboardViewErrorGraphicIllegalAddress.
    ZegoWhiteboardViewErrorGraphicIllegalUrl DEPRECATED_ATTRIBUTE = ZegoWhiteboardViewErrorGraphicIllegalAddress,

    /// No whiteboard zooming permission.
    ZegoWhiteboardViewErrorNoAuthScale = 3050001,

    /// No whiteboard scrolling permission.
    ZegoWhiteboardViewErrorNoAuthScroll = 3050002,

    /// No diagram element creation permission.
    ZegoWhiteboardViewErrorNoAuthCreateGraphic = 3050003,

    /// No diagram element editing permission.
    ZegoWhiteboardViewErrorNoAuthUpdateGraphic = 3050004,

    /// No diagram element movement permission.
    ZegoWhiteboardViewErrorNoAuthMoveGraphic = 3050005,

    /// No diagram element deletion permission.
    ZegoWhiteboardViewErrorNoAuthDeleteGraphic = 3050006,

    /// No diagram element clearing permission.
    ZegoWhiteboardViewErrorNoAuthClearGraphic = 3050007,
    
    
};

/// Type of images added to ZegoWhiteboardView.
///
typedef NS_ENUM(NSUInteger, ZegoWhiteboardViewImageType) {

    /// Common images
    ZegoWhiteboardViewImageTypeGraphic = 0,

    /// Custom images
    ZegoWhiteboardViewImageTypeCustom = 1

};

/// Whiteboard operation mode
///
typedef NS_OPTIONS(NSUInteger, ZegoWhiteboardOperationMode) {

    /// Non-operational mode. If this mode is enabled together with other modes, this mode prevails.
    ZegoWhiteboardOperationModeNone = 1 << 0,

    /// Scrolling mode. In this mode, you can scroll and turn pages and synchronize the operations with other clients. In this mode, the whiteboard cannot respond to manual drawing operations. This mode cannot be used together with ZegoWhiteboardOperationModeDraw.
    ZegoWhiteboardOperationModeScroll = 1 << 1,

    /// Drawing mode. In this mode, the whiteboard will respond to diagram element drawing operations and synchronize the operations with other clients. The whiteboard page cannot be scrolled. This mode cannot be used together with ZegoWhiteboardOperationModeScroll.
    ZegoWhiteboardOperationModeDraw = 1 << 2,

    /// Zooming mode. In this mode, you can zoom in on the content of a whiteboard.
    ZegoWhiteboardOperationModeZoom = 1 << 3,

};

/// Padding mode of the whiteboard background image.
///
typedef NS_ENUM(NSUInteger, ZegoWhiteboardViewImageFitMode) {

    /// Align left and zoom in or out by width or height proportionally.
    ZegoWhiteboardViewImageFitModeLeft = 0,

    /// Align right and zoom in or out by width or height proportionally.
    ZegoWhiteboardViewImageFitModeRight = 1,

    /// Align bottom edge and zoom in or out by width or height proportionally.
    ZegoWhiteboardViewImageFitModeBottom = 2,

    /// Align top edge and zoom in or out by width or height proportionally.
    ZegoWhiteboardViewImageFitModeTop = 3,

    /// Align center and zoom in or out by width or height proportionally.
    ZegoWhiteboardViewImageFitModeCenter = 4

};

// Cursor type enumeration
typedef NS_ENUM (NSUInteger, ZegoWhiteboardViewCursorType){
    ZegoWhiteboardViewCursorTypePen = 0x0 /**< Pen 0*/,
};

NS_ASSUME_NONNULL_END

#endif /* ZegoWhiteboardDefine_h */

