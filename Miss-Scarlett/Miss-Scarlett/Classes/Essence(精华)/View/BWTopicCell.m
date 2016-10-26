//
//  BWTopicCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopicCell.h"
#import "BWTopicViewModel.h"
#import "BWTopicItem.h"

#import "BWTopTopicView.h"
#import "BWPictureView.h"
#import "BWVideoView.h"
#import "BWVoiceView.h"

@interface BWTopicCell ()
@property (strong, nonatomic) BWTopTopicView *topView;
@property (strong, nonatomic) BWPictureView *pictureView;
@property (strong, nonatomic) BWVideoView *videoView;
@property (strong, nonatomic) BWVoiceView *voiceView;
@end

@implementation BWTopicCell

//使用 cell 时必然要通过 initWithStyle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置顶部 TopView 的内容
        BWTopTopicView *topView = [BWTopTopicView viewForXib];
        [self.contentView addSubview:topView];
        self.topView = topView;
        
        //设置中间 图片
        BWPictureView *pictureView = [BWPictureView viewForXib];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
        //设置中间视频
        BWVideoView *videoView = [BWVideoView viewForXib];
        [self.contentView addSubview:videoView];
        self.videoView = videoView;
        
        //设置中间声音
        BWVoiceView *voiceView = [BWVoiceView viewForXib];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
    }
    return self;
}

- (void)setTopicVM:(BWTopicViewModel *)topicVM {
    
    _topicVM = topicVM;
    
    //顶部 topView
    self.topView.item = topicVM.item;
    self.topView.frame = topicVM.topViewFrame;
    
    //中间 middleView
    if (topicVM.item.type == BWTopicItemTypePicture) {
        
        //中间 图片
        self.pictureView.item = topicVM.item;
        self.pictureView.frame = topicVM.middleViewFrame;
        
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if(topicVM.item.type == BWTopicItemTypeVideo) {
        
        //中间 视频
        self.videoView.item = topicVM.item;
        self.videoView.frame = topicVM.middleViewFrame;
        
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topicVM.item.type == BWTopicItemTypeVocie) {
        
        //中间 声音
        self.voiceView.item = topicVM.item;
        self.voiceView.frame = topicVM.middleViewFrame;
        
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

@end
