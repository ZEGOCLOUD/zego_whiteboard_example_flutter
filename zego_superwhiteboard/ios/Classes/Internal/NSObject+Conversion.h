//
//  NSObject+Conversion.h
//  zego_superwhiteboard
//
//  Created by zego on 2023/3/21.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Conversion)

+ (NSDictionary *)dicFromObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
