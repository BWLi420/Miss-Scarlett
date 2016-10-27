//
//  BWSeeBigViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/27.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSeeBigViewController.h"
#import "BWTopicItem.h"

#import <UIImageView+WebCache.h>

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
    NSLog(@"保存");
}

@end
