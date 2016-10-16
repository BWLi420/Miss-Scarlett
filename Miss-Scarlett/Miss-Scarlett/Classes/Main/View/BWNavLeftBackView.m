//
//  BWNavLeftBackView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWNavLeftBackView.h"

@implementation BWNavLeftBackView

+ (instancetype)backViewWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn setImage:highImage forState:UIControlStateHighlighted];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    BWNavLeftBackView *backView = [[BWNavLeftBackView alloc] initWithFrame:backBtn.bounds];
    [backView addSubview:backBtn];
    
    return backView;
}

@end
