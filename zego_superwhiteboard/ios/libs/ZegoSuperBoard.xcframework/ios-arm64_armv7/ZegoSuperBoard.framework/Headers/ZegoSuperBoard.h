//
//  ZegoSuperBoard.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/21.
//

/// Introduce common header files of the ZegoSuperBoard SDK.
///
/// Common header files of the ZegoSuperBoard SDK are introduced in a unified manner.
///

#import <Foundation/Foundation.h>

//! Project version number for ZegoSuperBoard.
FOUNDATION_EXPORT double ZegoSuperBoardVersionNumber;

//! Project version string for ZegoSuperBoard.
FOUNDATION_EXPORT const unsigned char ZegoSuperBoardVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZegoSuperBoard/PublicHeader.h>

#import "ZegoSuperBoardManager.h"
#import "ZegoSuperBoardDefine.h"
#import "ZegoSuperBoardSubViewModel.h"

#import "ZegoSuperBoardView.h"
#import "ZegoSuperBoardSubView.h"

#import "ZegoCreateFileConfig.h"
#import "ZegoCreateWhiteboardConfig.h"
#import "ZegoSuperBoardInitConfig.h"
#import "ZegoUploadCustomH5Config.h"

#import "ZegoSuperBoardManager+WhiteBoard.h"
#import "ZegoSuperBoardManager+File.h"

