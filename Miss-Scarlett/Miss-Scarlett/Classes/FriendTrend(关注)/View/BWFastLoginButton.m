//
//  BWFastLoginButton.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/20.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWFastLoginButton.h"

@implementation BWFastLoginButton

//更改按钮中图片和文字的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置图片
    self.imageView.bw_centerX = self.bw_width * 0.5;
    self.imageView.bw_y = 0;
    
    //设置文字
    [self.titleLabel sizeToFit];
    
    self.titleLabel.bw_centerX = self.bw_width * 0.5;
    self.titleLabel.bw_y = self.bw_height - self.titleLabel.bw_height;
}

@end
