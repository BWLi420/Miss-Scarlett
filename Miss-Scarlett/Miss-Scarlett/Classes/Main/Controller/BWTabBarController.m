//
//  BWTabBarController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTabBarController.h"

#import "BWEssenceVC.h"
#import "BWNewVC.h"
#import "BWPublishVC.h"
#import "BWFriendTrendVC.h"
#import "BWMeTabVC.h"

@interface BWTabBarController ()

@end

@implementation BWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.image = [UIImage imageNamed:@"tabbar-light"];
    //添加子控制器
    [self addChildVC];
}

//添加子控制器
- (void)addChildVC {
    
    //添加导航控制器为 TabBarVC 的子控制器
    //将界面添加到导航控制器
    //导航控制器将栈顶控制器的 view 显示出来
    
    //精华
    BWEssenceVC *essenceVC = [[BWEssenceVC alloc] init];
    essenceVC.view.backgroundColor = [UIColor orangeColor];
    UINavigationController *essenceNav = [[UINavigationController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:essenceNav];
    
    //新帖
    BWNewVC *newVC = [[BWNewVC alloc] init];
    newVC.view.backgroundColor = [UIColor greenColor];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:newNav];
    
    //发布
    BWPublishVC *publishVC = [[BWPublishVC alloc] init];
    publishVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:publishVC];
    
    //关注
    BWFriendTrendVC *FriendVC = [[BWFriendTrendVC alloc] init];
    FriendVC.view.backgroundColor = [UIColor blueColor];
    UINavigationController *FriendNav = [[UINavigationController alloc] initWithRootViewController:FriendVC];
    [self addChildViewController:FriendNav];
    
    //我
    BWMeTabVC *meVC = [[BWMeTabVC alloc] init];
    meVC.view.backgroundColor = [UIColor grayColor];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:meNav];
}

@end
