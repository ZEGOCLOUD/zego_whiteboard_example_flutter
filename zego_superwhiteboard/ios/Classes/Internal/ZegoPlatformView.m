//
//  ZegoPlatformView.m
//  Pods-Runner
//
//  Created by lizhanpeng@ZEGO on 2020/3/26.
//  Copyright © 2020 Zego. All rights reserved.
//

#import "ZegoPlatformView.h"

@interface ZegoPlatformView()

@property (nonatomic, strong, readwrite) ZegoSuperBoardView *view;
@property (nonatomic, assign) int64_t viewID;

@end

@implementation ZegoPlatformView

- (instancetype)initWithRect:(CGRect)rect viewID:(int64_t)viewID {
    self = [super init];
    if (self) {
#if TARGET_OS_IPHONE
        _view = [[UIView alloc] initWithFrame:rect];
        _view.backgroundColor = [UIColor blackColor];
#elif TARGET_OS_OSX
        _view = [[NSView alloc] initWithFrame:rect];
        _view.wantsLayer = YES;
        _view.layer.backgroundColor = [NSColor blackColor].CGColor;
#endif
        _viewID = viewID;
    }
    
    return self;
}

- (void)dealloc {
    
}

# pragma mark - Flutter Platform View Delegate

- (ZegoSuperBoardView *)view {
    return [ZegoSuperBoardManager sharedInstance].superBoardView;
}


@end
