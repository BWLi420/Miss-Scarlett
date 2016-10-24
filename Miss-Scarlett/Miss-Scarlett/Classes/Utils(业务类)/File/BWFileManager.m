//
//  BWFileManager.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/24.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWFileManager.h"

@implementation BWFileManager

+ (NSInteger)getDirectorySize:(NSString *)directoryPath {
    //创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL isExists = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExists || !isDirectory) {
        //报错，抛异常
        NSException *exception = [NSException exceptionWithName:@"Error" reason:@"传入的路径不存在，或不是文件夹路径" userInfo:nil];
        [exception raise];
    }
    
    //获取文件夹下的所有子路径
    NSArray *subPaths = [manager subpathsAtPath:directoryPath];
    //遍历
    NSInteger totalSize = 0;
    for (NSString *subPath in subPaths) {
        //得到文件的全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        //判断是否是隐藏文件
        if ([filePath containsString:@".DS"]) {
            continue;
        }
        //判断是否是文件夹
        BOOL isDirectory = NO;
        BOOL isExists = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExists || isDirectory) {
            continue;
        }
        //获取文件属性
        NSDictionary *fileAttr = [manager attributesOfItemAtPath:filePath error:nil];
        
        //累加文件的大小
        totalSize += [fileAttr fileSize];
    }
    return totalSize;
}

+ (void)removeDirectoryPath:(NSString *)directoryPath {
    
    //创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL isExists = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExists || !isDirectory) {
        //报错，抛异常
        @throw [NSException exceptionWithName:@"Error" reason:@"传入的路径不存在，或不是文件夹路径" userInfo:nil];
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}


+ (NSString *)directorySizeString:(NSString *)directoryPath {
    NSString *str = @"清除缓存";
    NSInteger size = [self getDirectorySize:directoryPath];
    
    if (size > 1000 * 1000) {
        CGFloat num = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)", str, num];
    }else if (size > 1000) {
        CGFloat num = size / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fKB)", str, num];
    }else if (size > 0) {
        str = [NSString stringWithFormat:@"%@(%ldB)", str, size];
    }
    
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    return str;
}
@end
