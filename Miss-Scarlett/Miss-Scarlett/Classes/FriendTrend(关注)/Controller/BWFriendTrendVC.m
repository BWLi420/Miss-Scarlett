//
//  BWFriendTrendVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWFriendTrendVC.h"

@interface BWFriendTrendVC ()

@end

@implementation BWFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关注";
    self.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon"];
}

@end
