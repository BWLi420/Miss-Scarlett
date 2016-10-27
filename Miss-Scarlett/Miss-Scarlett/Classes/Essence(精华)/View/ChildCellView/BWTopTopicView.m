//
//  BWTopTopicView.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWTopTopicView.h"
#import "BWTopicItem.h"
#import "NSDate+BWDate.h"

#import <UIImageView+WebCache.h>

@interface BWTopTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name_Label;
@property (weak, nonatomic) IBOutlet UILabel *time_Label;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@end

@implementation BWTopTopicView

- (IBAction)moreBtnClick:(UIButton *)sender {
    
    //弹框：方式一
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self];


//    //方式二
//    /*
//     UIAlertControllerStyleActionSheet = 0,默认样式，与 UIActionSheet 相同
//     UIAlertControllerStyleAlert
//     */
//    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
//    /*
//     UIAlertActionStyleDefault = 0,
//     UIAlertActionStyleCancel,
//     UIAlertActionStyleDestructive
//     */
//    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//         NSLog(@"点击取消调用");
//     }];
//    
//    [alertCon addAction:alertAct];
//    
//    //需要用控制器将 alertCon  modal 出来
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCon animated:YES completion:nil];
}

- (void)setItem:(BWTopicItem *)item {
    [super setItem:item];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name_Label.text = item.screen_name;
    self.text_Label.text = item.text;
    //处理时间显示
    self.time_Label.text = [self timeStr];
}

//处理时间显示
- (NSString *)timeStr {
/*
今年
    今天
        >1 小时
            >= 1 分钟
            < 1分钟
                刚刚
     
        昨天
    昨天之前
非今年
 */
    // 2015-10-26 14:37:20
    NSString *str = self.item.create_time;
    
    // 发帖日期字符串 转 发帖日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 获取发帖日期对象
    NSDate *createDate = [fmt dateFromString:str];
    
    // 获取发帖日期与当前日期时间差值
    NSDateComponents *detalCmp = [createDate detalWithNow];
    
    // 判断
    if ([createDate isThisYear]) { // 今年
        
        if ([createDate isThisToday]) { // 今天
            
            if (detalCmp.hour >= 1) {
                
                str = [NSString stringWithFormat:@"%ld小时前",detalCmp.hour];
                
            } else if (detalCmp.minute >= 1) {
                
                str = [NSString stringWithFormat:@"%ld分钟前",detalCmp.minute];
                
            } else { // 刚刚
                str = @"刚刚";
            }
            
        } else if ([createDate isThisYesterday]) { // 昨天  昨天 14:30
            fmt.dateFormat = @"昨天 HH:mm";
            str = [fmt stringFromDate:createDate];
            
        } else { // 昨天之前 10-23 14:37:20
            
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            str = [fmt stringFromDate:createDate];
        }
        
    }
    
    return str;
}

@end
