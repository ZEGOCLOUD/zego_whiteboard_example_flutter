//
//  ZegoSuperBoardInitConfig.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Description: This API parameter construction class is used to construct parameters required for initializing the SDK.
///
/// Business scenario: The initWithConfig API is called.
///
@interface ZegoSuperBoardInitConfig : NSObject

/// Description: Application ID that ZEGOCLOUD issues to developers. Apply it from the ZEGOCLOUD Admin Console.
///
/// Required: Yes
///
/// Value range: 0–4294967295
@property (nonatomic,assign) long appID;

/// Description: Application signature of each App ID. Apply it from the ZEGOCLOUD Admin Console.
/// If the applied signature is a character string (for example, in "a3b4c5d6e7" format), set this character string to appSign. The SDK will automatically parse it.
/// If the applied signature is a byte array (for example, in 0xa3, 0xb4, 0xc5, 0xd6, 0xe7 format), convert appSign to a character string, such as "0xa3, 0xb4, 0xc5, 0xd6, 0xe7", and set the character string to appSign. The SDK will automatically parse it.
///
/// Required: No
@property (nonatomic, copy) NSString *appSign;

/// Description: Indicates whether the test environment is used. The default value is false (formal environment). Files and whiteboards in different environments cannot interwork with each other. Debug the features in the test environment first. If the testing is successful, contact ZEGOCLOUD technical support to release them in the formal environment.
///
/// Required: No 
@property (nonatomic,assign) BOOL isTestEnv;

/// Token authentication
///
/// Required: Yes
@property (nonatomic,copy) NSString *token;

/// User ID
/// Required: Yes
@property (nonatomic, copy) NSString *userID;

@end

NS_ASSUME_NONNULL_END

