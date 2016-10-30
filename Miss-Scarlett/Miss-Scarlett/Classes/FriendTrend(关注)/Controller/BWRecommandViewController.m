//
//  BWRecommandViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/30.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWRecommandViewController.h"

static NSString *const cateGoryID = @"cateGoryID";
static NSString *const userID = @"userID";

@interface BWRecommandViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@end

@implementation BWRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cateGoryID];
    [self.userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:userID];
    
    //取消自动额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return 10;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cateGoryID];
        cell.textLabel.text = @"123";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
    cell.textLabel.text = @"456";
    return cell;
}

@end
