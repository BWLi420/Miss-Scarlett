//
//  BWCategoryCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/30.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWCategoryCell.h"
#import "BWCategoryItem.h"

@interface BWCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation BWCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //取消选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(BWCategoryItem *)item {
    _item = item;
    
    self.contentLabel.text = item.name;
}

//当 cell 被选中或取消选中的时候调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //被选中时不隐藏
    self.redView.hidden = !self.selected;
    //修改文字颜色
//    if (self.selected) {
//        
//        self.contentLabel.textColor = [UIColor redColor];
//    }else {
//        self.contentLabel.textColor = [UIColor blackColor];
//    }
    self.contentLabel.textColor = self.selected ? [UIColor redColor] : [UIColor blackColor];
}

@end
