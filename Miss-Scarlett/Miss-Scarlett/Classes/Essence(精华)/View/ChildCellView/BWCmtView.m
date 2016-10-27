//
//  BWTextView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/26.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWCmtView.h"
#import "BWTopicItem.h"
#import "BWCmtItem.h"
#import "BWUserItem.h"

@interface BWCmtView ()
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation BWCmtView

/** 只要界面没有问题，但是莫名出现一些约束冲突，就取消系统的自动拉伸属性（iOS6） */
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    if (item.cmtItem.content.length) {
        //文字评论
        self.voiceView.hidden = YES;
        self.totalLabel.hidden = NO;
        
        self.totalLabel.text = item.cmtItem.totalContent;
    } else {
        //音频评论
        self.voiceView.hidden = NO;
        self.totalLabel.hidden = YES;
        
        self.nameLabel.text = item.cmtItem.user.username;
        [self.voiceButton setTitle:item.cmtItem.voicetime forState:UIControlStateNormal];
    }
}

@end
