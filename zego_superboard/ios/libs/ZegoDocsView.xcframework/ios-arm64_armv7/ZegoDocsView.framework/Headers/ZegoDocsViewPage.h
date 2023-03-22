#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

/// File page-related information
///
@interface ZegoDocsViewPage : NSObject

/// Size of the file page and the start position of the current page.
@property (nonatomic, assign) CGRect rect;

@end

NS_ASSUME_NONNULL_END

