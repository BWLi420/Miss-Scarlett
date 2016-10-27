//
//  BWBottomView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/27.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWBottomView.h"
#import "BWTopicItem.h"

@interface BWBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@end

@implementation BWBottomView

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    [self setBtn:self.dingBtn count:item.ding defaultTitle:@"赞"];
    [self setBtn:self.caiBtn count:item.cai defaultTitle:@"踩"];
    [self setBtn:self.shareBtn count:item.repost defaultTitle:@"分享"];
    [self setBtn:self.commentBtn count:item.comment defaultTitle:@"评论"];
}

- (void)setBtn:(UIButton *)btn count:(CGFloat)count defaultTitle:(NSString *)defaultTitle {
    
    NSString *str = defaultTitle;
    if (count >= 10000) {
        count = count / 10000.0;
        str = [NSString stringWithFormat:@"%.1f万", count];
    }else if (count > 0) {
        str = [NSString stringWithFormat:@"%.0f", count];
    }
    
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    [btn setTitle:str forState:UIControlStateNormal];
}

@end
