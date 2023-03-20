//
//  ZegoSuperBoardManager+WhiteBoard.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/8/2.
//

#import "ZegoSuperBoardManager.h"

NS_ASSUME_NONNULL_BEGIN

///Description: this class provides the function of setting custom fonts for whiteboard text.
///
///Business scenario: set the font style of whiteboard text.
///
@interface ZegoSuperBoardManager (WhiteBoard)

///Set custom new font
///
///Supported version: 2.0.0 and above.
///
///Description: you need to set a new custom font style for the text tool in the whiteboard.
///
///Business scenario: set custom new fonts.
///
///Call time: it needs to be called after the creation of a pure whiteboard or a file whiteboard.
///
///Note: only specific fonts are supported, and the font file provided by us needs to be built in the project. Please contact technical support to obtain the font file and the corresponding font name.
///
///@param regularFontName font name of regular font, please contact technical support for
///@param boldFontName bold font name, please contact technical support for
- (void)setCustomFontWithName:(NSString *)regularFontName boldFontName:(NSString *)boldFontName;

@end

NS_ASSUME_NONNULL_END

