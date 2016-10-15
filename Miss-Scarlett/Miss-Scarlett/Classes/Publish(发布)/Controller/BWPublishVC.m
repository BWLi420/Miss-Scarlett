//
//  BWPublishVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/15.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWPublishVC.h"

@interface BWPublishVC ()

@end

@implementation BWPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_publish_icon"];
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_publish_click_icon"];
}

@end
