//
//  ZegoExpressEngineMethodHandler.m
//  zego_superwhiteboard
//
//  Created by zego on 2023/3/21.
//

#import "ZegoSuperBoardEngineMethodHandler.h"
#import "ZegoSuperBoardEngineEventHandler.h"
#import <ZegoSuperBoard/ZegoSuperBoard.h>
#import "NSObject+Conversion.h"

@interface ZegoSuperBoardEngineMethodHandler ()

@property (nonatomic, strong) id<FlutterPluginRegistrar> registrar;

@end

@implementation ZegoSuperBoardEngineMethodHandler

+ (instancetype)sharedInstance {
    static ZegoSuperBoardEngineMethodHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZegoSuperBoardEngineMethodHandler alloc] init];
    });
    return instance;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:result:", call.method]);

    // Handle unrecognized method
    if (![self respondsToSelector:selector]) {
        result(FlutterMethodNotImplemented);
        return;
    }

    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];

    invocation.target = self;
    invocation.selector = selector;
    [invocation setArgument:&call atIndex:2];
    [invocation setArgument:&result atIndex:3];
    [invocation invoke];
}


- (void)setRegistrar:(id<FlutterPluginRegistrar>)registrar eventSink:(FlutterEventSink)sink {
    _registrar = registrar;
    // Set eventSink for ZegoExpressEngineEventHandler
    [ZegoSuperBoardEngineEventHandler sharedInstance].eventSink = sink;
}


- (void)init:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    [[ZegoSuperBoardManager sharedInstance]setDelegate:[ZegoSuperBoardEngineEventHandler sharedInstance]];
    
    NSDictionary *arguments = call.arguments;
    NSDictionary *configDic = arguments[@"config"];
    long appID = [configDic[@"appID"]longValue];
    NSString *appSign = configDic[@"appSign"];
    NSString *token;
    if (configDic[@"token"]) {
        token = configDic[@"token"];
    }
    NSString *userID = configDic[@"userID"];
    
    ZegoSuperBoardInitConfig *config = [ZegoSuperBoardInitConfig new];
    config.appID = appID;
    config.appSign = appSign;
    //config.token = token;
    config.userID = userID;
    [[ZegoSuperBoardManager sharedInstance]initWithConfig:config complete:^(ZegoSuperBoardError errorCode) {
        NSDictionary *params = @{@"errorCode": @(errorCode)};
        result(params);
    }];
    
}

- (void)uninit:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance]unInit];
    result(nil);
}

- (void)getSDKVersion:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *version = [[ZegoSuperBoardManager sharedInstance]getSDKVersion];
    result(version);
}

- (void)enableRemoteCursorVisible:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    BOOL visable = [arguments[@"visable"] boolValue];
    [[ZegoSuperBoardManager sharedInstance]setEnableRemoteCursorVisible:visable];
    result(nil);
}

- (void)clear:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance]clear];
    result(nil);
}

- (void)renewToken:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *token = arguments[@"token"];
    [[ZegoSuperBoardManager sharedInstance]renewToken:token];
    result(nil);
}

- (void)clearCache:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance]clearCache];
    result(nil);
}

- (void)isCustomCursorEnabled:(FlutterMethodCall *)call result:(FlutterResult)result {
    BOOL enable = [[ZegoSuperBoardManager sharedInstance]enableCustomCursor];
    result(@(enable));
}

- (void)isEnableResponseScale:(FlutterMethodCall *)call result:(FlutterResult)result {
    BOOL enable = [[ZegoSuperBoardManager sharedInstance]enableResponseScale];
    result(@(enable));
}

- (void)isEnableSyncScale:(FlutterMethodCall *)call result:(FlutterResult)result {
    BOOL enable = [[ZegoSuperBoardManager sharedInstance]enableSyncScale];
    result(@(enable));
}

- (void)isRemoteCursorVisibleEnabled:(FlutterMethodCall *)call result:(FlutterResult)result {
    BOOL enable = [[ZegoSuperBoardManager sharedInstance]enableRemoteCursorVisible];
    result(@(enable));
}

- (void)setCustomizedConfig:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *key = arguments[@"key"];
    NSString *value = arguments[@"value"];
    [[ZegoSuperBoardManager sharedInstance]setCustomizedConfig:value key:key];
    result(nil);
}

- (void)createWhiteboardView:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSDictionary *configDic = arguments[@"config"];
    
    ZegoCreateWhiteboardConfig *config = [[ZegoCreateWhiteboardConfig alloc]init];
    config.name = configDic[@"name"];
    config.perPageWidth = [configDic[@"perPageWidth"]integerValue];
    config.perPageHeight = [configDic[@"perPageHeight"]integerValue];
    config.pageCount = [configDic[@"pageCount"]integerValue];
    
    [[ZegoSuperBoardManager sharedInstance]createWhiteboardView:config complete:^(ZegoSuperBoardError errorCode, ZegoSuperBoardSubViewModel * _Nonnull model) {
        NSDictionary *params = @{@"errorCode": @(errorCode), @"subViewModel": [NSObject dicFromObject:model]};
        result(params);
    }];
}

- (void)createFileView:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSDictionary *configDic = arguments[@"config"];
    ZegoCreateFileConfig *config = [ZegoCreateFileConfig new];
    config.fileID = configDic[@"fileID"];
    [[ZegoSuperBoardManager sharedInstance]createFileView:config complete:^(ZegoSuperBoardError errorCode, ZegoSuperBoardSubViewModel * _Nonnull model) {
        NSDictionary *params = @{@"errorCode": @(errorCode), @"subViewModel": [NSObject dicFromObject:model]};
        result(params);
    }];
}

- (void)destroySuperBoardSubView:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *uniqueID = arguments[@"uniqueID"];
    [[ZegoSuperBoardManager sharedInstance]destroySuperBoardSubView:uniqueID complete:^(ZegoSuperBoardError errorCode) {
        NSDictionary *params = @{@"errorCode": @(errorCode)};
        result(params);
    }];
    
}

- (void)querySuperBoardSubViewList:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance]querySuperBoardSubViewList:^(ZegoSuperBoardError errorCode, NSArray<ZegoSuperBoardSubViewModel *> * _Nonnull superBoardViewList) {
        NSMutableArray *array = [NSMutableArray array];
        for (ZegoSuperBoardSubViewModel *model in superBoardViewList) {
            [array addObject:[NSObject dicFromObject:model]];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(errorCode) forKey:@"errorCode"];
        [params setObject:array forKey:@"subViewModelList"];
        [params setObject:@{} forKey:@"extraInfo"];
        result(params);
    }];
}

- (void)switchSuperBoardSubView:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *uniqueID = arguments[@"uniqueID"];
    if ([[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView.model.uniqueID isEqualToString:uniqueID]) {
        NSDictionary *params = @{@"errorCode":@(0)};
        result(params);
        return;
    }
    [[ZegoSuperBoardManager sharedInstance].superBoardView switchSuperBoardSubView:uniqueID complete:^(ZegoSuperBoardError errorCode) {
        NSDictionary *params = @{@"errorCode":@(errorCode)};
        result(params);
    }];
}

- (void)switchSuperBoardSubExcelView:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *uniqueID = arguments[@"uniqueID"];
    int index = [arguments[@"sheetIndex"]intValue];
    [[ZegoSuperBoardManager sharedInstance].superBoardView switcSuperBoardSubView:uniqueID sheetIndex:index complete:^(ZegoSuperBoardError errorCode) {
        NSDictionary *params = @{@"errorCode":@(errorCode)};
        result(params);
    }];
}

- (void)getSuperBoardSubViewModelList:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSMutableArray *subViewModelListDic = [NSMutableArray array];
    for (ZegoSuperBoardSubViewModel * model in [ZegoSuperBoardManager sharedInstance].superBoardSubViewModelList) {
        [subViewModelListDic addObject:[NSObject dicFromObject:model]];
    }
    result(subViewModelListDic);
}

- (void)enableSyncScale:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    BOOL enable = arguments[@"enable"];
    [[ZegoSuperBoardManager sharedInstance]setEnableSyncScale:enable];
    result(nil);
}

- (void)enableResponseScale:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    BOOL enable = arguments[@"enable"];
    [[ZegoSuperBoardManager sharedInstance]setEnableResponseScale:enable];
    result(nil);
}

- (void)setToolType:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    ZegoSuperBoardTool tool = [arguments[@"tool"]integerValue];
    [[ZegoSuperBoardManager sharedInstance]setToolType:tool];
    result(nil);
}

- (void)getToolType:(FlutterMethodCall *)call result:(FlutterResult)result {
    ZegoSuperBoardTool tool = [ZegoSuperBoardManager sharedInstance].toolType;
    result(@(tool));
}

- (void)setFontBold:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    BOOL bold = [arguments[@"bold"]boolValue];
    [[ZegoSuperBoardManager sharedInstance]setIsFontBold:bold];
    result(nil);
}

- (void)isFontBold:(FlutterMethodCall *)call result:(FlutterResult)result {
    BOOL isFontBold = [ZegoSuperBoardManager sharedInstance].isFontBold;
    result(@(isFontBold));
}

- (void)isFontItalic:(FlutterMethodCall *)call result:(FlutterResult)result {
    BOOL isFontItalic = [ZegoSuperBoardManager sharedInstance].isFontItalic;
    result(@(isFontItalic));
}

- (void)setFontSize:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSUInteger size = [arguments[@"size"]intValue];
    [[ZegoSuperBoardManager sharedInstance]setFontSize:size];
    result(nil);
}

- (void)getFontSize:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSUInteger size = [ZegoSuperBoardManager sharedInstance].fontSize;
    result(@(size));
}

- (void)setBrushSize:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSInteger size = [arguments[@"size"]intValue];
    [[ZegoSuperBoardManager sharedInstance]setBrushSize:size];
    result(nil);
}

- (void)setBrushColor:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *color = arguments[@"color"];
    [[ZegoSuperBoardManager sharedInstance]setBrushColor:[self colorWithHexString:color]];
    result(nil);
}

- (void)getBrushColor:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIColor *color = [ZegoSuperBoardManager sharedInstance].brushColor;
    result([self hexadecimalFromUIColor:color]);
}

- (void)getThumbnailUrlList:(FlutterMethodCall *)call result:(FlutterResult)result {
    result([[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView getThumbnailUrlList]);
}

- (void)getModel:(FlutterMethodCall *)call result:(FlutterResult)result {
    result([NSObject dicFromObject:[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView.model]);
}

- (void)inputText:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView addTextEditWithComplete:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)addText:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *text = arguments[@"text"];
    int positionX = [arguments[@"positionX"]intValue];
    int positionY = [arguments[@"positionY"]intValue];
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView addText:text positionX:positionX positionY:positionY complete:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)undo:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView undo];
    result(nil);
}

- (void)redo:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView redo];
    result(nil);
}

- (void)clearCurrentPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView clearCurrentPage:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)clearAllPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView clearAllPage:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)setOperationMode:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSInteger modelValue = [arguments[@"mode"]intValue];
    ZegoSuperBoardOperationMode operationModel = ZegoSuperBoardOperationModeNone;
    if (modelValue == 1) {
        operationModel = ZegoSuperBoardOperationModeNone;
    } else if (modelValue == 2) {
        operationModel = ZegoSuperBoardOperationModeDraw;
    } else if (modelValue == 4) {
        operationModel = ZegoSuperBoardOperationModeScroll;
    } else if (modelValue == 8) {
        operationModel = ZegoSuperBoardOperationModeZoom;
    }
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView setOperationMode:operationModel];
}

- (void)flipToPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    int page = [arguments[@"page"]intValue];
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView flipToPage:page complete:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)flipToPrePage:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView flipToPrePage:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)flipToNextPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView flipToNextPage:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)getCurrentPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    result(@([ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView.currentPage));
}

- (void)getPageCount:(FlutterMethodCall *)call result:(FlutterResult)result {
    result(@([ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView.pageCount));
}

- (void)getVisibleSize:(FlutterMethodCall *)call result:(FlutterResult)result {
    CGSize size = [ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView.visibleSize;
    NSDictionary *params = @{@"width": @(size.width), @"height": @(size.height)};
    result(params);
}

- (void)clearSelected:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView clearSelected:^(ZegoSuperBoardError errorCode) {
        result(@{@"errorCode": @(errorCode)});
    }];
}

- (void)setWhiteboardBackgroundColor:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *color = arguments[@"color"];
    [[ZegoSuperBoardManager sharedInstance].superBoardView.currentSuperBoardSubView setWhiteboardBackgroundColor:[self colorWithHexString:color]];
    result(nil);
}

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    //r
    NSString *rString = [cString substringWithRange:range];

    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


- (NSString *)hexadecimalFromUIColor:(UIColor*)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    return [NSString stringWithFormat:@"%02lX%02lX%02lX",
             lroundf(r * 255),
             lroundf(g * 255),
             lroundf(b * 255)];
}

@end
