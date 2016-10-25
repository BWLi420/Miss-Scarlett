//
//  BWAllViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/24.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWAllViewController.h"
#import "BWTopicCell.h"
#import "BWTopicItem.h"

#import <MJExtension.h>

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

static NSString *const ID = @"all";

@interface BWAllViewController ()
@property (nonatomic, strong) NSArray *topics;
@end

@implementation BWAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    //只要通过注册创建 cell，就会调用 initWithStyle
    [self.tableView registerClass:[BWTopicCell class] forCellReuseIdentifier:ID];
    //请求数据
    [self loadData];
}

//请求数据
- (void)loadData {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    
    [manager GET:BASEURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //字典数组转模型数组
        self.topics = [BWTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新数据
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.topics[indexPath.row];
    
    return cell;
}

@end
