//
//  BWUserCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/30.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWUserCell.h"
#import "BWUserDataItem.h"

#import <UIImageView+WebCache.h>
#import "UIImage+BWImage.h"

@interface BWUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;
@end

@implementation BWUserCell

- (void)setItem:(BWUserDataItem *)item {
    _item = item;
    
    self.nameLable.text = item.screen_name;
    
    //处理订阅数字
    CGFloat num = [item.fans_count floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%.0f人关注", num];
    if (num > 10000) {
        num = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.2f万人关注", num];
        //不显示结果后面的 .00
        numStr = [numStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    self.numLable.text = numStr;
    
    //下载网络图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //裁剪设置圆形图像
        UIImage *newImage = [UIImage imageWithBorderW:0 borderColor:nil image:image];
        
        self.iconView.image = newImage;
    }];

}

@end
