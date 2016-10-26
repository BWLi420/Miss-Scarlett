//
//  BWTopicViewModel.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BWTopicItem;;
@interface BWTopicViewModel : NSObject

@property (strong, nonatomic) BWTopicItem *item;
@property (nonatomic, assign) CGRect topViewFrame;
@property (nonatomic, assign) CGRect middleViewFrame;
@property (nonatomic, assign) CGFloat cellH;

@end
