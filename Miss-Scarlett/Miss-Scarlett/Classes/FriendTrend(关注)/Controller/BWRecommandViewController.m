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

static NSString *const cateGoryID = @"cateGoryID";
static NSString *const userID = @"userID";

@interface BWRecommandViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (strong, nonatomic) NSArray *categorys;
@property (strong, nonatomic) BWCategoryItem *selectedCategory;
@end

@implementation BWRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"推荐关注";
    
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
    
    //加载左边数据
    [self loadLeftData];
}

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

- (void)loadRightData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager BWMangeer];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    // 获取当前分类ID
    parameters[@"category_id"] = self.selectedCategory.id;
    
    [manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.selectedCategory.users = [BWUserDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新数据
        [self.userTableView reloadData];
        
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
