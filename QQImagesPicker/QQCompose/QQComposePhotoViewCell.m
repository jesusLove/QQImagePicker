//
//  QQComposePhotoViewCell.m
//  访问相册和相机
//
//  Created by lqq on 16/4/13.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import "QQComposePhotoViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation QQComposePhotoViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self imageView];
    }
    return self;
}


- (void)setAsset:(JKAssets *)asset {
    if (_asset != asset) {
        _asset = asset;
        self.imageView.image = asset.photo;
    }
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.clipsToBounds = YES;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        _imageView.layer.cornerRadius = 6.0f;
        _imageView.layer.borderColor = [UIColor clearColor].CGColor;
        _imageView.layer.borderWidth = 0.5;
        UIButton *buttonClose = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *imgCloseButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        imgCloseButton.image = [UIImage imageNamed:@"compose_photo_close.png"];
        [buttonClose addSubview:imgCloseButton];
        buttonClose.frame = CGRectMake(_imageView.frame.origin.x + self.contentView.frame.size.width - 25, 0, 25, 25);
        self.deletePhotoButton = buttonClose;
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:buttonClose];
    }
    return _imageView;
}
@end
