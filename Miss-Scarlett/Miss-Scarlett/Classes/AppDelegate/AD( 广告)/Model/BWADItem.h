//
//  BWADItem.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/18.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWADItem : NSObject

/**      w_picurl   curl   w   h     */

@property (strong, nonatomic) NSString *curl;
@property (strong, nonatomic) NSString *w_picurl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end
