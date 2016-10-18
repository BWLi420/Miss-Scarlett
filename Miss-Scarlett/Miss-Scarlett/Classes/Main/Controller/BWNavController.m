//
//  BWNavController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWNavController.h"
#import "BWNavigationBar.h"
#import "BWNavLeftBackView.h"

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

//自定义 push 方法，统一设置导航条的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //方式一：super 在前面
    /**
    [super pushViewController:viewController animated:animated];
    
    //如果是非根控制器才设置返回按钮
    if (viewController != self.childViewControllers[0]) {
        
        BWNavLeftBackView *backView = [BWNavLeftBackView backViewWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target: self action:@selector(backBtnClick)];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    }
     */
    
    //方式二：super 在后面，此时可以通过导航控制器的子控制器的个数判断是否为非根控制器
    if (self.childViewControllers.count > 0) {
        
        BWNavLeftBackView *backView = [BWNavLeftBackView backViewWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target: self action:@selector(backBtnClick)];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    }
    
    [super pushViewController:viewController animated:animated];
}

//点击返回按钮返回上一个界面
- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
}

@end
