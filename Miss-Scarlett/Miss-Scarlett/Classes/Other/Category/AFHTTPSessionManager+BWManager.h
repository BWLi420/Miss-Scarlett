//
//  AFHTTPSessionManager+BWManager.h
//  Miss-Scarlett
//
//  Created by mortal on 16/10/18.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (BWManager)

/** 重写框架的 manger 方法，添加数据支持格式 */
+ (instancetype)BWMangeer;
@end
