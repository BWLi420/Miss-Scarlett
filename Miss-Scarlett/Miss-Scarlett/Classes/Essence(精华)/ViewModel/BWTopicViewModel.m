//
//  BWTopicViewModel.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopicViewModel.h"
#import "BWTopicItem.h"
#import "BWCmtItem.h"

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
    
    //计算最热评论的高度
    if (item.cmtItem) {
        
        CGFloat cmtH = 50;
        if (item.cmtItem.content.length) {
            CGFloat contentH = [item.cmtItem.totalContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
            cmtH = 28 + contentH;
        }
        self.cmtViewFrame = CGRectMake(0, self.cellH, screenW, cmtH);
        self.cellH = CGRectGetMaxY(self.cmtViewFrame) + margin;
    }
    
    //底部 view 的高度
    self.bottomViewFrame = CGRectMake(0, self.cellH, screenW, 40);
    self.cellH = CGRectGetMaxY(self.bottomViewFrame);
}
@end
