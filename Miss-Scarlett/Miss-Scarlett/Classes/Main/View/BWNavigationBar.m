//
//  BWNavigationBar.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWNavigationBar.h"
#import "BWNavLeftBackView.h"

@implementation BWNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //遍历导航条的子控制器
    for (UIView *view in self.subviews) {
        //如果是自定义的包装返回按钮的 view
        if ([view isKindOfClass:[BWNavLeftBackView class]]) {
            //距左固定一个位置，使其更加美观，修复按钮中图片区域不能点击的问题
            //（默认情况下控件距左边框比较远，相对于比较靠右）
            view.bw_x = 5;
        }
    }
}

@end
