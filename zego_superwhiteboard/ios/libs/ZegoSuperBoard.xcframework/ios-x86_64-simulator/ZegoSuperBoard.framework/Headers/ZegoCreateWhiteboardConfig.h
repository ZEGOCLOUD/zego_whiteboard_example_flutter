//
//  ZegoPureWhiteboardCreateConfig.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Description: This API parameter construction class is used to introduce parameters required for creating a whiteboard.
///
/// Business scenario: The createWhiteboardView API is called.
///
@interface ZegoCreateWhiteboardConfig : NSObject

/// Description: Set the whiteboard name to create a whiteboard.
///
/// Required: Yes
///
/// Value range: a string of up to 128 bytes and can contain both Chinese and English characters
///
/// Supported version: 2.0.0
@property (nonatomic,copy) NSString *name;

/// Description: Width of each whiteboard page.
///
/// Required: Yes
///
/// Valid values: values greater than 0
///
/// Supported version: 2.0.0
@property (nonatomic,assign) NSInteger perPageWidth;

/// Description: Height of each whiteboard page.
///
/// Required: Yes
///
/// Valid values: values greater than 0
///
/// Supported version: 2.0.0
@property (nonatomic,assign) NSInteger perPageHeight;

/// Description: Total number of pages.
///
/// Required: Yes。
///
/// Valid values: values greater than 0
///
/// Supported version: 2.0.0
@property (nonatomic,assign) NSInteger pageCount;

@end

NS_ASSUME_NONNULL_END

