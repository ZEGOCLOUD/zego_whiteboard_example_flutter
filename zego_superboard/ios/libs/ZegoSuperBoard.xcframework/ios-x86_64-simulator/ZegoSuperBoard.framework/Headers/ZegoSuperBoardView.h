//
//  ZegoSuperBoardStage.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <UIKit/UIKit.h>
#import "ZegoSuperBoardDefine.h"
#import "ZegoSuperBoardSubView.h"

NS_ASSUME_NONNULL_BEGIN

/// Callback for the call result of [switchSuperBoardSubView] or [switcSuperBoardSubView:sheetIndex] in ZegoSuperBoardManager.
///
/// Supported version: 2.0.0 and above
///
/// Description: Call this callback to return the call result after the [switchSuperBoardSubView] or [switcSuperBoardSubView:sheetIndex] API of ZegoSuperBoardView is called.
///
/// Business scenario: After the [switchSuperBoardSubView] or [switcSuperBoardSubView:sheetIndex] API of ZegoSuperBoardView is called, determine whether the call is successful.
///
/// Callback time: Call this callback after the [switchSuperBoardSubView] or [switcSuperBoardSubView:sheetIndex] API is called and ZegoSuperBoardSubViewSwitchBlock is not set to nil.
///
/// Related APIs:  [switchExcelSheet] and [switcSuperBoardSubView:sheetIndex]
typedef void(^ZegoSuperBoardSwitchBlock)(ZegoSuperBoardError errorCode);

/// ZegoSuperBoardView event callback
///
@protocol ZegoSuperBoardViewDelegate <NSObject>

@optional

/// Callback for the page change.
///
/// Supported version: 2.0.0
///
/// Description: When the onScrollChange callback is received, the SDK has updated the page number of the whiteboard and file. This callback can be used to obtain the latest page number displayed on the UI.
///
/// Calling time/Notification time: This callback is triggered when scrolling or page turning is performed in a file or whiteboard.
///
/// @param currentPage Current page number after page change
/// @param pageCount Total number of pages
/// @param subViewModel subViewModel of the ZegoSuperBoardSubView object
- (void)onScrollChange:(NSInteger)currentPage pageCount:(NSInteger)pageCount subViewModel:(ZegoSuperBoardSubViewModel *)subViewModel;

/// Callback for the page size change.
///
/// Supported version: 2.0.0
///
/// Description: When the onSizeChange callback is received, the SDK has updated the size of the whiteboard and file. This callback can be used to obtain the visible area size of the current SuperBoardSubView.
///
/// Calling time/Notification time: This callback is triggered when the size of the ZegoSuperBoardSubView is modified.
///
/// @param size Size of the SuperBoardSubView visible area
/// @param subViewModel subViewModel of the ZegoSuperBoardSubView object
- (void)onSizeChange:(CGSize)size subViewModel:(ZegoSuperBoardSubViewModel *)subViewModel;

- (void)onStepChange;

@end

/// Description: This class implements how to switch between different SuperBoardSubView objects and sheets of an Excel file in a SuperBoardSubView object. After the SDK is initialized, you can use ZegoSuperBoardManager to obtain the ZegoSuperBoardView object. Through this class, you do not need to process the switching, synchronization, or other logic of ZegoSuperBoardView, which will be handled inside ZegoSuperBoardView.
///
/// Business scenario: Simplify SDK integration and do not want to handle too much logic for ZegoSuperBoardView switching.
///
/// Note: To use ZegoSuperBoardView, you need to enable enableSuperBoardView, which is enabled by default. If it is disabled, ZegoSuperBoardView cannot be used. In ZegoSuperBoardView mode, do not use ZegoSuperBoardSubView simultaneously.
///
@interface ZegoSuperBoardView : UIView

/// SuperBoardSubView to be displayed on the top layer of the current view.
@property (nonatomic,strong,readonly) ZegoSuperBoardSubView *currentSuperBoardSubView;

/// ZegoSuperBoardView agent.
@property (nonatomic,weak) id<ZegoSuperBoardViewDelegate> delegate;

/// Switch to the specified SuperBoardSubView.
///
/// Supported version: 2.0.0 and above
///
/// Description: Switch to the specified SuperBoardSubView on multiple clients.
///
/// Related callbacks: ZegoSuperBoardSwitchBlock
///
/// @param uniqueID Unique ID of SuperBoardSubView
/// @param complete Callback of the SuperBoardSubView switching result
- (void)switchSuperBoardSubView:(NSString *)uniqueID complete:(ZegoSuperBoardSwitchBlock)complete;

/// Switch the specified SuperBoardSubView to the specified sheet.
///
/// Supported version: 2.0.0 and above
///
/// Description: Switch to the specified sheet of an Excel file in SuperBoardSubView.
///
/// Business scenario: Switch between sheets of an Excel file.
///
/// Calling time: Call this API after the file is loaded.
///
/// Use restriction: Only Excel files are supported.
///
/// @param uniqueID Unique ID of SuperBoardSubView
/// @param sheetIndex Index of a sheet in the Excel file
/// @param complete Callback of the Excel sheet switching result
- (void)switcSuperBoardSubView:(NSString *)uniqueID sheetIndex:(int)sheetIndex complete:(ZegoSuperBoardSwitchBlock)complete;

/// Switch to the specified SuperBoardSubView.
///
/// Supported version: 2.1.1 and above
///
/// Description: Switch to the specified SuperBoardSubView only on the local client. To synchronize this operation to remote clients, implement it yourself or use switchSuperBoardSubView.
///
/// Related callbacks: ZegoSuperBoardSwitchBlock
///
/// @param whiteboarID Whiteboard ID of the SuperBoardSubView
/// @param complete Callback of the SuperBoardSubView switching result
- (void)switchSuperBoardSubViewWithWhiteboarID:(NSString *)whiteboarID complete:(ZegoSuperBoardSwitchBlock)complete;


/// Switch the specified SuperBoardSubView to the specified sheet.
///
/// Supported version: 2.1.1 and above
///
/// Description: Switch to the specified sheet of an Excel file in SuperBoardSubView.
///
/// Description: Switch to the specified sheet of an Excel file only on the local client. To synchronize this operation to remote clients, implement it yourself or use switchSuperBoardSubView:sheetIndex.
///
/// Calling time: Call this API after the file is loaded.
///
/// Use restriction: Only Excel files are supported.
///
/// @param whiteboarID Whiteboard ID of the SuperBoardSubView
/// @param sheetIndex Index of a sheet in the Excel file
/// @param complete Callback of the Excel sheet switching result
- (void)switchSuperBoardSubViewWithWhiteboarID:(NSString *)whiteboarID sheetIndex:(int)sheetIndex complete:(ZegoSuperBoardSwitchBlock)complete;
@end

NS_ASSUME_NONNULL_END

