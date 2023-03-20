#ifndef ZEGODOCSVIEWCONFIG_H
#define ZEGODOCSVIEWCONFIG_H 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// This configuration class is used to initialize the ZegoDocsView SDK.
///
@interface ZegoDocsViewConfig : NSObject

/// Required
/// Application ID that ZEGOCLOUD issues to developers. Apply it from the ZEGOCLOUD Admin Console. Value range: 0–4294967295
@property (nonatomic, assign) unsigned int appID;

/// Application signature of each App ID. Apply it from the ZEGOCLOUD Admin Console.
/// If the applied signature is a character string (for example, in "a3b4c5d6e7" format), set this character string to appSign. The SDK will automatically parse it.
/// If the applied signature is a byte array (for example, in 0xa3, 0xb4, 0xc5, 0xd6, 0xe7 format), convert appSign to a character string, such as "0xa3, 0xb4, 0xc5, 0xd6, 0xe7", and set the character string to appSign. The SDK will automatically parse it.
@property (nonatomic, copy) NSString *appSign;

/// SDK data storage directory.
/// Note: We recommend that you set it to [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZegoDocs"] stringByAppendingString:@""].
@property (nonatomic, copy) NSString *dataFolder;

/// SDK log storage directory, which records SDK running logs to facilitate issue locating.
/// The path needs to be consistent with the log path of the ZegoWhiteboardView SDK. Otherwise, logs cannot be uploaded.
/// Optional
/// Note: The default value is [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZegoLogFile"].
@property (nonatomic, copy) NSString *logFolder;

/// SDK cache storage directory. Files loaded by calling [loadFile] are cached in this directory and encrypted. You can call [clearCacheFolder] to clear the cached files.
/// We recommend that you set it to [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZegoDocs"].
@property (nonatomic, copy) NSString *cacheFolder;

/// Indicates whether the test environment is used. The default value is false (formal environment).
/// Files in different environments cannot interwork with each other.
/// Debug the features in the test environment first. After the testing is successful, contact ZEGOCLOUD technical support to release them in the formal environment.
/// This field is obsolete and no longer supported in 2.1.5 and later versions. 
@property (nonatomic, assign) BOOL isTestEnv DEPRECATED_ATTRIBUTE;

/// Authentication token
@property (nonatomic, copy) NSString *token;

/// User ID
@property (nonatomic, copy) NSString *userID;

@end

NS_ASSUME_NONNULL_END

#endif

