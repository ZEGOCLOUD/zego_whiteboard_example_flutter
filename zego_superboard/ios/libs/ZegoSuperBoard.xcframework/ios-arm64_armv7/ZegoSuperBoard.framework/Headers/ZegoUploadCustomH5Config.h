//
//  ZegoUploadCustomH5Config.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Description: This class is used to construct custom H5 courseware attributes, such as the width, height, number of pages, and thumbnail information.
///
/// Business scenario: The API for uploading custom H5 courseware is called.
///
@interface ZegoUploadCustomH5Config : NSObject

/// Description: Width of the custom H5 courseware.
///
/// Required: Yes
///
/// Valid values: values greater than 0
///
/// Supported version: 2.0.0
@property (nonatomic, assign) CGFloat width;

/// Description: Height of the custom H5 courseware.
///
/// Required: Yes
///
/// Valid values: values greater than 0
///
/// Supported version: 2.0.0
@property (nonatomic, assign) CGFloat height;

/// Description: Number of pages of the custom H5 courseware.
///
/// Required: Yes
///
/// Valid values: values greater than 0
///
/// Supported version: 2.0.0
@property (nonatomic, assign) NSInteger pageCount;

/// Description:  Relative path array of the custom H5 courseware thumbnail.
///
/// Required: No
///
/// Supported version: 2.0.0
@property (nonatomic, strong) NSArray<NSString *> *thumbnailList;

@end

NS_ASSUME_NONNULL_END

