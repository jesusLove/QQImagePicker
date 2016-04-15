//
//  ViewController.m
//  访问相册和相机
//
//  Created by lqq on 16/4/13.
//  Copyright © 2016年 LQQ. All rights reserved.
//

#import "ViewController.h"
#import "JKImagePickerController.h"
#import "QQComposePhotosView.h"
#import "UIView+Extension.h"
#import "QQQNSystemService.h"
#import <AFNetworking.h>
#import <QiniuSDK.h>

@interface ViewController () <JKImagePickerControllerDelegate, QQComposePhotosViewDelegate>
@property (nonatomic, strong) QQComposePhotosView *photosView;
//@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *token;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStyleDone target:self action:@selector(updateImages)];
    [self setUpPhotosView];
    
    //这个是从后台获取的 域名和上传凭证
    //注意上传凭证最好生成,时间片段的不用上传一个文件都要请求
    self.domain = @"http://7xogbo.com2.z0.glb.qiniucdn.com";
    self.token = @"rjUGOBr5yNdaHGNQjZpVrZrIcdnbb7V9Ta9O5Zfi:Hlj-d-yTJRQybMW_4li_7iVDNMU=:eyJzY29wZSI6InBpbmJhbiIsImRlYWRsaW5lIjoxNDYwNzM0MjM0fQ==";

    [[NSUserDefaults standardUserDefaults] setObject:self.domain forKey:@"domain"];
    [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:@"token"];
    
}
- (void)setUpPhotosView {
    self.photosView = [[QQComposePhotosView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 510)];
    self.photosView.delegate = self;
    self.photosView.addButton.hidden = NO;
    [self.view addSubview:self.photosView];
    self.photosView = self.photosView;
}
- (void)addButtonClicked {
    JKImagePickerController *imagePicker = [[JKImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.showsCancelButton = YES;
    imagePicker.minimumNumberOfSelection = 1;
    imagePicker.maximumNumberOfSelection = 9;
    imagePicker.selectedAssetArray = self.photosView.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePicker];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source {

    self.photosView.assetsArray = [NSMutableArray arrayWithArray:assets];
//    self.images = [NSMutableArray array];
    
    //解析出图片, 选中的图片,但是不一定是最终需要上传的图片
//    for (JKAssets *asset in assets) {
//        [self.images addObject:asset.photo];
//    }
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        if (self.photosView.assetsArray.count > 0) {
            //返回数据放到显示中
            self.photosView.addButton.hidden = NO;
        }
        [self.photosView.collectionView reloadData];
    }];
    
}
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)updateImages {
    NSMutableArray *upImages = [NSMutableArray array];
    for (JKAssets *asset in self.photosView.assetsArray) {
        [upImages addObject:asset.photo];
    }
    NSLog(@"%@", upImages);
    //这里上传的图片应该是九宫格中还剩的图片
    [QQQNSystemService qq_uploadImages:upImages token:self.token progress:^(CGFloat progress) {
        NSLog(@"上传图片的进度 == %lf", progress);
    } success:^(NSArray *array) {
        NSLog(@"图片地址 : %@", array);
        
    } failure:^{
        NSLog(@"上传失败");
    }];
}





//获取upToken, 最好能在后台获取, 这里使用的是七牛SDK中给的测试方法

//- (void)getTokenFromQN {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager POST:@"http://115.231.183.102:9090/api/quick_start/simple_image_example_token.php" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        self.domain = responseObject[@"domain"];
//        self.token = responseObject[@"uptoken"];
//        [[NSUserDefaults standardUserDefaults] setObject:self.domain forKey:@"domain"];
//        [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:@"token"];
//        NSLog(@"%@, %@", self.domain, self.token);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
