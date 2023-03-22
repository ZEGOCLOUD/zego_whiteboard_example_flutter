//
//  ZegoSuperBoardFileWhiteboardCreateConfig.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Description: This API parameter construction class is used to introduce parameters required for creating a file.
///
/// Business scenario: The [createFileView] API is called.
///
@interface ZegoCreateFileConfig : NSObject

/// Description: ID of the file.
///
/// Required: Yes
///
/// Supported version: 2.0.0
@property (nonatomic,copy) NSString *fileID;

@end

NS_ASSUME_NONNULL_END

