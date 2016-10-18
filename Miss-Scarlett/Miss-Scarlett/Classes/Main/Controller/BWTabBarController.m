//
//  BWTabBarController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTabBarController.h"
#import "BWNavController.h"

#import "BWEssenceVC.h"
#import "BWNewVC.h"
#import "BWPublishVC.h"
#import "BWFriendTrendVC.h"
#import "BWMeTabVC.h"

#import "UIImage+BWImage.h"

@interface BWTabBarController ()

@end

@implementation BWTabBarController

+ (void)load {
    //程序启动类加载到内存的时候只调用一次
    
    /* appearance 的简单说明
    
     1.必须遵守 UIAppearance 协议的类才可以使用该方法
     2.只有带有 UI_APPEARANCE_SELECTOR 宏的属性或者方法，才可以通过 appearance 进行调用设置
     3.使用 appearance 设置属性，必须在显示之前设置
     */
    //获取 UITabBarItem 的外观
    UITabBarItem *item = [UITabBarItem appearance];
    //设置系统 tabBarButton 的字体大小
    //只能通过正常状态去设置
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName:[UIFont systemFontOfSize:14]
                                   } forState:UIControlStateNormal];
}

//+ (void)initialize {
//    //第一次使用类或它的子类的时候调用，至少调用一次
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更改 tabBar 的渲染颜色
    self.tabBar.tintColor = [UIColor blackColor];

    //添加子控制器
    [self addChildVC];
    //设置 tabBar 的内容
    [self setUp];
    
    //创建发布按钮，实现按钮的高亮
    [self addPublishBtn];
}

//添加子控制器
- (void)addChildVC {
    
    //添加导航控制器为 TabBarVC 的子控制器
    //将界面添加到导航控制器
    //导航控制器将栈顶控制器的 view 显示出来
    
    //精华
    BWEssenceVC *essenceVC = [[BWEssenceVC alloc] init];
    BWNavController *essenceNav = [[BWNavController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:essenceNav];
    
    //新帖
    BWNewVC *newVC = [[BWNewVC alloc] init];
    BWNavController *newNav = [[BWNavController alloc] initWithRootViewController:newVC];
    [self addChildViewController:newNav];
    
    //发布
    BWPublishVC *publishVC = [[BWPublishVC alloc] init];
    [self addChildViewController:publishVC];
    
    //关注
    BWFriendTrendVC *FriendVC = [[BWFriendTrendVC alloc] init];
    BWNavController *FriendNav = [[BWNavController alloc] initWithRootViewController:FriendVC];
    [self addChildViewController:FriendNav];
    
    //我
    BWMeTabVC *meVC = [[BWMeTabVC alloc] init];
    BWNavController *meNav = [[BWNavController alloc] initWithRootViewController:meVC];
    [self addChildViewController:meNav];
}

//设置 tabBar 的内容
- (void)setUp {
    
    //精华
    UINavigationController *essenceNav = self.childViewControllers[0];
    essenceNav.tabBarItem.title = @"精华";
    essenceNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essenceNav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_essence_click_icon"];
    
    //新帖
    UINavigationController *newNav = self.childViewControllers[1];
    newNav.tabBarItem.title = @"新帖";
    newNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newNav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];
    
    //发布
    UINavigationController *publishNav = self.childViewControllers[2];
    publishNav.tabBarItem.enabled = NO;

    //关注
    UINavigationController *friendNav = self.childViewControllers[3];
    friendNav.tabBarItem.title = @"关注";
    friendNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendNav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon"];
    
    //我
    UINavigationController *meNav = self.childViewControllers[4];
    meNav.tabBarItem.title = @"我";
    meNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meNav.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];
}

//创建发布按钮，实现按钮的高亮
- (void)addPublishBtn {
    //只执行一次，也可以使用懒加载
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishBtn sizeToFit];
        publishBtn.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
        [publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:publishBtn];
    });
}

- (void)publishBtnClick:(UIButton *)publishBtn {
    
    NSLog(@"发布");
}
@end
