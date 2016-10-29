//
//  BWEssenceVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWEssenceVC.h"

#import "BWAllViewController.h"
#import "BWVideoController.h"
#import "BWVoiceController.h"
#import "BWPictureController.h"
#import "BWTextViewController.h"

@interface BWEssenceVC ()

@end

@implementation BWEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航控制器的内容
    [self setNavBar];
    
    //添加所有子控制器
    [self addAllChildVC];
}

//设置导航控制器的内容
- (void)setNavBar {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边视图
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:nil action:nil];
    //右边视图
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}

//添加所有子控制器
- (void)addAllChildVC {
    //全部
    BWAllViewController *allVC = [[BWAllViewController alloc] init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    
    //视频
    BWVideoController *videoVC = [[BWVideoController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    //声音
    BWVoiceController *voiceVC = [[BWVoiceController alloc] init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    
    //图片
    BWPictureController *pictureVC = [[BWPictureController alloc] init];
    pictureVC.title = @"图片";
    [self addChildViewController:pictureVC];
    
    //段子
    BWTextViewController *textVC = [[BWTextViewController alloc] init];
    textVC.title = @"段子";
    [self addChildViewController:textVC];
}

@end
