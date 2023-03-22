//
//  ZegoPlatformViewFactory.m
//  Pods-Runner
//
//  Created by lizhanpeng@ZEGO on 2020/3/26.
//  Copyright © 2020 Zego. All rights reserved.
//

#import "ZegoSuperBoardPlatformViewFactory.h"

@interface ZegoSuperBoardPlatformViewFactory()

@property (nonatomic, strong) NSMutableDictionary<NSNumber*, ZegoSuperBoardPlatformView*> *platformViewMap;

@end

@implementation ZegoSuperBoardPlatformViewFactory

+ (instancetype)sharedInstance {
    static ZegoSuperBoardPlatformViewFactory *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZegoSuperBoardPlatformViewFactory alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _platformViewMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)destroyPlatformView:(NSNumber *)viewID {

    ZegoSuperBoardPlatformView *platformView = self.platformViewMap[viewID];

    if (!platformView) {
        [self logCurrentPlatformViews];
        return NO;
    }

    [self.platformViewMap removeObjectForKey:viewID];

    [self logCurrentPlatformViews];

    return YES;
}

- (nullable ZegoSuperBoardPlatformView *)getPlatformView:(NSNumber *)viewID {

    [self logCurrentPlatformViews];
    
    return [self.platformViewMap objectForKey:viewID];
}

- (void)addPlatformView:(ZegoSuperBoardPlatformView *)view viewID:(NSNumber *)viewID {

    [self.platformViewMap setObject:view forKey:viewID];

    [self logCurrentPlatformViews];
}

- (void)logCurrentPlatformViews {
    NSMutableString *desc = [[NSMutableString alloc] init];
    for (NSNumber *i in self.platformViewMap) {
        ZegoSuperBoardPlatformView *eachPlatformView = self.platformViewMap[i];
        if (eachPlatformView) {
            [desc appendFormat:@"[ID:%d|View:%p] ", i.intValue, eachPlatformView.view];
        }
    }
}

#pragma mark FlutterPlatformViewFactory Delegate

#if TARGET_OS_IPHONE
/// Called when dart invoke `createPlatformView`, that is, when Widget `UiKitView` is added to the flutter render tree
- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    
    ZegoSuperBoardPlatformView *view = [[ZegoSuperBoardPlatformView alloc] initWithRect:frame viewID:viewId];
    [self addPlatformView:view viewID:@(viewId)];
    
    return view;
}

#elif TARGET_OS_OSX

- (nonnull NSView *)createWithViewIdentifier:(int64_t)viewId arguments:(nullable id)args {
    ZegoPlatformView *view = [[ZegoPlatformView alloc] initWithRect:CGRectZero viewID:viewId];
    [self addPlatformView:view viewID:@(viewId)];
    
    return view.view;
}

#endif

@end
