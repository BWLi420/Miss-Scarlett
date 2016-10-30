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

#import <MJExtension.h>

static NSString *const cateGoryID = @"cateGoryID";
static NSString *const userID = @"userID";

@interface BWRecommandViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (strong, nonatomic) NSArray *categorys;
@end

@implementation BWRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"BWCategoryCell" bundle:nil] forCellReuseIdentifier:cateGoryID];
     [self.userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:userID];
    
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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.categorys.count;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        BWCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cateGoryID];
        cell.item = self.categorys[indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
    cell.textLabel.text = @"456";
    return cell;
}

@end
