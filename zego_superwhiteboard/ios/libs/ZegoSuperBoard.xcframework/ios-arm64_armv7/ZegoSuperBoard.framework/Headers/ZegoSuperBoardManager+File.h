//
//  ZegoSuperBoardManager+File.h
//  ZegoSuperBoard
//
//  Created by ZEGOCLOUD on 2021/8/2.
//

#import "ZegoSuperBoardManager.h"
#import "ZegoUploadCustomH5Config.h"

typedef unsigned int ZegoSuperBoardSeq;

NS_ASSUME_NONNULL_BEGIN

/// Callback of the cacheFile method.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the file caching status through the block method after the cacheFile API is called.
///
/// Business scenario: Cache files to a local directory.
///
/// Callback time: Call this callback after the cacheFile API is called.
///
/// Related APIs:  [cacheFile]
///
/// @param state File caching consists of the ZegoSuperBoardCacheFileStateCaching and ZegoSuperBoardCacheFileStateCached phases.
/// @param errorCode Callback error code in the current phase. 0 indicates successful execution.
/// @param infoDictionary Information contained in the callback of the current phase
///                       In the caching phase, multiple callbacks are generated. If caching is normal, each callback contains the file caching progress. For example, if the caching progress is 50%, the parameter content is {"cache_percent":0.50,"request_seq":xxx}. If the caching progress is 100%, the parameter content is {"cache_percent":1.00,"request_seq":xxx}.
///                       In the cache completion phase, only one callback is generated. For example, if caching is completed normally, the serial number (seq) used during the method call is returned. The seq format is {"request_seq":xxx}}.
typedef void(^ZegoSuperBoardCacheBlock)(ZegoSuperBoardCacheFileState state, ZegoSuperBoardError errorCode, NSDictionary *infoDictionary);

/// Callback of cancelCacheFile method completion.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return whether a file caching task is canceled successfully through the block method.
///
/// Business scenario: Cancel files being cached.
///
/// Callback time: Call this callback after the cancelCacheFile API is called.
///
/// Related APIs: [cancelCacheFile]
///
/// @param errorCode Callback error code. 0 indicates successful execution.
typedef void(^ZegoSuperBoardCancelCacheComplementBlock)(ZegoSuperBoardError errorCode);

/// Callback of cancelUploadFile method completion.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return whether a file upload operation is canceled successfully through the block method after the file upload API is called.
///
/// Business scenario: Cancel the file upload operation.
///
/// Callback time: Call this callback after the cancelUploadFile API is called.
///
/// Related APIs:  [cancelUploadFile]
///
/// @param errorCode Callback error code. 0 indicates successful execution.
typedef void(^ZegoSuperBoardCancelUploadComplementBlock)(ZegoSuperBoardError errorCode);

/// Callback of queryFileCached method completion.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the result of querying a cached file through the block method.
///
/// Business scenario: Cancel files being cached.
///
/// Callback time: Call this callback after the queryFileCached API is called.
///
/// Related APIs: [queryFileCached]
///
/// @param errorCode Callback error code. 0 indicates successful execution.
/// @param fileCached Result of whether the cached file exists
typedef void(^ZegoSuperBoardQueryCachedCompletionBlock)(ZegoSuperBoardError errorCode, BOOL fileCached);

/// Callback of the uploadFile method.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the upload status and result through the block method after the file upload API is called.
///
/// Business scenario: Upload files to the ZegoDocs service.
///
/// Callback time: Call this callback after the uploadFile API is called.
///
/// Related APIs:   [uploadFile]
///
/// @param state The file upload process is divided into two phases: ZegoSuperBoardUploadFileStateUpload (file upload) and ZegoSuperBoardUploadFileStateConvert (format conversion).
/// @param errorCode Callback error code in the current phase. 0 indicates successful execution.
/// @param infoDictionary The content of infoDictionary in the [block] callbacks in different phases are different.
/// Upload phase: If the upload is normal, multiple callbacks are generated, and each callback includes the file upload progress. For example, If the upgrade progress is 50%, the content of infoDictionary is {"upload_percent":0.50,"request_seq":xxx}. If the upgrade progress is 100%, the content of infoDictionary is {"upload_percent":1.00,"request_seq":xxx}.
///                       The value of request_seq is an integer, which is the ID returned by the server during the API calling and is used to distinguish different files that are being uploaded. This parameter is used only when users upload multiple files simultaneously.
///
/// Format conversion phase: If the conversion is successful, only one callback is generated, which includes the ID of the converted file. For example, if the conversion is completed, the content of infoDictionary is {"upload_fileid":"ekxxxxxxxxv","request_seq":xxx}.
///                       The value of upload_fileid is the file ID.
typedef void(^ZegoSuperBoardUploadBlock)(ZegoSuperBoardUploadFileState state, ZegoSuperBoardError errorCode, NSDictionary *infoDictionary);

/// The class contains APIs for file upload, caching, and other operations.
///
/// Description: This class implements file upload, file caching, cached file query, and other features.
///
/// Business scenario: Upload files to the ZegoDoc service or cache files to a local directory.
///
@interface ZegoSuperBoardManager (File)

/// Upload files to the ZegoDocs service.
///
/// Supported version: 2.0.0 and above
///
/// Description: During file upload, the SDK converts the file format based on the introduced [renderType]. The rendering mode of the file after format conversion depends on the introduced [renderType]. You can obtain the upload progress in the result callback.
///
/// Business scenario: Upload files to the ZegoDocs service.
///
/// Note: In the upload phase, multiple callbacks will be generated. For more information, see ZegoSuperBoardUploadFileState.
///
/// Calling time: Call this API after the ZegoSuperBoard SDK is initialized.
///
/// @param filePath Absolute path of the file to be uploaded. PPT, PDF, XLS, JPG, JPEG, PNG, BMP, and TXT files are supported. For more information, see [File Specifications\|_blank](https://doc-zh.zego.im/zh/11291.html).
/// @param renderType Rendering mode of the uploaded file after being transcoded. We recommend that you set it to ZegoSuperBoardRenderTypeVector. For more information, see ZegoSuperBoardDefine.
/// @param completionBlock Callback of the upload progress and result During file upload, you will receive multiple callbacks in [completionBlock]. For more information, see ZegoSuperBoardUploadBlock.
///
/// @return Seq of the file upload request.
- (ZegoSuperBoardSeq)uploadFile:(nonnull NSString *)filePath renderType:(ZegoSuperBoardRenderType)renderType completionBlock:(nonnull ZegoSuperBoardUploadBlock)completionBlock;

/// Cancel the upload operation during file upload.
///
/// Supported version: 2.0.0 and above
///
/// Description: Upload the seq of a file upload task to cancel the file upload operation.
///
/// Business scenario: Cancel a file that is being uploaded to the ZegoDocs service.
///
/// Calling time:  Call this API after the uploadFile API is called and a file is being uploaded.
///
/// @param seq Upload task seq returned when uploadFile is called
/// @param completionBlock Callback of the file upload cancellation result
- (void)cancelUploadFileWithSeq:(ZegoSuperBoardSeq)seq completionBlock:(ZegoSuperBoardCancelUploadComplementBlock)completionBlock;

/// Cache files to a local directory.
///
/// Supported version: 2.0.0 and above
///
/// Description: Cache files to a local directory.
///
/// Business scenario: Save files to a local directory to improve the file opening speed next time.
///
/// Calling time: Call this API after initWithConfig.
///
/// @param fileID ID of the file to be cached
/// @param completionBlock Callback of the file download progress and result
///
/// @return Seq of the file download operation.
- (ZegoSuperBoardSeq)cacheFileWithFileID:(nonnull NSString *)fileID completionBlock:(ZegoSuperBoardCacheBlock)completionBlock;

/// Cancel the caching operation during file caching.
///
/// Supported version: 2.0.0 and above
///
/// Description: Enter the seq of a file caching operation to cancel it. After the operation is canceled, files are not cached in a local directory.
///
/// Business scenario: Cancel a file caching operation that is being performed by calling the cancelCacheFile method.
///
/// Calling time: Call this API after initWithConfig.
///
/// Related APIs: cacheFile
///
/// @param seq Seq of the caching operation
/// @param completionBlock Callback of the caching operation cancellation result
- (void)cancelCacheFileWithSeq:(ZegoSuperBoardSeq)seq completionBlock:(ZegoSuperBoardCancelCacheComplementBlock)completionBlock;

/// Check whether a file is cached.
///
/// Supported version: 2.0.0 and above
///
/// Description: Check whether a file is cached locally based on the file ID.
///
/// Business scenario: Check whether a file is cached.
///
/// Calling time: Call this API after initWithConfig.
///
/// Related APIs: cacheFile
///
/// @param fileID ID of the file to be queried
/// @param completionBlock Query result callback
- (void)queryFileCachedWithFileID:(nonnull NSString *)fileID completionBlock:(ZegoSuperBoardQueryCachedCompletionBlock)completionBlock;

/// Upload custom H5 courseware to the ZegoDocs service.
///
/// Supported version: 2.0.0 and above
///
/// Description: During file upload, the SDK converts the file format based on the introduced [config]. After format conversion, the width, height, page number, and thumbnail display mode are determined by the introduced [config]. You can obtain the upload progress in the result callback.
///
/// Business scenario: Upload custom H5 courseware to the ZegoDocs service.
///
/// Calling time: Call this API after the SDK is initialized.
///
/// @param filePath Local path of the custom courseware
/// @param config Related configuration information of the custom H5 courseware
/// @param completionBlock Result callback
///
/// @return  Request seq of the file upload API.
- (ZegoSuperBoardSeq)uploadH5File:(nonnull NSString *)filePath config:(nonnull ZegoUploadCustomH5Config *)config completionBlock:(ZegoSuperBoardUploadBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

