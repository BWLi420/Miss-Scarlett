//
//  BWCmtItem.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/27.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWCmtItem.h"
#import "BWUserItem.h"

@implementation BWCmtItem

- (NSString *)totalContent {
    return [NSString stringWithFormat:@"%@:%@", self.user.username, self.content];
}

@end
