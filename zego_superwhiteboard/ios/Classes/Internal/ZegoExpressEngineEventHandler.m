//
//  ZegoExpressEngineEventHandler.m
//  zego_superwhiteboard
//
//  Created by zego on 2023/3/21.
//

#import "ZegoExpressEngineEventHandler.h"
#import "NSObject+Conversion.h"

@implementation ZegoExpressEngineEventHandler

+ (instancetype)sharedInstance {
    static ZegoExpressEngineEventHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZegoExpressEngineEventHandler alloc] init];
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
        NSString *extendedDataJsonString = @"{}";
        if (authInfo) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:authInfo options:0 error:&error];
            if (jsonData) {
                extendedDataJsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardGraphicAuthChanged" forKey:@"method"];
        [params setObject:extendedDataJsonString forKey:@"authInfo"];
        sink(params);
    }
}

- (void)onRemoteSuperBoardSubViewAdded:(ZegoSuperBoardSubViewModel *)model {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSDictionary *modelDic = [NSObject dicFromObject:model];
        NSString *extendedDataJsonString = @"{}";
        if (modelDic) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelDic options:0 error:&error];
            if (jsonData) {
                extendedDataJsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardSubViewAdded" forKey:@"method"];
        [params setObject:extendedDataJsonString forKey:@"subViewModel"];
        
    }
}

- (void)onRemoteSuperBoardSubViewRemoved:(ZegoSuperBoardSubViewModel *)model {
    FlutterEventSink sink = _eventSink;
    if (sink) {
        NSDictionary *modelDic = [NSObject dicFromObject:model];
        NSString *extendedDataJsonString = @"{}";
        if (modelDic) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelDic options:0 error:&error];
            if (jsonData) {
                extendedDataJsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardSubViewRemoved" forKey:@"method"];
        [params setObject:extendedDataJsonString forKey:@"subViewModel"];
        
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
        NSString *extendedDataJsonString = @"{}";
        if (authInfo) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:authInfo options:0 error:&error];
            if (jsonData) {
                extendedDataJsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"onRemoteSuperBoardAuthChanged" forKey:@"method"];
        [params setObject:extendedDataJsonString forKey:@"authInfo"];
        sink(params);
    }
}

@end
