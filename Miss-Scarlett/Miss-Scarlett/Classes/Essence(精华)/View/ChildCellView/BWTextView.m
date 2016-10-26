//
//  BWTextView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/26.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTextView.h"
#import "BWTopicItem.h"

@interface BWTextView ()
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation BWTextView

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    
}

@end
