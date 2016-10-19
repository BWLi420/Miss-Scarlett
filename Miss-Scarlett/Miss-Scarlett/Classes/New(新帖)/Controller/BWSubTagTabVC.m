//
//  BWSubTagTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/18.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSubTagTabVC.h"
#import "BWSubTagItem.h"
#import "BWSubTagCell.h"

#import <MJExtension.h>
#import <UIImageView+WebCache.h>

//保证 ID 不能被修改
static NSString *const ID = @"subTag";

@interface BWSubTagTabVC ()
/** 返回数据的数组 */
@property(nonatomic, strong) NSArray *subTagArray;
@end

@implementation BWSubTagTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取订阅列表数据
    [self loadData];
    
//    //注册 xib
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWSubTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    /** 设置 cell 的分割线全屏显示
     
        1. 在 描述 cell 时添加一个高度为 1 的 view
        2. 利用系统的属性
            - iOS7 之后 tableView 有一个属性导致分割线往右挪动  separatorInset
            - iOS8 之后 cell 有一个属性导致分割线往右挪动一点点  layoutMargins
        3. 重写 cell 的 setFrame （万能）
            - 取消系统的分割线
            - 设置 tableView 的背景色为分割线的颜色
            - 在描述 cell 的 xib 中重写 setFrame,在设置 frame 之前把高度减小分割线的高度
            - 补回分割线的高度
     */
    
//    //取消系统 cell 分割线的内边距
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //取消系统的 cell 分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置 tableView 的背景色为分割线的颜色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

//获取订阅列表数据
- (void)loadData {
    
    //创建会话管理者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager BWMangeer];
    //设置请求参数
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    parametersDict[@"a"] = @"tag_recommend";
    parametersDict[@"c"] = @"topic";
    parametersDict[@"action"] = @"sub";
    //发送请求
    [manger GET:BASEURL parameters:parametersDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取返回数据的数组
        //字典数组转模型数组
        self.subTagArray = [BWSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BWSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [BWSubTagCell subTagCell];
    }
 
    /**
    //根据系统版本取消 cell 的布局边缘
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
     */
    
    //获取模型
    cell.subTagItem = self.subTagArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70 + 10;//加的 10 为 cell 分割线的高度
}

@end
