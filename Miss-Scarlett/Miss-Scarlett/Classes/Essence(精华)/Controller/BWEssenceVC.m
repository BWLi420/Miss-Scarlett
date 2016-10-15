//
//  BWEssenceVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWEssenceVC.h"

@interface BWEssenceVC ()

@end

@implementation BWEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"精华";
    self.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_essence_click_icon"];
}

@end
