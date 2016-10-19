//
//  BWSubTagCell.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/19.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWSubTagItem;
@interface BWSubTagCell : UITableViewCell

@property (strong, nonatomic) BWSubTagItem *subTagItem;

+ (instancetype)subTagCell;
@end
