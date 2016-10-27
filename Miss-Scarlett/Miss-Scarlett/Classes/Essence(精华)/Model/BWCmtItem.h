//
//  BWCmtItem.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/27.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BWUserItem;

@interface BWCmtItem : NSObject

@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, strong) NSString *voicetime;
@property (nonatomic, strong) NSString *content;
@property (strong, nonatomic) BWUserItem *user;

@property (nonatomic, strong) NSString *totalContent;

@end
