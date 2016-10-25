//
//  BWTopicCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopicCell.h"
#import "BWTopTopicView.h"
#import "BWTopicItem.h"

@interface BWTopicCell ()
@property (strong, nonatomic) BWTopTopicView *topView;
@end

@implementation BWTopicCell

//使用 cell 时必然要通过 initWithStyle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置顶部 TopView 的内容
        BWTopTopicView *topView = [BWTopTopicView viewForXib];
        [self.contentView addSubview:topView];
        self.topView = topView;
        
    }
    return self;
}

- (void)setItem:(BWTopicItem *)item {
    
    _item = item;
    _topView.item = item;
}

@end
