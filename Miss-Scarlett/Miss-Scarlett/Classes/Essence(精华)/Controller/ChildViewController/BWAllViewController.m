//
//  BWAllViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/24.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWAllViewController.h"

static NSString *const ID = @"all";

@interface BWAllViewController ()

@end

@implementation BWAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = @"demo...";
    
    return cell;
}

@end
