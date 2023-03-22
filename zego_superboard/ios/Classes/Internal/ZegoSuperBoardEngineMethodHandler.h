//
//  ZegoExpressEngineMethodHandler.h
//  zego_superwhiteboard
//
//  Created by zego on 2023/3/21.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZegoSuperBoardEngineMethodHandler : NSObject

+ (instancetype)sharedInstance;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;

- (void)setRegistrar:(id<FlutterPluginRegistrar>)registrar eventSink:(FlutterEventSink)sink;

@end

NS_ASSUME_NONNULL_END
