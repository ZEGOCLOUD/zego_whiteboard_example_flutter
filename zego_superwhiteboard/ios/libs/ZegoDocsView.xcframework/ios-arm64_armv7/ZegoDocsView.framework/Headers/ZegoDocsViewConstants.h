#ifndef ZEGODOCSVIEWCONSTANTS_H 
#define ZEGODOCSVIEWCONSTANTS_H

typedef unsigned int ZegoSeq;

static NSString * _Nonnull REQUEST_SEQ = @"request_seq";        // Operation serial number
static NSString * _Nonnull UPLOAD_PERCENT = @"upload_percent";  // Upload progress
static NSString * _Nonnull UPLOAD_FILEID = @"upload_fileid";    // File ID after format conversion
static NSString * _Nonnull CACHE_PERCENT = @"cache_percent";    // Download progress

NS_ASSUME_NONNULL_BEGIN

/// ZegoDocsView error codes
///
typedef NS_ENUM(NSUInteger, ZegoDocsViewError) {

    /// Execution successful.
    ZegoDocsViewSuccess = 0,

    /// Internal error.
    ZegoDocsViewErrorInternal = 2000001,

    /// Incorrect parameter.
    ZegoDocsViewErrorParamInvalid = 2000002,

    /// Network timeout.
    ZegoDocsViewErrorNetworkTimeout = 2000003,
    
    /// Request failure.
    ZegoDocsViewErrorRequestFailure = 2000004,

    /// The file does not exist.
    ZegoDocsViewErrorFileNotExist = 2010001,

    /// Upload failed.
    ZegoDocsViewErrorUploadFailed = 2010002,

    /// Unsupported rendering mode.
    ZegoDocsViewErrorUnsupportRenderType = 2010003,
    
    /// Invalid sign
    ZegoDocsViewErrorSignInvalid = 2010004,

    /// The file is encrypted.
    ZegoDocsViewErrorFileEncrypt = 2020001,

    /// The file is too large.
    ZegoDocsViewErrorFileSizeLimit = 2020002,

    /// Too many file pages.
    ZegoDocsViewErrorFileSheetLimit = 2020003,

    /// Format conversion failed.
    ZegoDocsViewErrorConvertFail = 2020004,

    /// Format conversion canceled.
    ZegoDocsViewErrorConvertCancel = 2020005,
    
    /// The file is empty.
    ZegoDocsViewErrorFileContentEmpty = 2020006,

    /// The file is read-only.
    /// 1. The animated PPT file is set to read-only, which will cause a transcoding failure.
    /// 2. The animated PPT file contains fonts that are not supported by the transcoding server, which will cause a transcoding failure.
    ZegoDocsViewErrorFileReadOnly = 2020007,
    
    /// The source file has elements that do not support transcoding.
    ZegoDocsViewErrorConvertElementNotSupported = 2020008,
    
    /// The file suffix does not meet the file specifications defined by ZEGOCLOUD.
    ZegoDocsViewErrorConvertFileTypeInvalid = 2020009,
    
    /// The source file has security risks and cannot be opened.
    ZegoDocsViewErrorConvertFileUnsafe = 2020010,
    
    /// After transcoding is ended, some images or audio or video files failed to be exported.
    ZegoDocsViewErrorConvertElementNotExported = 2020011,

    /// Authentication parameter error.
    ZegoDocsViewErrorAuthParamInvalid = 2030001,

    /// Insufficient path permissions.
    ZegoDocsViewErrorFilePathNotAccess = 2030002,

    /// Initialization failed.
    ZegoDocsViewErrorInitFailed = 2030003,

    /// Unable to obtain the width and height of the current view.
    ZegoDocsViewErrorSizeInvalid = 2030004,

    /// Insufficient local space.
    ZegoDocsViewErrorFreeSpaceLimit = 2030005,

    /// File uploading is not supported.
    ZegoDocsViewErrorUploadNotSupported = 2030006,

    /// An identical file is being uploaded.
    ZegoDocsViewErrorUploadDuplicated = 2030007,

    /// Empty domain name.
    ZegoDocsViewErrorEmptyDomain = 2030008,

    /// Unable to find the corresponding transcoded file.
    ZegoDocsViewErrorServerFileNotExist = 2030010,
    
    /// Unable to create or write the log directory set during initialization.
    ZegoDocsViewErrorLogFolderNotAccess = 2030011 ,
    
    /// Unable to create or write the cache directory set during initialization.
    ZegoDocsViewErrorCacheFolderNotAccess = 2030012,
    
    /// Unable to create or write the data directory set during initialization.
    ZegoDocsViewErrorDataFolderNotAccess =  2030013,
    
    /// This file cannot be pre-loaded. Contact ZEGOCLOUD technical support.
    ZegoDocsViewErrorCacheNotSupported = 2030014,
    
    /// Pre-loading failed.
    ZegoDocsViewErrorCacheFailed = 2030015,
    
    /// Invalid ZIP file. The ZIP file is invalid or damaged.
    ZegoDocsViewErrorZipFileInvalid = 2030016,
    
    /// Invalid H5 file. The file does not meet the H5 file specifications defined by ZEGOCLOUD.
    ZegoDocsViewErrorH5FileInvalid = 2030017,
    
    /// The file is damaged.
    ZegoDocsViewErrorFileCorruption = 2030018,
    
    /// The file content is incomplete.
    ZegoDocsViewErrorFileContentIncomplete = 2030019,
    
    /// token Invalid
    ZegoDocsViewErrorTokenInvalid = 2030020,

};

/// File type
///
typedef NS_ENUM(NSUInteger, ZegoDocsViewFileType) {

    /// Unknown
    ZegoDocsViewFileTypeUnknown = 0,

    /// Static PPT files (PPTX and PPT)
    ZegoDocsViewFileTypePPT = 1,

    /// Word files (doc and docx)
    ZegoDocsViewFileTypeDOC = 2,

    /// Excel files (xls and xlsx)
    ZegoDocsViewFileTypeELS = 4,

    /// PDF files
    ZegoDocsViewFileTypePDF = 8,

    /// Images (JPG, JPEG, PNG, and BMP)
    ZegoDocsViewFileTypeIMG = 16,

    /// Text files
    ZegoDocsViewFileTypeTXT = 32,

    /// Animated PPT files (PPTX and PPT)
    ZegoDocsViewFileTypeDynamicPPTH5 = 512,
    
    /// Custom H5 courseware
    ZegoDocsViewFileTypeCustomH5 = 4096

};

/// Rendering mode
///
typedef NS_ENUM(NSUInteger, ZegoDocsViewRenderType) {

    /// Vector mode (Vector): This mode applies to intelligent file conversion of the file sharing SDK at the PC or mobile client to support a good file browsing experience and zooming with higher definition.
    ZegoDocsViewRenderTypeVector = 1,

    /// Image mode (IMG): This mode applies to file conversion of the file sharing SDK at the web client or mini program. Based on the file style, an image is generated for each page.
    ZegoDocsViewRenderTypeIMG = 2,

    /// Vector and image mode (VectorAndIMG): This mode applies when multiple clients, such as the web client, mini program, mobile client, and PC client coexist. The image mode is used for the web client and mini program, and the vector mode is used for the PC and mobile clients.
    ZegoDocsViewRenderTypeVectorAndIMG = 3,

    /// Animated PPT mode (DynamicPPTH5): This mode applies to PPT file transcoding of the file sharing SDK at the PC client, mobile client, web client, or mini program. PPT files will be converted to H5 files.
    ZegoDocsViewRenderTypeDynamicPPTH5 = 6,
    
    /// Custom courseware type.
    ZegoDocsViewRenderTypeCustomH5 = 7

};

/// File download phase.
///
typedef NS_ENUM(NSUInteger, ZegoDocsViewCacheState) {

    /// Caching
    ZegoDocsViewCacheStateCaching = 1,

    /// Cached
    ZegoDocsViewCacheStateCached = 2

};

/// File upload phase.
///
typedef NS_ENUM(NSUInteger, ZegoDocsViewUploadState) {

    /// Uploading
    ZegoDocsViewUploadStateUpload = 1,

    /// Format conversion
    ZegoDocsViewUploadStateConvert = 2

};

NS_ASSUME_NONNULL_END

#endif /* ZegoDocsViewConstants.h */

