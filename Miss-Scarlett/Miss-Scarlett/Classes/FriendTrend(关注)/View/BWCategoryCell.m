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

- (void)setItem:(BWCategoryItem *)item {
    _item = item;
    
    self.contentLabel.text = item.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
