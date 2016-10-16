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
    
    //使用以下方式，由于 tabBarButton 没有高亮状态，因此在点击之后一直处于选中状态
    //若要实现高亮状态，则创建一个 UIButton 添加到 tarBar 上,同时禁止 tabBarItem 的交互
    self.tabBarItem.enabled = NO;
//    self.tabBarItem.image = [UIImage imageWithOriginalName:@"tabBar_publish_icon"];
//    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabBar_publish_click_icon"];
//    //设置图片内边距调整位置
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
}

@end
