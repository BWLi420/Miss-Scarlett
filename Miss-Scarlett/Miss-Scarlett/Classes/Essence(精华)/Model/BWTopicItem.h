//
//  BWTopicItem.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/25.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BWCmtItem;

typedef enum : NSInteger {
    BWTopicItemTypeAll = 1,
    BWTopicItemTypePicture = 10,
    BWTopicItemTypeVideo = 41,
    BWTopicItemTypeVocie = 31,
    BWTopicItemTypeText = 29
} BWTopicItemType;

@interface BWTopicItem : NSObject

/** TopView */
@property (nonatomic, strong) NSString *profile_image;
@property (nonatomic, strong) NSString *screen_name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *create_time;

/** middle 图片 */
@property (nonatomic, strong) NSString *image0;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL is_bigPicture;
@property (nonatomic, assign) BWTopicItemType type;

/** middle 视频 */
@property (nonatomic, strong) NSString *videouri;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, strong) NSString *playcount;

/** middle 声音 */
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, assign) NSInteger voicetime;

/** 最热评论 */
@property (strong, nonatomic) NSArray *top_cmt;
@property (strong, nonatomic) BWCmtItem *cmtItem;

@end
