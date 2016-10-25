//
//  BWTopicViewModel.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopicViewModel.h"
#import "BWTopicItem.h"

@implementation BWTopicViewModel

- (void)setItem:(BWTopicItem *)item {
    _item = item;
    
    //计算顶部 topView 的高度
    CGFloat margin = 10;
    CGFloat textY = 60;
    CGFloat textW = screenW - 2 * margin;
    CGFloat textH = [item.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
    CGFloat topViewH = textH + textY;
    
    self.topViewFrame = CGRectMake(0, 0, screenW, topViewH);
    self.cellH = CGRectGetMaxY(self.topViewFrame) + margin;

}
@end
