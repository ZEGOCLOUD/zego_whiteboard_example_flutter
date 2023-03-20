//
//  ZegoDocsViewCustomH5Config.h
//  ZegoDocsView
//
//  Created by zego on 2021/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// This configuration class is used to set parameters for uploading custom H5 courseware.
///
@interface ZegoDocsViewCustomH5Config : NSObject

/// Width of the custom courseware.
@property (nonatomic, assign) CGFloat width;

/// Height of the custom courseware.
@property (nonatomic, assign) CGFloat height;

/// Number of pages of the custom courseware.
@property (nonatomic, assign) NSInteger pageCount;

/// Relative path array of the custom H5 courseware thumbnail.
@property (nonatomic, strong) NSArray<NSString *> *thumbnailList;

@end

NS_ASSUME_NONNULL_END
