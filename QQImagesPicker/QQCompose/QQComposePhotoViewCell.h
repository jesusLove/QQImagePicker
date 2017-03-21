//
//  QQComposePhotoViewCell.h
//  访问相册和相机
//
//  Created by lqq on 16/4/13.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAssets.h"
@interface QQComposePhotoViewCell : UICollectionViewCell

@property (nonatomic, strong) JKAssets *asset;
@property (nonatomic, weak) UIButton *deletePhotoButton;
@property (nonatomic, strong) NSIndexPath *indexpath;
@property (nonatomic, strong) UIImageView *imageView;
@end
