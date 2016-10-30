//
//  BWFriendTrendVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWFriendTrendVC.h"
#import "BWLoginRegVC.h"
#import "BWRecommandViewController.h"

@interface BWFriendTrendVC ()

@end

@implementation BWFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    //设置导航控制器的内容
    [self setNavBar];
}

//设置导航控制器的内容
- (void)setNavBar {
    
    self.navigationItem.title = @"我的关注";
    //左边视图
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(leftClick)];
}

- (IBAction)regLoginBtnClick:(id)sender {
    
    //加载箭头指向的控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BWLoginRegVC" bundle:nil];
    BWLoginRegVC *loginRegVC = [storyboard instantiateInitialViewController];
    
    [self presentViewController:loginRegVC animated:YES completion:nil];
}

- (void)leftClick {
    BWRecommandViewController *recommandVC = [[BWRecommandViewController alloc] init];
    [self.navigationController pushViewController:recommandVC animated:YES];
}

@end
