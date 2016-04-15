//
//  QQQNUploadHelper.m
//  
//
//  Created by lqq on 16/4/14.
//
//

#import "QQQNUploadHelper.h"
static QQQNUploadHelper *_sharedInstance;

@implementation QQQNUploadHelper


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[QQQNUploadHelper alloc] init];
        
    });
    return _sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [super allocWithZone:zone];
    });
    return _sharedInstance;
}
+ (id)copyWithZone:(NSZone *)zone {
    return _sharedInstance;
}
@end
