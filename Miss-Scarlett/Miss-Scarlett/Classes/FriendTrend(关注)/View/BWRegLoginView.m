//
//  BWRegLoginView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/20.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWRegLoginView.h"

@interface BWRegLoginView ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation BWRegLoginView

+ (instancetype)regLoginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

//修复登录按钮的北京图片拉伸问题
- (void)awakeFromNib {
    
    //加载 xib 完成的时候调用，给 xib 里面的属性赋值
    [super awakeFromNib];
    
    UIImage *image = self.loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

//只要从文件加载就会调用，此时很多属性还没有设置
/**
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
 */

@end
