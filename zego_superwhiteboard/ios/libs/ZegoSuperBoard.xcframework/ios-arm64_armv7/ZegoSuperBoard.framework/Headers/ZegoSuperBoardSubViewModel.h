//
//  ZegoSuperBoardModel.h
//  ZegoSuperBoard
//
//  Created by zego on 2021/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Description: Data model class, which contains the name, creation time, contained file ID, file type, and unique ID of the created ZegoSuperBoardSubView object.
///
/// Business scenario: Obtain the name and file information of the ZegoSuperBoardSubView object.
///
@interface ZegoSuperBoardSubViewModel : NSObject

/// SuperBoardSubView name.
@property (nonatomic, copy) NSString *name;

/// Whiteboard creation time.
/// Unix timestamp (milliseconds).
@property (nonatomic,assign) NSUInteger createTime;

/// Unique file ID.
/// Note: The file ID is the ID that is obtained after the file transcoding is successful.
@property (nonatomic,copy) NSString *fileID;

/// File type. For more information, see the file types defined in the ZegoDocsView SDK.
@property (nonatomic,assign) NSUInteger fileType;

/// Unique ID of SuperBoardSubview.
@property (nonatomic,copy) NSString *uniqueID;

/// whiteboardIDList
@property (nonatomic,strong) NSArray *whiteboardIDList;

@end

NS_ASSUME_NONNULL_END

