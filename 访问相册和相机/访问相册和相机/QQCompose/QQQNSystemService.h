//
//  QQQNSystemService.h
//  上传图片
//
//  Created by lqq on 16/4/14.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QiniuSDK.h>
@interface QQQNSystemService : NSObject
@property (nonatomic, strong) NSString *token;//需要的token
@property (nonatomic, strong) NSString *domain;
/**
 *  上传图片
 *
 *  @param image    需要上传的图片
 *  @param progress 上传进度block
 *  @param success  成功block 返回URL地址
 *  @param failure  失败block
 */
+ (void)qq_uploadImage:(UIImage *)image
                 token:(NSString *)token
              progress:(QNUpProgressHandler)progress
               success:(void (^)(NSString *url))success
               failure:(void(^)())failure;

/**
 *  上传多张图片, 按队列依次上传
 *
 *  @param imageArray
 *  @param progress
 *  @param success
 *  @param failure
 */
+ (void)qq_uploadImages:(NSArray *)imageArray
                  token:(NSString *)token
               progress:(void (^)(CGFloat progress))progress
                success:(void (^)(NSArray *array))success
                failure:(void(^)())failure;
/**
 *  获取token
 *
 *  @param success 成功返回token
 *  @param failure 失败
 */
//+ (void)qq_qnUploadToken:(void(^)(NSString *token))success
//                 failure:(void(^)())failure;


/**
 *  获取七牛上传成功后的key
 *
 *  @param key     上传成功之后返回图片对应的key
 *  @param success 成功
 *  @param failure 失败
 */
//+ (void)qq_qnUrlKey:(NSString *)key
//            success:(void(^)(NSString *key))success
//            failure:(void(^)())failure;


/**
 *  获取七牛上传成功后服务器返回的url
 *
 *  @param keyArray key数组
 *  @param success  成功
 *  @param failure  失败
 */
//+ (void)qq_qnUrlKeyArray:(NSArray *)keyArray
//                 success:(void(^)(NSArray *array))success
//                 failure:(void(^)())failure;


/**
 *  将图片压缩为指定的比例
 *
 *  @param image 需要处理的图片
 *  @param size  图片大小
 *
 *  @return image
 */

+ (UIImage *)qq_originImage:(UIImage *)image
                scaleToSize:(CGSize)size;




@end
