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

- (void)setSubTagItem:(BWSubTagItem *)subTagItem {
    
    _subTagItem = subTagItem;
    
    self.nameLable.text = subTagItem.theme_name;
    self.numLable.text = [NSString stringWithFormat:@"订阅量:%@",subTagItem.sub_number];
    
    //下载网络图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //裁剪设置圆形图像
        UIImage *newImage = [UIImage imageWithBorderW:0 borderColor:nil image:image];
        
        self.iconView.image = newImage;
    }];
    
}
@end
