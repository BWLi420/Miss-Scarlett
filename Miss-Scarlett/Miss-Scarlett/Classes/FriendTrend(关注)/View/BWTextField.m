//
//  BWTextField.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/20.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTextField.h"

@implementation BWTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    //监听文本框的状态，更改文本颜色
    //1.代理（不要自己成为自己的代理）  2.通知  3.target
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    // 设置初始占位文字的颜色
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                    }];
}

- (void)textBegin {
    //开始编辑时改为白色
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{
                                  NSForegroundColorAttributeName:[UIColor whiteColor]
                                     }];
}

- (void)textEnd {
    //结束编辑时改为初始颜色
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{
                                  NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                     }];
}

//更改颜色拆分步骤
/**
- (void)test {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    
    self.attributedPlaceholder = attrString;
}
 */

@end
