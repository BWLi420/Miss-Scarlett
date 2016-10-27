//
//  BWPictureView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWPictureView.h"
#import "BWTopicItem.h"
#import "BWSeeBigViewController.h"

#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

@interface BWPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation BWPictureView

//点击查看大图
- (IBAction)seeBigButtonClick:(UIButton *)sender {
    BWSeeBigViewController *bigVC = [[BWSeeBigViewController alloc] init];
    bigVC.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigVC animated:YES completion:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progressView.progressTintColor = [UIColor whiteColor];
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    self.progressView.roundedCorners = 10;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    self.progressView.progress = 0;
    self.progressView.progressLabel.text = @"0%";
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (expectedSize == -1) return ;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        NSString *progressStr = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.progressView.progressLabel.text = progressStr;
            self.progressView.progress = progress;
        });
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
