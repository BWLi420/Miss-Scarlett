//
//  BWPictureView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWPictureView.h"
#import "BWTopicItem.h"

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface BWPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@end

@implementation BWPictureView

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        if (expectedSize == -1) return ;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        [SVProgressHUD showProgress:progress];
        if (progress == 1.0) {
            [SVProgressHUD dismiss];
        }
        
    } completed:nil];
    self.gifView.hidden = !item.is_gif;
    
    //大图处理
    self.seeBigButton.hidden = !item.is_bigPicture;
    if (item.is_bigPicture) {
        self.pictureView.contentMode = UIViewContentModeTop;
        self.pictureView.clipsToBounds = YES;
    }else {
        self.pictureView.contentMode = UIViewContentModeScaleToFill;
        self.pictureView.clipsToBounds = NO;
    }
}

@end
