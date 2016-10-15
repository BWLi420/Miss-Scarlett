//
//  BWMeTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWMeTabVC.h"

@interface BWMeTabVC ()

@end

@implementation BWMeTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    self.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
