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
#import "BWCollectionItem.h"
#import "BWWKWebViewController.h"

#import <MJExtension.h>
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

static NSString *const ID = @"collectionViewCell";
#define cols 4
#define margin 1
#define itemWH ((screenW - (cols - 1) * margin) / cols)

@interface BWMeTabVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *squareList;

@end

@implementation BWMeTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    //设置导航控制器的内容
    [self setNavBar];
    //设置底部视图 UICollectionView 视图
    [self setFootView];
    //请求服务器数据
    [self loadData];
    
    //修改 cell 的间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
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
    
    UIStoryboard *settingstory = [UIStoryboard storyboardWithName:NSStringFromClass([BWSettingTabVC class]) bundle:nil];
    BWSettingTabVC *settingVC = [settingstory instantiateInitialViewController];
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
    UICollectionViewFlowLayout *flowLayout = [self setUpFlowLayout];
    
    //创建 collectionView
    UICollectionView *collectionView = [self setUpCollectionView:flowLayout];
    
    self.tableView.tableFooterView = collectionView;
}

//创建流水布局
- (UICollectionViewFlowLayout *)setUpFlowLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置 cell 的尺寸
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    return flowLayout;
}

//创建 collectionView
- (UICollectionView *)setUpCollectionView:(UICollectionViewFlowLayout *)flowLayout {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 400)collectionViewLayout:flowLayout];
    //collectionView 默认背景色为黑色
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //注册 collectionView
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BWCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.collectionView = collectionView;
    return collectionView;
}

#pragma mark - 请求服务器数据
- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager BWMangeer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //字典数组转为模型数组
        self.squareList = [BWCollectionItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //计算 collectionView 的高度并添加到 tableFooterView 上
        [self setUpHeight];
        //补齐最后一行的缺口
        [self polishGap];
        
        //刷新数据
        [self.collectionView reloadData];
//        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@", error);
    }];
}

//计算 collectionView 的高度并添加到 tableFooterView 上
- (void)setUpHeight {
    //计算总行数 = (count - 1) / cols + 1
    NSUInteger rows = (self.squareList.count - 1) / cols + 1;
    //计算 collectionView 的高度
    CGFloat collectionHeight = rows * itemWH + (rows - 1) * margin;
    self.collectionView.bw_height = collectionHeight;
    
    //更新 tableView 的滚动范围
    self.tableView.tableFooterView = self.collectionView;
}

//补齐最后一行的缺口
- (void)polishGap {
    NSInteger count = self.squareList.count;
    if (count % cols) {
        //需要补的个数
        NSInteger num = cols - count % cols;
        for (NSInteger i = 0; i < num; i++) {
            BWCollectionItem *item = [[BWCollectionItem alloc] init];
            [self.squareList addObject:item];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareList[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 打开网页
    /*
     1.openURL:safari : 有很多好用的功能，前进，后退，刷新，地址栏，进度条
     弊端：必须要离开当前App
     
     2.UIWebView : 没有功能，只能展示
     好处：当前App打开网页
     
     3.在当前App打开网页，但是也要有safari功能
     iOS9:SFSafariViewController:打开网页，而且是在当前App打开，而且有safari所有功能
     必须要导入 <SafariServices/SafariServices.h>
     
     */
    
    BWCollectionItem *item = self.squareList[indexPath.row];
    NSURL *url = [NSURL URLWithString:item.url];
    
    //方式一：openURL
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        
//        [[UIApplication sharedApplication] openURL:url];
//    }
    
    //方式三：SFSafariViewController
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
//    [self presentViewController:safariVC animated:YES completion:nil];
    
    //方式二：WKWebView
    BWWKWebViewController *wkWebVC = [[BWWKWebViewController alloc] init];
    wkWebVC.url = url;
    [self.navigationController pushViewController:wkWebVC animated:YES];
}

@end
