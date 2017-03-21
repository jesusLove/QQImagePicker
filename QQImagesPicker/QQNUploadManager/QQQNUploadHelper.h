//
//  QQQNUploadHelper.h
//  
//
//  Created by lqq on 16/4/14.
//
//

#import <Foundation/Foundation.h>

@interface QQQNUploadHelper : NSObject
/**
 *  成功回调
 */
@property (nonatomic, copy) void (^singleSuccessBlock)(NSString *);
/**
 *  失败回调
 */
@property (nonatomic, copy) void (^singleFailureBlock)();
+ (instancetype)sharedInstance;
@end
