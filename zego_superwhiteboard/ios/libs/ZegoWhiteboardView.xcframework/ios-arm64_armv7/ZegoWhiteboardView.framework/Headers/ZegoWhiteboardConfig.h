#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Whiteboard SDK configuration information
///
@interface ZegoWhiteboardConfig : NSObject

/// SDK log storage directory, which records SDK running logs to facilitate issue locating.
/// The path needs to be consistent with the log path of the ZegoExpressEngine SDK. Otherwise, logs cannot be uploaded.
/// The default value is [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZegoLogFile"].
@property (nonatomic, copy) NSString *logPath;

/// SDK file caching directory, which stores cached files, such as images, during SDK running.
/// The default value is [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZegoWhiteboardCache"].
@property (nonatomic, copy) NSString *cacheFolder;

@end

NS_ASSUME_NONNULL_END

