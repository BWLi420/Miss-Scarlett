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

@interface BWNavController () <UIGestureRecognizerDelegate>

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

#pragma mark - 全屏滑动返回
- (void)viewDidLoad {
    /*
     UITabBarIte：设置UITabBar上按钮内容
     UINavigationItem：设置导航条哪边显示内容
     UIBarButtonItem：决定导航条上按钮具体内容
     */
    //使用自定义的导航条
    BWNavigationBar *navBar = [[BWNavigationBar alloc] init];
    navBar.frame = self.navigationBar.bounds;
    [self setValue:navBar forKey:@"navigationBar"];
    
    /** 添加手势，实现全屏滑动返回 */
    //禁用系统的手势（默认只有最左边才能滑动）
    self.interactivePopGestureRecognizer.enabled = NO;
    //创建自己的 pan 手势，使用系统自带手势的方法进行监听
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    //将手势添加到控制器的 view 上
    [self.view addGestureRecognizer:pan];
    
    /* 分析：
     滑动返回功能：导航控制器iOS7后自带
     
     恢复滑动返回功能：
     
     分析：覆盖掉系统返回按钮，滑动返回功能就失效
     
     需求：既要覆盖系统返回按钮，也要有滑动返回功能.
     
     为什么没有，谁导致滑动返回功能没有的。当覆盖掉系统返回按钮，系统额外做了一些事情，导致
     滑动返回功能失效。
     
     系统额外做了什么事情，导致滑动返回功能失效？
     
     滑动返回功能，肯定需要手势? 猜测interactivePopGestureRecognizer，就有滑动返回功能
     
     验证滑动返回功能 跟interactivePopGestureRecognizer有关系
     
     让interactivePopGestureRecognizer手势失效，通过代理
     
     当覆盖掉系统返回按钮，系统额外做了一些事情，导致滑动返回功能失效
     系统额外做了一些事情 => interactivePopGestureRecognizer的代理做了事情
     
     interactivePopGestureRecognizer的代理 就是 让滑动返回失效
     */
}

//根据是否为根控制器，设置是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //非根控制器触发手势
    return self.childViewControllers.count > 1;
}

#pragma mark - 自定义 push 方法
//自定义 push 方法，统一设置导航条的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //方式一：super 在前面，但是不能统一隐藏底部隐藏条（必须在 push 之前）
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
        //隐藏底部导航条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //此时才会真正将子控制器添加到栈中
    [super pushViewController:viewController animated:animated];
}

//点击返回按钮返回上一个界面
- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
}

@end
