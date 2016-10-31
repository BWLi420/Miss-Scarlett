//
//  BWRecommandViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/30.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWRecommandViewController.h"
#import "BWCategoryCell.h"
#import "BWCategoryItem.h"
#import "BWUserCell.h"
#import "BWUserDataItem.h"

#import <MJExtension.h>
#import <MJRefresh.h>

static NSString *const cateGoryID = @"cateGoryID";
static NSString *const userID = @"userID";

@interface BWRecommandViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (strong, nonatomic) NSArray *categorys;
@property (strong, nonatomic) BWCategoryItem *selectedCategory;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation BWRecommandViewController

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager BWMangeer];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    //初始化
    [self initialization];
    
    //加载左边数据
    [self loadLeftData];
    
    //给右边用户列表添加上下拉刷新
    [self setUpRefresh];
}

//初始化
- (void)initialization {
    
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.userTableView.delegate = self;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"BWCategoryCell" bundle:nil] forCellReuseIdentifier:cateGoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:@"BWUserCell" bundle:nil] forCellReuseIdentifier:userID];
    
    //取消自动额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
}

//给右边用户列表添加上下拉刷新
- (void)setUpRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRightData)];
    header.automaticallyChangeAlpha = YES;
    self.userTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRightData)];
    footer.automaticallyHidden = YES;
    self.userTableView.mj_footer = footer;
}

//加载左边数据
- (void)loadLeftData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager BWMangeer];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.categorys = [BWCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新数据
        [self.categoryTableView reloadData];
        
        //默认选中第0行
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.categoryTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
        //手动加载第0行对应的数据
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:index];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//加载右边数据
- (void)loadRightData {
    
    self.selectedCategory.page = 1;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    // 获取当前分类ID
    parameters[@"category_id"] = self.selectedCategory.id;
    
    [self.manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //下一次要加载的数据页
        self.selectedCategory.page ++;
        //记录当前分类的总页数
        self.selectedCategory.total_page = [responseObject[@"total_page"] integerValue];
        
        //结束下拉刷新
        [self.userTableView.mj_header endRefreshing];
        //结束上拉刷新
        [self.userTableView.mj_footer endRefreshing];
        
        self.selectedCategory.users = [BWUserDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新数据
        [self.userTableView reloadData];
        
        //如果超出总页数则隐藏上拉刷新
        if (self.selectedCategory.page > self.selectedCategory.total_page) {
            self.userTableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//加载更多右边数据
- (void)loadMoreRightData {
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    // 获取当前分类ID
    parameters[@"category_id"] = self.selectedCategory.id;
    //获取当前页码对应数据
    parameters[@"page"] = @(self.selectedCategory.page);
    
    [self.manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //下一次要加载的数据页
        self.selectedCategory.page ++;
        
        //结束下拉刷新
        [self.userTableView.mj_header endRefreshing];
        //结束上拉刷新
        [self.userTableView.mj_footer endRefreshing];
        
        NSArray *arr = [BWUserDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.selectedCategory.users addObjectsFromArray:arr];
        //刷新数据
        [self.userTableView reloadData];
        
        //如果超出总页数则隐藏上拉刷新
        if (self.selectedCategory.page > self.selectedCategory.total_page) {
            self.userTableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        //记录当前选择的分类模型
        self.selectedCategory = self.categorys[indexPath.row];
        
        //刷新数据
        [self.userTableView reloadData];
        
        //判断之前是否已经加载过数据
        if (self.selectedCategory.users.count == 0) {
            
            //根据点击的模型，加载右边的数据
            [self loadRightData];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        return 44;
    }
    return 70;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.categorys.count;
    }
    return self.selectedCategory.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        BWCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cateGoryID];
        cell.item = self.categorys[indexPath.row];
        return cell;
    }
    
    BWUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
    cell.item = self.selectedCategory.users[indexPath.row];
    return cell;
}

@end
