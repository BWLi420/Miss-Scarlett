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

+ (void)load{
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
    
    //创建发布按钮，实现按钮的高亮
    [self addPublishBtn];
    
    //更改 tabBar 的渲染颜色
    self.tabBar.tintColor = [UIColor blackColor];

    //添加子控制器
    [self addChildVC];
    
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
        [self.tabBar addSubview:publishBtn];
    });
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
