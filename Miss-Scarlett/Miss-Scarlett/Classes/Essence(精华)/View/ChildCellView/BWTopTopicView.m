//
//  BWTopTopicView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopTopicView.h"
#import "BWTopicItem.h"

#import <UIImageView+WebCache.h>

@interface BWTopTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name_Label;
@property (weak, nonatomic) IBOutlet UILabel *time_Label;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@end

@implementation BWTopTopicView

+ (instancetype)viewForXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setItem:(BWTopicItem *)item {
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name_Label.text = item.screen_name;
    self.time_Label.text = item.create_time;
    self.text_Label.text = item.text;
}

@end
