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

@end

@implementation BWLoginRegVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建登录注册的 view
    BWRegLoginView *regLoginView = [BWRegLoginView regLoginView];
    regLoginView.frame = self.regLoginView.bounds;
    [self.regLoginView addSubview:regLoginView];
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)regBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}


@end
