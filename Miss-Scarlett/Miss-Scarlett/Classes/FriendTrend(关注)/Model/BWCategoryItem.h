//
//  BWCategoryItem.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/30.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWCategoryItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
/** 保存已加载的对应右边的信息 */
@property (strong, nonatomic) NSMutableArray *users;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total_page;

@end
