//
//  NSDate+BWDate.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/27.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BWDate)

- (BOOL)isThisYear;

- (BOOL)isThisToday;

- (BOOL)isThisYesterday;

- (NSDateComponents *)detalWithNow;

@end
