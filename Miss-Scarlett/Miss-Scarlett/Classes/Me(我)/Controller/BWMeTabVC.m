//
//  BWMeTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWMeTabVC.h"
#import "BWSettingTabVC.h"
#import "BWCollectionViewCell.h"

static NSString *const ID = @"collectionViewCell";

@interface BWMeTabVC () <UICollectionViewDataSource>

@end

@implementation BWMeTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    //设置导航控制器的内容
    [self setNavBar];
    //设置底部视图 UICollectionView 视图
    [self setFootView];
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

#pragma mark - 设置底部视图 UICollectionView 视图
/*
 UICollectionView使用步骤
    1.初始化流水布局
    2.UICollectionViewCell 必须注册
    3.UICollectionViewCell 一般都要自定义 cell
 */
- (void)setFootView {
    
    //创建流水布局
    UICollectionViewFlowLayout *flowLayout = [self setFlowLayout];
    
    //创建 collectionView
    UICollectionView *collectionView = [self setCollectionView:flowLayout];
    
    self.tableView.tableFooterView = collectionView;
}

//创建流水布局
- (UICollectionViewFlowLayout *)setFlowLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置 cell 的尺寸
    NSInteger cols = 4;
    NSInteger margin = 1;
    CGFloat itemWH = (screenW - (cols - 1)) / cols;
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    return flowLayout;
}

//创建 collectionView
- (UICollectionView *)setCollectionView:(UICollectionViewFlowLayout *)flowLayout {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 400)collectionViewLayout:flowLayout];
    //collectionView 默认背景色为黑色
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    
    //注册 collectionView
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BWCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    return collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}

@end
