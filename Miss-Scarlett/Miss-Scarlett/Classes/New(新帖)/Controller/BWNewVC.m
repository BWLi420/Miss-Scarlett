//
//  BWNewVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWNewVC.h"

@interface BWNewVC ()

@end

@implementation BWNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新帖";
    self.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_new_click_icon"];
}


@end
