//
//  BWBaseEssenceViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/29.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWBaseEssenceViewController.h"
#import "BWTopicCell.h"
#import "BWTopicViewModel.h"
#import "BWNewVC.h"

#import <MJExtension.h>
#import <MJRefresh.h>

/** - 不等高的 cell
 1. 自定义 cell
 2. 划分层次结构
 - TopView
 - MiddleView（视频，图片，声音）
 - 最热评论
 - BottomView
 3. 由于很多东西不确定，不能使用 xib 描述
 4. 通过代码在 initWithStyle 添加所有子控件
 5. 最初将所有子控件添加上去，根据内容判断是否需要显示
 */

static NSString *const ID = @"cell";

@interface BWBaseEssenceViewController ()
@property (nonatomic, strong) NSMutableArray *topicsVM;
@property (strong, nonatomic) NSString *maxtime;
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@end

@implementation BWBaseEssenceViewController

- (NSMutableArray *)topicsVM {
    if (_topicsVM == nil) {
        _topicsVM = [NSMutableArray array];
    }
    return _topicsVM;
}

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager BWMangeer];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //只要通过注册创建 cell，就会调用 initWithStyle
    [self.tableView registerClass:[BWTopicCell class] forCellReuseIdentifier:ID];
    //请求数据
    [self loadData];
    
    //添加上下拉刷新
    [self setUpRefresh];
    
    //取消 cell 之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//添加上下拉刷新
- (void)setUpRefresh {
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //自动根据拖拽控制透明度
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    
    //上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //自动根据有无数据判断是否显示刷新控件
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
}

#pragma mark - 请求数据
- (void)loadData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *a = @"list";
    if ([self.parentViewController isKindOfClass:[BWNewVC class]]) {
        a = @"newlist";
    }
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    
    [self.manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //结束头部刷新
        [self.tableView.mj_header endRefreshing];
        //保存下一页的最大 ID
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组转模型数组
        NSArray *topics = [BWTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //计算顶部 TopView 的尺寸
        NSMutableArray *arr = [NSMutableArray array];
        for (BWTopicItem *item in topics) {
            BWTopicViewModel *topicVM = [[BWTopicViewModel alloc] init];
            //计算 cell 高度和子控件的尺寸
            topicVM.item = item;
            [arr addObject:topicVM];
        }
        self.topicsVM = arr;
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - 加载更多数据
- (void)loadMoreData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *a = @"list";
    if ([self.parentViewController isKindOfClass:[BWNewVC class]]) {
        a = @"newlist";
    }
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = _maxtime;
    parameters[@"type"] = self.type;
    
    [self.manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //结束尾部刷新
        [self.tableView.mj_footer endRefreshing];
        //保存下一页的最大 ID
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组转模型数组
        NSArray *topics = [BWTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //计算顶部 TopView 的尺寸
        for (BWTopicItem *item in topics) {
            BWTopicViewModel *topicVM = [[BWTopicViewModel alloc] init];
            //计算 cell 高度和子控件的尺寸
            topicVM.item = item;
            [self.topicsVM addObject:topicVM];
        }
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsVM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.topicVM = self.topicsVM[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.topicsVM[indexPath.row] cellH] + 50;
}

@end
