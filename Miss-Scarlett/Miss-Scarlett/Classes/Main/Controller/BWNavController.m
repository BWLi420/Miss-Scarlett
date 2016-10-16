//
//  BWNavController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWNavController.h"
#import "BWNavigationBar.h"

@interface BWNavController ()

@end

@implementation BWNavController

//自定义导航控制器，方便统一管理

//方式一：会修改所有的 navBar
/**
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航控制器的背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //设置导航控制器的文字大小
    [self.navigationBar setTitleTextAttributes:@{
                            NSFontAttributeName:[UIFont systemFontOfSize:20]
                            }];
}
*/

//方式二：只修改对应类下的 navBar
+ (void)load {
    /*
     appearance:获取整个应用程序下所有东西
     appearanceWhenContainedIn:获取某个类下的东西
     
     iOS7:appearance,修改短信界面，会导致联系人黑屏
     */
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //设置导航条的文字大小
    navBar.titleTextAttributes = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:20]
                                   };
    //设置导航条的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

//使用自定义的导航条
- (void)viewDidLoad {
    
    BWNavigationBar *navBar = [[BWNavigationBar alloc] init];
    navBar.frame = self.navigationBar.bounds;
    [self setValue:navBar forKey:@"navigationBar"];
}

@end
