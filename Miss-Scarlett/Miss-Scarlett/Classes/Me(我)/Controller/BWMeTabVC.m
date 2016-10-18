//
//  BWMeTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWMeTabVC.h"
#import "BWSettingTabVC.h"

@interface BWMeTabVC ()

@end

@implementation BWMeTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    //设置导航控制器的内容
    [self setNavBar];
}

//设置导航控制器的内容
- (void)setNavBar {
    
    self.navigationItem.title = @"我的";
    //右边视图
    UIBarButtonItem *nightMode = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-sun-icon-click"] target:self action:@selector(nightMode:)];
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(pushSetting)];
    self.navigationItem.rightBarButtonItems = @[setting, nightMode];
}

//夜间模式
- (void)nightMode:(UIButton *)nightbtn {
    nightbtn.selected = !nightbtn.selected;
}

//跳转到设置界面
- (void)pushSetting {
    BWSettingTabVC *settingVC = [[BWSettingTabVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
