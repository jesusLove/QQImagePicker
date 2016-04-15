//
//  QQComposePhotosView.h
//  访问相册和相机
//
//  Created by lqq on 16/4/13.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol QQComposePhotosViewDelegate <NSObject>

- (void)addButtonClicked;

@end
@interface QQComposePhotosView : UIView
@property (nonatomic, strong) id <QQComposePhotosViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSArray *selectdPhotos;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
