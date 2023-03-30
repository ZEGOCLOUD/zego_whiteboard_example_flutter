//
//  ZegoExpressEngineEventHandler.m
//  zego_superwhiteboard
//
//  Created by zego on 2023/3/21.
//

#import "ZegoSuperBoardEngineEventHandler.h"
#import "NSObject+Conversion.h"

@implementation ZegoSuperBoardEngineEventHandler

+ (instancetype)sharedInstance {
    static ZegoSuperBoardEngineEventHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZegoSuperBoardEngineEventHandler alloc] init];
    });
    return instance;
}

- (void)onError:(ZegoSuperBoardError)error {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onError" forKey:@"method"];
        [params setObject:@(error) forKey:@"errorCode"];
        sink(params);
    }
}

- (void)onRemoteSuperBoardGraphicAuthChanged:(NSDictionary *)authInfo {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardGraphicAuthChanged" forKey:@"method"];
        [params setObject:authInfo forKey:@"authInfo"];
        sink(params);
    }
}

- (void)onRemoteSuperBoardSubViewAdded:(ZegoSuperBoardSubViewModel *)model {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSDictionary *modelDic = [NSObject dicFromObject:model];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardSubViewAdded" forKey:@"method"];
        [params setObject:modelDic forKey:@"subViewModel"];
        
    }
}

- (void)onRemoteSuperBoardSubViewRemoved:(ZegoSuperBoardSubViewModel *)model {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSDictionary *modelDic = [NSObject dicFromObject:model];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardSubViewRemoved" forKey:@"method"];
        [params setObject:modelDic forKey:@"subViewModel"];
        
    }
}

- (void)onRemoteSuperBoardSubViewSwitched:(NSString *)uniqueID {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardSubViewSwitched" forKey:@"method"];
        [params setObject:uniqueID forKey:@"uniqueID"];
        sink(params);
    }
}

- (void)onRemoteSuperBoardAuthChanged:(NSDictionary *)authInfo {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardAuthChanged" forKey:@"method"];
        [params setObject:authInfo forKey:@"authInfo"];
        sink(params);
    }
}

- (void)onScrollChange:(NSInteger) currentPage pageCount:(NSInteger) pageCount subViewModel:(ZegoSuperBoardSubViewModel *) subViewModel {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onSuperBoardSubViewScrollChanged" forKey:@"method"];
        [params setObject:@(currentPage) forKey:@"page"];
        [params setObject:subViewModel.uniqueID forKey:@"uniqueID"];
        sink(params);
    }
}

@end
