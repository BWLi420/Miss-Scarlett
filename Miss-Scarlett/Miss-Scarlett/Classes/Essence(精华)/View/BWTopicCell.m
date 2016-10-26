//
//  BWTopicCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopicCell.h"
#import "BWTopicViewModel.h"

#import "BWTopTopicView.h"
#import "BWPictureView.h"

@interface BWTopicCell ()
@property (strong, nonatomic) BWTopTopicView *topView;
@property (strong, nonatomic) BWPictureView *pictureView;
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
        
    }
    return self;
}

- (void)setTopicVM:(BWTopicViewModel *)topicVM {
    
    _topicVM = topicVM;
    
    //顶部 topView
    self.topView.item = topicVM.item;
    self.topView.frame = topicVM.topViewFrame;
    
    //中间 图片
    self.pictureView.item = topicVM.item;
    self.pictureView.frame = topicVM.middleViewFrame;
}

@end
