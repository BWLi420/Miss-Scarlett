//
//  BWCollectionViewCell.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/22.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWCollectionItem;

@interface BWCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) BWCollectionItem *item;

@end
