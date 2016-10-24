//
//  BWNewVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWNewVC.h"
#import "BWSubTagTabVC.h"

#import "BWAllViewController.h"
#import "BWVideoViewController.h"
#import "BWVoiceViewController.h"
#import "BWPictureViewController.h"
#import "BWTextViewController.h"

@interface BWNewVC ()

@end

@implementation BWNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    //设置导航控制器的内容
    [self setNavBar];
    
    //添加所有子控制器
    [self addAllChildVC];
}

//设置导航控制器的内容
- (void)setNavBar{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边视图
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(leftClick)];
}

- (void)leftClick {
    
    BWSubTagTabVC *subTagVC = [[BWSubTagTabVC alloc] init];
    [self.navigationController pushViewController:subTagVC animated:YES];
}

//添加所有子控制器
- (void)addAllChildVC {
    //全部
    BWAllViewController *allVC = [[BWAllViewController alloc] init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    
    //视频
    BWVideoViewController *videoVC = [[BWVideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    //声音
    BWVoiceViewController *voiceVC = [[BWVoiceViewController alloc] init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    
    //图片
    BWPictureViewController *pictureVC = [[BWPictureViewController alloc] init];
    pictureVC.title = @"图片";
    [self addChildViewController:pictureVC];
    
    //段子
    BWTextViewController *textVC = [[BWTextViewController alloc] init];
    textVC.title = @"段子";
    [self addChildViewController:textVC];
}

@end
