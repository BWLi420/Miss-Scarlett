//
//  BWTopicItem.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWTopicItem : NSObject

/** TopView */
@property (nonatomic, strong) NSString *profile_image;
@property (nonatomic, strong) NSString *screen_name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, assign) CGRect topViewFrame;
@property (nonatomic, assign) CGFloat cellH;

@end
