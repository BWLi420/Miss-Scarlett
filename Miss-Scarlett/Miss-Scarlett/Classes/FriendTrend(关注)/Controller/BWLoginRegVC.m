//
//  BWLoginRegVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/19.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWLoginRegVC.h"
#import "BWRegLoginView.h"

/**
 复杂界面：
    1.划分层次结构
    2.每一个结构对应一个占位视图
 */

@interface BWLoginRegVC ()
@property (weak, nonatomic) IBOutlet UIView *regLoginView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;
@end

@implementation BWLoginRegVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建登录的 view
    BWRegLoginView *loginView = [BWRegLoginView loginView];
    [self.regLoginView addSubview:loginView];
    
    //创建注册的 view
    BWRegLoginView *regView = [BWRegLoginView regView];
    [self.regLoginView addSubview:regView];
}

/**
    xib 的使用注意：
 1.一个控件从 xib 加载，默认尺寸与 xib 一致
 2.建议加载 xib 时，再次确认尺寸和位置
 3.在 viewDidLoad 还没有执行约束，如果参考屏幕设置尺寸，不会有问题
 4.如果参考控制器 view 的子控件设置会导致设置错误
 */

//此时已经执行完约束，可以设置子控件的位置
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.regLoginView.subviews[0].frame = CGRectMake(0, 0, self.regLoginView.bw_width * 0.5, self.regLoginView.bw_height);
    self.regLoginView.subviews[1].frame = CGRectMake(self.regLoginView.bw_width * 0.5, 0, self.regLoginView.bw_width * 0.5, self.regLoginView.bw_height);
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)regBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //移动注册登录界面
    self.leadingCons.constant = self.leadingCons.constant == 0 ? -screenW : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
