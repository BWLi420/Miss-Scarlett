//
//  BWSubTagCell.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/19.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSubTagCell.h"
#import "BWSubTagItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+BWImage.h"

@interface BWSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;

@end

@implementation BWSubTagCell

+ (instancetype)subTagCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

//当 cell 要显示的时候，系统会自动调用 setFrame，给 cell 设置尺寸和位置
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

- (void)setSubTagItem:(BWSubTagItem *)subTagItem {
    
    _subTagItem = subTagItem;
    
    self.nameLable.text = subTagItem.theme_name;
    
    //处理订阅数字
    CGFloat num = [subTagItem.sub_number floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%.0f人订阅", num];
    if (num > 10000) {
        num = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.2f万人订阅", num];
        //不显示结果后面的 .00 
        numStr = [numStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    self.numLable.text = numStr;
    
    //下载网络图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //裁剪设置圆形图像
        UIImage *newImage = [UIImage imageWithBorderW:0 borderColor:nil image:image];
        
        self.iconView.image = newImage;
    }];
    
}
@end
