//
//  BWCollectionViewCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/22.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWCollectionViewCell.h"
#import "BWCollectionItem.h"

#import <UIImageView+WebCache.h>

@interface BWCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation BWCollectionViewCell

- (void)setItem:(BWCollectionItem *)item {
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = item.name;
}

@end
