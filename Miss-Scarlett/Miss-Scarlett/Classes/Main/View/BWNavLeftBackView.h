//
//  BWNavLeftBackView.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWNavLeftBackView : UIView

//自定义返回按钮
+ (instancetype)backViewWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

@end
