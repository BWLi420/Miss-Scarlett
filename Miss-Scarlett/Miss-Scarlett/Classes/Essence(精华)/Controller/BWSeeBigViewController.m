//
//  BWSeeBigViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/27.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSeeBigViewController.h"
#import "BWTopicItem.h"
#import <Photos/Photos.h>

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

#define title @"我的自定义相册"

@interface BWSeeBigViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation BWSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image0]];
    self.imageView = imageView;
    
    [self.scrollView addSubview:imageView];
    
    CGFloat height = screenW / self.item.width * self.item.height;
    imageView.frame = CGRectMake(0, 0, screenW, height);
    
    if (self.item.is_bigPicture) {
        self.scrollView.contentSize = CGSizeMake(screenW, height);
        
        //利用 scrollview 的特性进行缩放图片
        self.scrollView.delegate = self;
        if (self.item.height > height) {
            //设置最大缩放比例
            self.scrollView.maximumZoomScale = self.item.height / height;
        }
    }else {
        imageView.center = CGPointMake(screenW * 0.5, screenH * 0.5);
    }
}

//返回需要缩放的控件
//进行缩放的时候才会调用
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveClick:(UIButton *)sender {
    
//    //保存图片到系统相册
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector( image:didFinishSavingWithError:contextInfo:), nil);
    
    //获取用户授权状态
    /** 
     PHAuthorizationStatusNotDetermined = 0, 不确定
     PHAuthorizationStatusRestricted, 家长控制（拒绝）
     PHAuthorizationStatusDenied, 拒绝
     PHAuthorizationStatusAuthorized 授权
     */
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //授权完成保存
            if (status == PHAuthorizationStatusAuthorized) {
                [self savePhoto];
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized) {
        [self savePhoto];
    }else {
        //无授权，提示用户打开授权
        [SVProgressHUD showSuccessWithStatus:@"进入设置界面->当前应用->允许访问相册"];
    }
}

////保存到系统相册完成时调用
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    }else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}

#pragma mark - 获取之前相册
- (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle {
    /** 
     PHAssetCollectionTypeAlbum      = 1,
     PHAssetCollectionTypeSmartAlbum = 2,
     PHAssetCollectionTypeMoment     = 3,
     */
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in fetchResult) {
        if ([assetCollection.localizedTitle isEqualToString:title]) {
            return assetCollection;
        }
    }
    return nil;
}

#pragma mark - 保存图片到自定义相册
- (void)savePhoto {
    //自定义相册，必须导入 <Photos/Photos.h> 框架
    
//    PHPhotoLibrary：相簿（所有相册集合）
//    PHAsset:图片
//    PHAssetCollection:相册，所有相片集合
//    PHAssetChangeRequest:创建，修改，删除图片
//    PHAssetCollectionChangeRequest:创建，修改，删除相册
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //判断之前是否有相同的相册，获取
        PHAssetCollection *oldCollection = [self fetchAssetColletion:title];
        
        PHAssetCollectionChangeRequest *assetCollection = nil;
        if (oldCollection) {
            
            assetCollection = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:oldCollection];
        }else {
            
            //创建自定义相册
            assetCollection = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        }
        
        //保存图片到系统相册
        PHAssetChangeRequest *assetChange = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
        //将保存的图片添加到自定义相册
        PHObjectPlaceholder *placeholder = [assetChange placeholderForCreatedAsset];
        [assetCollection addAssets:@[placeholder]];//添加的是 NSFastEnumeration 类型，相当于数组
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        //完成后调用
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        }else {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
    }];
}

@end
