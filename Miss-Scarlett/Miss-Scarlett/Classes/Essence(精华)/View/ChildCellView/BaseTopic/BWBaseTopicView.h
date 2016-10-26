//
//  BWBaseTopicView.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWTopicItem;
@interface BWBaseTopicView : UIView
@property (strong, nonatomic) BWTopicItem *item;

+ (instancetype)viewForXib;

@end
