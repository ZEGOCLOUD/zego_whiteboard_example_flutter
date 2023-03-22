#import "ZegoSuperBoardPlugin.h"
#import <zego_superboard/ZegoSuperBoardEngineMethodHandler.h>
#import <zego_superboard/ZegoSuperBoardPlatformViewFactory.h>

@interface ZegoSuperBoardPlugin ()<FlutterStreamHandler>

@property (nonatomic, strong) id<FlutterPluginRegistrar> registrar;
@property (nonatomic, strong) FlutterEventSink eventSink;

@property (nonatomic, strong) FlutterEventChannel *eventChannel;
@property (nonatomic, strong) FlutterMethodChannel *methodChannel;

@end

@implementation ZegoSuperBoardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    ZegoSuperBoardPlugin* instance = [[ZegoSuperBoardPlugin alloc] init];
    instance.registrar = registrar;
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugins.zego.im/zego_superboard"
            binaryMessenger:[registrar messenger]];
    instance.methodChannel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
    
    
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"plugins.zego.im/zego_superboard_event_handler" binaryMessenger:[registrar messenger]];
    [eventChannel setStreamHandler:instance];
    instance.eventChannel = eventChannel;
    
    // Register platform view factory
    [registrar registerViewFactory:[ZegoSuperBoardPlatformViewFactory sharedInstance] withId:@"plugins.zego.im/zego_superboard_view"];
    
    
    
}

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    self.eventSink = events;
    return nil;
}

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    return nil;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *method = call.method;
    if ([method isEqualToString:@"init"]) {
        [[ZegoSuperBoardEngineMethodHandler sharedInstance]setRegistrar:_registrar eventSink:_eventSink];
    }
    [[ZegoSuperBoardEngineMethodHandler sharedInstance] handleMethodCall:call result:result];
    
    
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else if ([@"enableRemoteCursorVisible" isEqualToString:call.method]) {
//
//  }
//  else {
//    result(FlutterMethodNotImplemented);
//  }
}



@end
