#import <UIKit/UIKit.h>
#import "ZegoWhiteboardDefine.h"

NS_ASSUME_NONNULL_BEGIN

/// File information associated with the whiteboard.
///
/// Describe the data structure of the file.
///
/// Note: If the whiteboard SDK is used together with file transcoding SDK, set this model to ZegoWhiteboardViewModel to synchronize file information.
///
/// Note: The number of pages, number of steps, and other information of the file are synchronized through horizontalScrollPercent and pptStep in ZegoWhiteboardViewModel.
///
@interface ZegoFileInfoModel : NSObject

/// Unique file ID.
/// Note: The file ID is the ID that is obtained after the file transcoding is successful.
@property (nonatomic, strong) NSString *fileID;

/// File name.
@property (nonatomic, strong) NSString *fileName;

/// File type. For more information, see the file types defined in the ZegoDocsView SDK.
@property (nonatomic, assign) NSUInteger fileType;

/// Authorization code.
@property (nonatomic, strong) NSString *authKey;

@end

/// Whiteboard information.
///
/// Describe the data structure of the whiteboard to initialize ZegoWhiteboardView and synchronize related information to remote clients.
/// Note:  pptStep is only used to synchronize the animation step information of PPT files when the whiteboard SDK is used together with the file transcoding SDK.
/// Example: To create a whiteboard with five pages and the aspect ratio of 16:9, set related parameters as follows:
/// ZegoWhiteboardViewModel model
/// model.aspectWidth = 16.0 * 5
/// model.aspectHeight = 9.0
/// model.pageCount = 5
/// model.name = "Whiteboard name"
///
@interface ZegoWhiteboardViewModel : NSObject

/// ID of the room to which the whiteboard belongs.
@property (nonatomic, copy) NSString *roomID;

/// Unique whiteboard ID.
@property (nonatomic, assign) ZegoWhiteboardID whiteboardID;

/// Whiteboard name, which is a string of up to 128 bytes and can contain both Chinese and English characters.
@property (nonatomic, copy) NSString *name;

/// Width coefficient of the whiteboard content, which is not an absolute value. On different clients with different view sizes, the aspect ratio of the whiteboard content must be the same.
/// Note: This field is used together with the aspectHeight field. The ratio of these two fields determines the aspect ratio of the whiteboard content.
@property (nonatomic, assign) CGFloat aspectWidth;

/// Height of the whiteboard content. On different clients with different view sizes, the aspect ratio of the whiteboard content must be the same.
@property (nonatomic, assign) CGFloat aspectHeight;

//@property (nonatomic, assign) CGFloat aspectWidth_viewPortStub;
//@property (nonatomic, assign) CGFloat aspectHeight_viewPortStub;

/// Horizontal scrolling percentage. The value range is from 0 to 1.0. 0 indicates no offset, and 1 indicates the maximum offset.
@property (nonatomic, assign) CGFloat horizontalScrollPercent;

/// Vertical scrolling percentage. The value range is from 0 to 1.0. 0 indicates no offset, and 1 indicates the maximum offset.
/// Note: When the whiteboard SDK is used together with the file transcoding SDK, this parameter can be used to synchronize the number of pages, offset, and other information of a file.
@property (nonatomic, assign) CGFloat verticalScrollPercent;

/// Animation step of an animated PPT file, which starts from 1.
/// Note: When the whiteboard SDK is used together with the file transcoding SDK, this parameter can be used to synchronize the animation steps of animated PPT files.
@property (nonatomic, assign) NSUInteger pptStep;

/// Total number of pages of a whiteboard, which is determined by the caller, and the SDK does not perform any operations.
@property (nonatomic, assign) NSUInteger pageCount;

/// Information of the transcoded file associated with the whiteboard. Generally, the whiteboard is transparent and is on the top of the file content to function as the marking layer.
/// For more information, see ZegoFileInfoModel.
@property (nonatomic, strong) ZegoFileInfoModel *fileInfo;

/// Whiteboard creation time.
/// Unix timestamp (milliseconds).
@property (nonatomic, assign) NSUInteger createTime;

/// Animation information of a PPT file, which is used to synchronize the animation playing information of animated PPT files.
/// Note: When this attribute is specified, ZegoDocsView can call the playAnimation API and introduce h5_extra to achieve the animation synchronization effect.
@property (nonatomic, copy) NSString *h5_extra;

// Zooming factor.
@property (nonatomic, assign) CGFloat scaleFactor;

// Horizontal offset of the zooming effect.
@property (nonatomic, assign) CGFloat horizontalScalePercent;

// Vertical offset of the zooming effect.
@property (nonatomic, assign) CGFloat verticalScalePercent;

// uniqueID
@property (nonatomic, copy) NSString *uniqueID;

// Whiteboard server timestamp.
@property (nonatomic, assign) unsigned long long zorder;


@end

NS_ASSUME_NONNULL_END

