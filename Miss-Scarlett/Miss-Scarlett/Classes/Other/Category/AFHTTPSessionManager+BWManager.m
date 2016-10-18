//
//  AFHTTPSessionManager+BWManager.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/18.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "AFHTTPSessionManager+BWManager.h"

@implementation AFHTTPSessionManager (BWManager)

+ (instancetype)BWMangeer {
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    manger.responseSerializer = response;
    return manger;
}
@end
