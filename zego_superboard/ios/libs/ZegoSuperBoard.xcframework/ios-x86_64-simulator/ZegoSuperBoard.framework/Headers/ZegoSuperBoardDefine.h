//
//  ZegoSuperBoardDefine.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#ifndef ZegoSuperBoardDefine_h
#define ZegoSuperBoardDefine_h


#define ZEGO_SUPERBOARD_VERSION @"ZegoSuperBoard_v2.3.5.174_221219_164637_ios"
#define ZEGO_SUPERBOARD_MATCH_VERSION @"2.3.5"

static NSString * _Nonnull SUPER_BOARD_REQUEST_SEQ = @"request_seq";        // Operation serial number
static NSString * _Nonnull SUPER_BOARD_UPLOAD_PERCENT = @"upload_percent";  // Upload progress
static NSString * _Nonnull SUPER_BOARD_UPLOAD_FILEID = @"upload_fileid";    // File ID after format conversion
static NSString * _Nonnull SUPER_BOARD_CACHE_PERCENT = @"cache_percent";    // Download progress

NS_ASSUME_NONNULL_BEGIN

/// File caching status
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardCacheFileState) {

    /// Caching
    ZegoSuperBoardCacheFileStateCaching = 1,

    /// Cached
    ZegoSuperBoardCacheFileStateCached = 2

};

/// Super Board error code enumeration
///
/// Description: Error codes occurred during SDK usage.
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardError) {

    /// Success.
    ZegoSuperBoardSuccess = 0,

    /// Internal error.
    ZegoSuperBoardErrorInternal = 3100001,

    /// Incorrect parameter. Pay attention to the information output by the console.
    ZegoSuperBoardErrorParamInvalid = 3100002,

    /// Network timeout.
    ZegoSuperBoardErrorNetworkTimeout = 3100003,

    /// Network interruption.
    ZegoSuperBoardErrorNetworkDisconnect = 3100004,

    /// Network packet return error.
    ZegoSuperBoardErrorResponse = 3100005,

    /// Too frequent requests.
    ZegoSuperBoardErrorRequestTooFrequent = 3100006,

    /// Initialization failed. Use the ZegoExpress-Video SDK that matches the whiteboard version.
    ZegoSuperBoardErrorVersionMismatch = 3100007,

    /// Initialization failed. Use the ZegoExpress-Video SDK that provides the whiteboard function.
    ZegoSuperBoardErrorExpressImcompatible = 3100008,
    
    /// Request failure.
    ZegoSuperBoardErrorRequestFailure = 3100009,
    
    ///Whiteboard token expired
    ZegoSuperBoardErrorWhiteboardTokenInvalid = 3100010,

    ///Docs token expired
    ZegoSuperBoardErrorDocsTokenInvalid = 3100011,
    
    ///Docs token expired file or sign invalid
     ZegoSuperBoardErrorDocsSignInvalid = 3100012,

    /// You have not logged in to the room.
    ZegoSuperBoardErrorNoLoginRoom = 3110001,

    /// The whiteboard view does not exist.
    ZegoSuperBoardErrorViewNotExist = 3120001,

    /// Failed to create the whiteboard view.
    ZegoSuperBoardErrorViewCreateFail = 3120002,

    /// Failed to modify the whiteboard view.
    ZegoSuperBoardErrorViewModifyFail = 3120003,

    /// The whiteboard view name is too long.
    ZegoSuperBoardErrorViewNameLimit = 3120004,

    /// The parent container of the whiteboard view does not exist.
    ZegoSuperBoardErrorViewParentNotExist = 3120005,

    /// The number of whiteboards exceeds the upper limit.
    ZegoSuperBoardErrorViewNumLimit = 3120006,

    /// The animation information is too long.
    ZegoSuperBoardErrorAnimationInfoLimit = 3120007,

    /// The diagram element does not exist.
    ZegoSuperBoardErrorGraphicNotExist = 3130001,

    /// Diagram element creation error.
    ZegoSuperBoardErrorGraphicCreateFail = 3130002,

    /// Diagram element modification error.
    ZegoSuperBoardErrorGraphicModifyFail = 3130003,

    /// Drawing is disabled.
    ZegoSuperBoardErrorGraphicUnableDraw = 3130004,

    /// The data size of a single diagram element exceeds the limit.
    ZegoSuperBoardErrorGraphicDataLimit = 3130005,

    /// The number of diagram elements exceeds the upper limit.
    ZegoSuperBoardErrorGraphicNumLimit = 3130006,

    /// The number of text words exceeds the limit.
    ZegoSuperBoardErrorGraphicTextLimit = 3130007,

    /// The size of the image diagram element exceeds the upper limit.
    ZegoSuperBoardErrorGraphicImageSizeLimit = 3130008,

    /// Unsupported image type.
    ZegoSuperBoardErrorGraphicImageTypeNotSupport = 3130009,

    /// Invalid image URL. Possible causes: An invalid network URL is entered when the image is specified. An invalid local path is entered when the image is specified.
    ZegoSuperBoardErrorGraphicIllegalAddress = 3130010,

    // The set cursor offset exceeds the limit.
    ZegoSuperBoardErrorGraphicCursorOffsetLimit = 3130011,

    /// Initialization failed.
    ZegoSuperBoardErrorInitFail = 3140001,

    /// Failed to obtain the whiteboard view list.
    ZegoSuperBoardErrorGetListFail = 3140002,

    /// Failed to create the whiteboard view.
    ZegoSuperBoardErrorCreateFail = 3140003,

    /// Failed to destroy the whiteboard view.
    ZegoSuperBoardErrorDestroyFail = 3140004,

    /// Failed to attach the whiteboard view.
    ZegoSuperBoardErrorAttachFail = 3140005,

    /// Failed to clear the whiteboard view
    ZegoSuperBoardErrorClearFail = 3140006,

    /// Failed to scroll the whiteboard view.
    ZegoSuperBoardErrorScrollFail = 3140007,

    /// Undo operation failed.
    ZegoSuperBoardErrorUndoFail = 3140008,

    /// Redo operation failed.
    ZegoSuperBoardErrorRedoFail = 3140009,

    /// Unable to create or write the log directory set during initialization.
    ZegoSuperBoardErrorLogFolderNotAccess = 3140010,

    /// Unable to create or write the cache directory set during initialization.
    ZegoSuperBoardErrorCacheFolderNotAccess = 3140011,

    /// Whiteboard view switching failed.
    ZegoSuperBoardErrorSwitchFail = 3140012,

    /// No whiteboard zooming permission.
    ZegoSuperBoardErrorNoAuthScale = 3150001,

    /// No whiteboard scrolling permission.
    ZegoSuperBoardErrorNoAuthScroll = 3150002,

    /// No diagram element creation permission.
    ZegoSuperBoardErrorNoAuthCreateGraphic = 3150003,

    /// No diagram element editing permission.
    ZegoSuperBoardErrorNoAuthUpdateGraphic = 3150004,

    /// No whiteboard movement permission.
    ZegoSuperBoardErrorNoAuthMoveGraphic = 3150005,

    /// No whiteboard deletion permission.
    ZegoSuperBoardErrorNoAuthDeleteGraphic = 3150006,

    /// No whiteboard clearing permission.
    ZegoSuperBoardErrorNoAuthClearGraphic = 3150007,

    /// Unable to find the corresponding local file. Possible causes: An incorrect file path is visited during uploading. The local file is deleted.
    ZegoSuperBoardErrorFileNotExist = 3111001,

    /// Upload failed.
    ZegoSuperBoardErrorUploadFailed = 3111002,

    /// Unsupported rendering mode.
    ZegoSuperBoardErrorUnsupportRenderType = 3111003,

    /// The file to be transcoded is encrypted. Possible causes: A password is required for Word file access. A password is required for Excel file access. A password is required for PPT file access.
    ZegoSuperBoardErrorFileEncrypt = 3121001,

    /// Too much file content. Possible causes: The size of the Excel file exceeds 10 MB. It takes a long time to open the Excel file. The size of the text file exceeds 2 MB. The size of other files exceeds 100 MB.
    ZegoSuperBoardErrorFileSizeLimit = 3121002,

    /// The file contains too many pages. Possible causes: The Excel file contains more than 20 sheets. The Word file contains more than 500 pages. The PPT file contains more than 500 pages.
    ZegoSuperBoardErrorFileSheetLimit = 3121003,

    /// Format conversion failed.
    ZegoSuperBoardErrorConvertFail = 3121004,

    /// Insufficient local space.
    ZegoSuperBoardErrorFreeSpaceLimit = 3131005,

    /// File uploading is not supported.
    ZegoSuperBoardErrorUploadNotSupported = 3131006,

    /// An identical file is being uploaded.
    ZegoSuperBoardErrorUploadDuplicated = 3131007,

    /// Empty domain name.
    ZegoSuperBoardErrorEmptyDomain = 3131008,

    /// Initialized.
    ZegoSuperBoardErrorDuplicateInit = 3131009,

    /// The corresponding transcoded file cannot be found. Possible causes: An incorrect file ID is entered when the file is visited. For example, different App IDs are used when the file is uploaded and currently visited. The corresponding transcoded file is deleted. The environment for file uploading is different from that for file visiting.
    ZegoSuperBoardErrorServerFileNotExist = 3131010,

    /// Unable to create or write the log directory set during initialization.
    ZegoSuperBoardErrorDocLogFolderNotAccess = 3131011,

    /// Unable to create or write the cache directory set during initialization.
    ZegoSuperBoardErrorDocCacheFolderNotAccess = 3131012,

    /// Unable to create or write the data directory set during initialization.
    ZegoSuperBoardErrorDocDataFolderNotAccess = 3131013,

    /// This file cannot be pre-loaded. Contact ZEGOCLOUD technical support. Possible causes: The service is not activated for the current App ID. The file does not support pre-loading.
    ZegoSuperBoardErrorCacheNotSupported = 3131014,

    /// Pre-loading failed. Possible causes: A network error occurred.
    ZegoSuperBoardErrorCacheFailed = 3131015,

    /// Invalid ZIP file. Possible causes: The ZIP file is invalid. The file is damaged.
    ZegoSuperBoardErrorZipFileInvalid = 3131016,

    /// Invalid H5 file. The file does not meet the H5 file specifications defined by ZEGOCLOUD. Possible causes: The file does not contain index.html.
    ZegoSuperBoardErrorH5FileInvalid = 3131017,
    
    /// The file is damaged.
    ZegoSuperBoardErrorFileCorruption = 3131018,
    
    /// The file content is incomplete.
    ZegoSuperBoardErrorFileContentIncomplete = 3131019,

    /// Format conversion canceled.
    ZegoSuperBoardErrorConvertCancel = 3121005,

    /// The file content is empty. Possible causes: The PDF file has no content. The PPT file has no content. The Excel file has no content. The Word file has no content.
    ZegoSuperBoardErrorFileContentEmpty = 3121006,

    /// The source file has elements that do not support transcoding.
    ZegoSuperBoardErrorConvertElementNotSupported  = 3121008,

    /// The file suffix does not meet the file specifications defined by ZEGOCLOUD.
    ZegoSuperBoardErrorConvertFileTypeInvalid = 3121009,
    
    /// The source file has security risks and cannot be opened.
    ZegoSuperBoardErrorConvertFileUnsafe = 3121010,
    
    /// After transcoding is ended, some images or audio or video files failed to be exported.
    ZegoSuperBoardErrorConvertElementNotExported = 3121011,

    /// Authentication parameter error.
    ZegoSuperBoardErrorAuthParamInvalid = 3131001,

    /// Insufficient path permission. Possible causes: The log directory transferred during initialization is unavailable. The cache directory transferred during initialization is unavailable. The data directory transferred during initialization is unavailable.
    ZegoSuperBoardErrorFilePathNotAccess = 3131002,

    /// Initialization failed.
    ZegoSuperBoardErrorInitFailed = 3131003,

    /// The file is read-only. Possible causes: The animated PPT file is set to read-only, which will cause a transcoding failure. The animated PPT file contains fonts that are not supported by the transcoding server, which will cause a transcoding failure.
    ZegoSuperBoardErrorFileReadOnly = 3121007,

    /// Unable to obtain the width and height of the current view.
    ZegoSuperBoardErrorSizeInvalid = 3131004

};

/// File type
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardFileType) {

    /// Unknown
    ZegoSuperBoardFileTypeUnknown = 0,

    /// PPT files without animations
    ZegoSuperBoardFileTypePPT = 1,

    /// Word files
    ZegoSuperBoardFileTypeDOC = 2,

    /// Excel files
    ZegoSuperBoardFileTypeELS = 4,

    /// PDF files
    ZegoSuperBoardFileTypePDF = 8,

    /// Images (JPG, JPEG, PNG, and BMP)
    ZegoSuperBoardFileTypeIMG = 16,

    /// Text files
    ZegoSuperBoardFileTypeTXT = 32,

    /// Animated PPT files
    ZegoSuperBoardFileTypeDynamicPPTH5 = 512,

    /// H5 files
    ZegoSuperBoardFileTypeCustomH5 = 4096

};

/// Whiteboard operation mode, which affects the gesture identification on whiteboards.
///
/// Business scenario: When the scrolling mode is set, gestures are identified as scrolling. When the drawing mode is set, gestures are identified as drawing tools, such as the pen, straight line, and rectangle. When the None mode is set, the whiteboard does not respond to any gesture.
///
typedef NS_OPTIONS(NSUInteger, ZegoSuperBoardOperationMode) {

    /// Not respond to any gesture.
    ZegoSuperBoardOperationModeNone = 1 << 0,

    /// Scrolling mode. In this mode, you can scroll and turn pages and synchronize the operations with other clients. In this mode, the whiteboard cannot respond to manual drawing operations. This mode cannot be used together with ZegoWhiteboardOperationModeDraw.
    ZegoSuperBoardOperationModeScroll = 1 << 1,

    /// Drawing mode. In this mode, the whiteboard will respond to diagram element drawing operations and synchronize the operations with other clients. The whiteboard page cannot be scrolled. This mode cannot be used together with ZegoWhiteboardOperationModeScroll.
    ZegoSuperBoardOperationModeDraw = 1 << 2,

    /// Zooming gesture. If it is not set, the whiteboard is not zoomed in or out with gestures.
    ZegoSuperBoardOperationModeZoom = 1 << 3

};

/// File rendering mode during file upload.
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardRenderType) {

    /// Vector mode (Vector): This mode applies to intelligent file conversion of the file sharing SDK at the PC or mobile client to support a good file browsing experience and zooming with higher definition.
    ZegoSuperBoardRenderTypeVector = 1,

    /// Image mode (IMG): This mode applies to file conversion of the file sharing SDK at the web client or mini program. Based on the file style, an image is generated for each page.
    ZegoSuperBoardRenderTypeIMG = 2,

    /// Vector and image mode (VectorAndIMG): This mode applies when multiple clients, such as the web client, mini program, mobile client, and PC client coexist. The image mode is used for the web client and mini program, and the vector mode is used for the PC and mobile clients.
    ZegoSuperBoardRenderTypeVectorAndIMG = 3,

    /// Animated PPT mode (DynamicPPTH5): This mode applies to PPT file transcoding of the file sharing SDK at the PC client, mobile client, web client, or mini program. PPT files will be converted to H5 files.
    ZegoSuperBoardRenderTypeDynamicPPTH5 = 6,

    /// H5 files
    ZegoSuperBoardRenderTypeCustomH5 = 7

};

/// Whiteboard tool type
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardTool) {

    /// No tool is set.
    ZegoSuperBoardToolNone = 0,

    /// Pen
    ZegoSuperBoardToolPen = 1,

    /// Text
    ZegoSuperBoardToolText = 2,

    /// Straight line
    ZegoSuperBoardToolLine = 4,

    /// Rectangle
    ZegoSuperBoardToolRect = 8,

    /// Ellipse
    ZegoSuperBoardToolEllipse = 16,

    /// Selection tool
    ZegoSuperBoardToolSelector = 32,

    /// Eraser
    ZegoSuperBoardToolEraser = 64,

    /// Laser pen
    ZegoSuperBoardToolLaser = 128,

    /// Click tool. It is used to click content of animated PPT and H5 files.
    ZegoSuperBoardToolClick = 256,

    /// Custom graph. After it is set, the custom graph introduced through the addImage API will be drawn on the whiteboard when you draw on the whiteboard.
    ZegoSuperBoardToolCustomImage = 512

};

/// File uploading status
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardUploadFileState) {

    /// File upload phase.
    ZegoSuperBoardUploadFileStateUpload = 1,

    /// File transcoding phase.
    ZegoSuperBoardUploadFileStateConvert = 2

};

/// Alignment mode of the background image inserted into a whiteboard.
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardViewImageFitMode) {

    /// Align left
    ZegoSuperBoardViewImageFitModeLeft = 0,

    /// Align right
    ZegoSuperBoardViewImageFitModeRight = 1,

    /// Align bottom edge
    ZegoSuperBoardViewImageFitModeBottom = 2,

    /// Align top edge
    ZegoSuperBoardViewImageFitModeTop = 3,

    /// Align center
    ZegoSuperBoardViewImageFitModeCenter = 4

};

/// Type of images inserted into a whiteboard.
///
/// Description: Type of images inserted into a whiteboard. Currently, common images and custom graphs are supported.
///
/// Note: Supported image formats are PNG, JPG, and JPEG. When type is set to Graphic, local and network images are supported. The image size must be less than 10 MB. When type is set to Custom, only network images are supported, and the image size must be less than 500 KB.
///
typedef NS_ENUM(NSUInteger, ZegoSuperBoardViewImageType) {

    /// Common images
    ZegoSuperBoardViewImageTypeGraphic = 0,

    /// Custom images
    ZegoSuperBoardViewImageTypeCustom = 1

};

// Cursor type enumeration
typedef NS_ENUM(NSUInteger, ZegoSuperBoardViewCursorType) {

    /// Pen
    ZegoSuperBoardViewCursorTypePen = 0,

};




NS_ASSUME_NONNULL_END

#endif /* ZegoSuperBoardDefine_h */

