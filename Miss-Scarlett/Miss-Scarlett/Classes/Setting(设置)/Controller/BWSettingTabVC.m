//
//  BWSettingTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSettingTabVC.h"
#import "BWNavLeftBackView.h"

@interface BWSettingTabVC ()

@end

@implementation BWSettingTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    //自定义导航控制器的返回按钮
//    [self customBackBtn];
}

//自定义导航控制器的返回按钮
//- (void)customBackBtn {
//    
//    BWNavLeftBackView *backView = [BWNavLeftBackView backViewWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target: self action:@selector(backBtnClick)];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
//}

////点击返回按钮返回上一个界面
//- (void)backBtnClick {
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
