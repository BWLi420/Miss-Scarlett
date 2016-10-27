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

@interface BWSeeBigViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BWSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image0]];
    
    [self.scrollView addSubview:imageView];
    
    CGFloat height = screenW / self.item.width * self.item.height;
    imageView.frame = CGRectMake(0, 0, screenW, height);
    
    if (self.item.is_bigPicture) {
        self.scrollView.contentSize = CGSizeMake(screenW, height);
    }else {
        imageView.center = CGPointMake(screenW * 0.5, screenH * 0.5);
    }
}

- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveClick:(UIButton *)sender {
    NSLog(@"保存");
}

@end
