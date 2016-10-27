//
//  BWTopicItem.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopicItem.h"
#import "BWCmtItem.h"
#import <MJExtension.h>

@implementation BWTopicItem

//告诉框架 top_cmt 是一个 BWCmtItem 类型的模型
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"top_cmt":@"BWCmtItem"};
}

//重写 top_cmt 的 setter 方法，告诉 top_cmt 在哪取值
- (void)setTop_cmt:(NSArray *)top_cmt {
    _top_cmt = top_cmt;
    
    if (self.top_cmt.count) {
        self.cmtItem = top_cmt.firstObject;
    }
}

@end
