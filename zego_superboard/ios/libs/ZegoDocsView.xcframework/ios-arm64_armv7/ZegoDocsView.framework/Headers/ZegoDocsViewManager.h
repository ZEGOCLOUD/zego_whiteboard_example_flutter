#ifndef ZEGODOCSVIEWMANAGER_H
#define ZEGODOCSVIEWMANAGER_H

#import <Foundation/Foundation.h>
#import "ZegoDocsViewConfig.h"
#import "ZegoDocsViewConstants.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Callback of ZegoDocsViewManager init method completion.
///
/// @param errorCode Callback error code. 0 indicates successful execution.
typedef void(^ZegoDocsViewInitBlock)(ZegoDocsViewError errorCode);

/// Callback of the uploadFile method.
///
/// @param state The file upload process is divided into two phases: ZegoDocsViewUploadStateUpload (file upload) and ZegoDocsViewUploadStateConvert (format conversion).
/// @param errorCode Callback error code in the current phase. 0 indicates successful execution.
/// @param infoDictionary The content of infoDictionary in the [block] callbacks in different phases are different.
/// Upload phase: If the upload is normal, multiple callbacks are generated, and each callback includes the file upload progress. For example, If the upgrade progress is 50%, the content of infoDictionary is {"upload_percent":0.50,"request_seq":xxx}. If the upgrade progress is 100%, the content of infoDictionary is {"upload_percent":1.00,"request_seq":xxx}.
///                       The value of request_seq is an integer, which is the ID returned by the server during the API calling and is used to distinguish different files that are being uploaded. This parameter is used only when users upload multiple files simultaneously.
///
/// Format conversion phase: If the conversion is successful, only one callback is generated, which includes the ID of the converted file. For example, if the conversion is completed, the content of infoDictionary is {"upload_fileid":"ekxxxxxxxxv","request_seq":xxx}.
///                       The value of upload_fileid is the file ID.
typedef void(^ZegoDocsViewUploadBlock)(ZegoDocsViewUploadState state, ZegoDocsViewError errorCode, NSDictionary *infoDictionary);

/// Callback of cancelUploadFile method completion.
///
/// @param errorCode Callback error code. 0 indicates successful execution.
typedef void(^ZegoDocsViewCancelUploadComplementBlock)(ZegoDocsViewError errorCode);

/// Callback of the cacheFile method.
///
/// @param state File caching consists of the ZegoDocsViewCacheStateCaching and ZegoDocsViewCacheStateCached phases.
/// @param errorCode Callback error code in the current phase. 0 indicates successful execution.
/// @param infoDictionary Information contained in the callback of the current phase
///                       In the caching phase, multiple callbacks are generated. If caching is normal, each callback contains the file caching progress. For example, if the caching progress is 50%, the parameter content is {"cache_percent":0.50,"request_seq":xxx}. If the caching progress is 100%, the parameter content is {"cache_percent":1.00,"request_seq":xxx}.
///                       In the cache completion phase, only one callback is generated. For example, if caching is completed normally, the serial number (seq) used during the method call is returned. The seq format is {"request_seq":xxx}}.
typedef void(^ZegoDocsViewCacheBlock)(ZegoDocsViewCacheState state, ZegoDocsViewError errorCode, NSDictionary *infoDictionary);

/// Callback of cancelCacheFile method completion.
///
/// @param errorCode Callback error code. 0 indicates successful execution.
typedef void(^ZegoDocsViewCancelCacheComplementBlock)(ZegoDocsViewError errorCode);

/// Callback of queryFileCached method completion.
///
/// @param errorCode Callback error code. 0 indicates successful execution.
/// @param fileCached Result of whether the cached file exists
typedef void(^ZegoDocsViewQueryCachedCompletionBlock)(ZegoDocsViewError errorCode, BOOL fileCached);

@class ZegoDocsViewCustomH5Config;

@protocol ZegoDocsViewManagerDelegate <NSObject>

@optional
///The token expiration callback, and the file service token callback 30s before expiration
///@param remaintimeinsecond remaining time
- (void)onTokenWillExpire:(int)remainTimeInSecond;

@end

/// DocsView SDK management class
///
@interface ZegoDocsViewManager : NSObject

/// Set the maximum file magnification, which is 3 times by default. The range that can be set is [1,10]
@property (nonatomic, assign , readwrite) CGFloat docsViewMaxScaleFactor;

/// Initialize the ZegoDocsView SDK.
///
/// Perform the load, upload, and other operations after the initialization callback is successful.
///
/// @param config ZegoDocsView SDK configuration object. For more information about the parameters, see ZegoDocsViewConfig.h.
/// @param completionBlock Initialization result callback
- (void)initWithConfig:(ZegoDocsViewConfig *)config completionBlock:(ZegoDocsViewInitBlock)completionBlock;

///Initialize zegodocsview SDK (for roomkit)
///
///Please perform load, upload and other operations after the initialization callback is successful
///
///@ param config zegodocsview SDK configuration object, please query zegodocsviewconfig. H for specific parameters
///@ param completionblock initialization result callback
- (void)initWithConfig:(ZegoDocsViewConfig *)config roomKitToken:(NSString *)roomKitToken completionBlock:(ZegoDocsViewInitBlock)completionBlock;


/// Customize extended content.
///
/// Provide custom parameter settings in key-value pair format. For more information about supported keys and values, contact ZEGOCLOUD technical support.
/// Calling time: Call this API before the initWithConfig method.
///
/// @param value Customized extended content, such as the file domain name (@"xxxx.com").
/// @param key key Key of the custom extended content, such as the file domain name (@"domain").
///
/// @return Result of whether the setting is successful.
- (BOOL)setCustomizedConfig:(NSString *)value key:(NSString *)key;

/// Obtain the specified extended content based on the key value.
///
/// Custom parameter in key-value pair format. For more information about supported keys and values, contact ZEGOCLOUD technical support.
/// Calling time: Call this API after initWithConfig is successful.
///
/// @param key Key value of the extended content
///
/// @return Extended content corresponding to the key value.
- (NSString *)getCustomizedConfigWithKey:(NSString *)key;

/// Return the ZegoDocsViewManager singleton object.
///
/// @return Singleton object.
+ (instancetype)sharedInstance;

/// Set agent
/// @param delegate Agent
- (void)setDelegate:(id<ZegoDocsViewManagerDelegate>)delegate;

/// De-initialize the SDK.
///
/// Calling time: Call this API after initWithConfig is successful.
/// Note: This API needs to be used together with the init API.
- (void)uninit;

/// Calculate the size of the cache directory.
///
/// Calling time: Call this API after initWithConfig is successful.
///
/// @return Cache directory size, in bytes.
- (long)calculateCacheSize;

/// Clear the entire cache directory.
///
/// Call this method when caches need to be cleared. Loaded files can be cleared.
/// Calling time: Call this API after initWithConfig is successful.
- (void)clearCacheFolder;

/// Obtain the SDK version information.
///
//* @return Version information.
- (NSString *)getVersion;


/// Upload files to the ZegoDocs service.
///
/// During upload, the SDK converts the file format based on the introduced [renderType]. The rendering mode of the file after format conversion depends on the introduced [renderType]. You can obtain the upload progress in the result callback.
///
/// @param filePath Absolute path of the file to be uploaded. PPT, PDF, XLS, JPG, JPEG, PNG, BMP, and TXT files are supported. For more information, see https://doc-zh.zego.im/zh/6551.html.
/// @param renderType Rendering mode of the uploaded file after being transcoded. We recommend that you set it to ZegoDocsViewRenderTypeVector. For more information, see ZegoDocsViewConstants.
/// @param completionBlock Callback of the upload progress and result During file upload, you will receive multiple callbacks in [completionBlock]. For more information, see ZegoDocsViewUploadBlock.
///
/// @return Seq of the file upload request.
- (ZegoSeq)uploadFile:(NSString *)filePath renderType:(ZegoDocsViewRenderType)renderType completionBlock:(ZegoDocsViewUploadBlock)completionBlock;

/// Cancel the upload operation during file upload.
///
/// @param seq Upload task seq returned when uploadFile is called
/// @param completionBlock Callback of the file upload cancellation result
- (void)cancelUploadFileWithSeq:(ZegoSeq)seq completionBlock:(ZegoDocsViewCancelUploadComplementBlock)completionBlock;

/// Cache files to a local directory.
///
/// @param fileID ID of the file to be cached
/// @param completionBlock Callback of the file download progress and result
///
/// @return Seq of the file download operation.
- (ZegoSeq)cacheFileWithFileId:(NSString *)fileID completionBlock:(ZegoDocsViewCacheBlock)completionBlock;

/// Cancel the caching operation during file caching.
///
/// Call this method to cancel the caching operation when a file is being cached.
///
/// @param seq Seq of the caching operation
/// @param completionBlock Callback of the caching operation cancellation result
- (void)cancelCacheFileWithSeq:(ZegoSeq)seq completionBlock:(ZegoDocsViewCancelCacheComplementBlock)completionBlock;

/// Check whether a file is cached.
///
/// @param fileID ID of the file to be queried
/// @param completionBlock Query result callback
- (void)queryFileCachedWithFileId:(NSString *)fileID completionBlock:(ZegoDocsViewQueryCachedCompletionBlock)completionBlock;


/// Upload custom H5 courseware.
/// @param filePath File path
/// @param config Data related to custom H5 courseware
/// @param completionBlock Result callback
- (ZegoSeq)uploadH5File:(NSString *)filePath
                 config:(ZegoDocsViewCustomH5Config *)config
        completionBlock:(ZegoDocsViewUploadBlock)completionBlock;

/// Set authentication token
- (void)renewToken:(NSString *)token;
@end


NS_ASSUME_NONNULL_END

#endif

