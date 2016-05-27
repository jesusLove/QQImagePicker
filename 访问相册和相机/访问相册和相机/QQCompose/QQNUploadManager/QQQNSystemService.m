//
//  QQQNSystemService.m
//  上传图片
//
//  Created by lqq on 16/4/14.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import "QQQNSystemService.h"
#import "QQQNUploadHelper.h"
#import <QiniuSDK.h>
#import <AFNetworking.h>
@interface QQQNSystemService ()

@end
@implementation QQQNSystemService
//token 和 domain 使用属性列表存

+ (QNUploadManager *) shareManager {
    static QNUploadManager *upManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        upManager = [[QNUploadManager alloc] init];
    });
    return upManager;
}

+(void)qq_uploadImage:(UIImage *)image
                token:(NSString *)token
               domain:(NSString *)domain
             progress:(QNUpProgressHandler)progress
              success:(void (^)(NSString *))success
              failure:(void (^)())failure {
    UIImage *sizeImage = [QQQNSystemService qq_originImage:image scaleToSize:CGSizeMake(800, 900)];
    NSData *data = UIImageJPEGRepresentation(sizeImage, 0.3);
    if (!data) {
        if (failure) {
            failure();
        }
        return;
    }
    //只生成一次
    QNUploadManager *upManager = [[self class] shareManager];
    //显示上传的百分比
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
        
    } params:nil checkCrc:NO cancellationSignal:nil];
    
    [upManager putData:data key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        
        if (info.statusCode == 200 && resp) {
            NSString *url = [NSString stringWithFormat:@"%@/%@", domain, resp[@"key"]];
            NSLog(@"url === %@", url);
            if (success) {
                success(url);
            }
        } else {
            if (failure) {
                failure();
            }
        }
        
    } option:uploadOption];
    
    
}

+ (void)qq_uploadImages:(NSArray *)imageArray token:(NSString *)token domain:(NSString *)domain  progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure {
    NSMutableArray *array = [NSMutableArray array];
    
    __block float totalProgress = 0.0f;
    __block float partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    
    QQQNUploadHelper *uploadHelper = [QQQNUploadHelper sharedInstance];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock = ^() {
        failure();
        return ;
    };
    
    uploadHelper.singleSuccessBlock = ^(NSString *url) {
        [array addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        
        currentIndex ++;
        NSLog(@"currentIndex == %ld", currentIndex);
        if (array.count == imageArray.count) {
            success([array copy]);
            return ;
        } else {
            [QQQNSystemService qq_uploadImage:imageArray[currentIndex] token:token domain:domain progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
        }
    };
    [QQQNSystemService qq_uploadImage:imageArray[0] token:token domain:domain progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
    
}
//压缩上传图片的大小比例
+(UIImage*)qq_originImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
@end

