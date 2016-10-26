//
//  BWVoiceView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/26.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWVoiceView.h"
#import "BWTopicItem.h"

#import <UIImageView+WebCache.h>

@interface BWVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation BWVoiceView

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%@播放", item.playcount];
    self.timeLabel.text = [NSString stringWithFormat:@"%.0ld:%.0ld", item.videotime / 60, item.videotime % 60];
}

@end
