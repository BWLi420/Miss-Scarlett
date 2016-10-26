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
    
    //计算中间 view 高度
    if (item.type != BWTopicItemTypeText) {
        
        CGFloat middleH = textW / item.width * item.height;
        if (middleH > 300) {
            middleH = 300;
            item.is_bigPicture = YES;
        }else {
            middleH = 300;
        }
        self.middleViewFrame = CGRectMake(margin, self.cellH, textW, middleH);
        self.cellH = CGRectGetMaxY(self.middleViewFrame) + margin;
    }
}
@end
