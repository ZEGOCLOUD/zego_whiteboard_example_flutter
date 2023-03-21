//
//  ZegoExpressEngineEventHandler.h
//  zego_superwhiteboard
//
//  Created by zego on 2023/3/21.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <ZegoSuperBoard/ZegoSuperBoard.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngineEventHandler : NSObject<ZegoSuperBoardManagerDelegate>

+ (instancetype)sharedInstance;

@property (nonatomic, strong, nullable) FlutterEventSink eventSink;

@end

NS_ASSUME_NONNULL_END
