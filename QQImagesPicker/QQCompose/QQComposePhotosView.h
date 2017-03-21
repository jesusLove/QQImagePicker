//
//  QQComposePhotosView.h
//  访问相册和相机
//
//  Created by lqq on 16/4/13.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol QQComposePhotosViewDelegate <NSObject>
/**
 *  响应添加照片按键
 */
- (void)addButtonClicked;

@end
@interface QQComposePhotosView : UIView
@property (nonatomic, strong) id <QQComposePhotosViewDelegate>delegate;

/**
 *  保存相册或相机返回的数据
 */
@property (nonatomic, strong) NSMutableArray *assetsArray; 
/**
 *  添加照片按键
 */
@property (nonatomic, strong) UIButton *addButton;
/**
 *  用于显示九宫格
 */
@property (nonatomic, strong) UICollectionView *collectionView;
@end
