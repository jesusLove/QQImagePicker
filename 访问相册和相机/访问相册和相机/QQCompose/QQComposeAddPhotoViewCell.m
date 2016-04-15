//
//  QQComposeAddPhotoViewCell.m
//  访问相册和相机
//
//  Created by lqq on 16/4/14.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import "QQComposeAddPhotoViewCell.h"

@implementation QQComposeAddPhotoViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *img = [UIImage imageNamed:@"compose_pic_add"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [button setBackgroundImage:img forState:UIControlStateNormal];
        self.addButton = button;
        [self addSubview:button];
    }
    return self;
}
@end
