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
 *  上传单张图片
 *
 *  @param image    需要上传的图片
 *  @param progress 上传进度block
 *  @param token    上传凭证
 *  @param domain   上传的服务器地址
 *  @param success  成功block 返回URL地址
 *  @param failure  失败block
 */
+ (void)qq_uploadImage:(UIImage *)image
                 token:(NSString *)token
                domain:(NSString *)domain
              progress:(QNUpProgressHandler)progress
               success:(void (^)(NSString *url))success
               failure:(void(^)())failure;

/**
 *  上传多张图片, 按队列依次上传
 *
 *  @param imageArray 图片数组
 *  @param token    上传凭证
 *  @param domain   上传的服务器地址
 *  @param progress 进度
 *  @param success  成功返回 图片地址
 *  @param failure 失败回调
 */
+ (void)qq_uploadImages:(NSArray *)imageArray
                  token:(NSString *)token
                 domain:(NSString *)domain
               progress:(void (^)(CGFloat progress))progress
                success:(void (^)(NSArray *array))success
                failure:(void(^)())failure;
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
