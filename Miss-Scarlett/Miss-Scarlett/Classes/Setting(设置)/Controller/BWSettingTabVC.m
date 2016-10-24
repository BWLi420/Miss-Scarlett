//
//  BWSettingTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSettingTabVC.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define CACHEPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface BWSettingTabVC ()

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@end

@implementation BWSettingTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //调整 cell 的间隔
    self.tableView.sectionFooterHeight = 0;
//    NSLog(@"%f", self.tableView.sectionHeaderHeight);  18
    self.tableView.contentInset = UIEdgeInsetsMake(-18, 0, 0, 0);
    
    //计算缓存的大小
    //SDWebImage 自动做缓存 ： 1.内存缓存 2.磁盘缓存
//    NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];
//    
//    NSLog(@"%@", [self sizeStr]);
}

// 计算当前缓存尺寸 => 缓存到沙盒里面 => 计算沙盒文件夹里面尺寸
/*
 获取文件夹尺寸 => 遍历文件夹所有文件，把文件尺寸累加
 
 1.创建文件管理者
 2.获取文件夹路径
 3.获取文件夹里面所有子路径
 4.遍历所有子路径
 5.拼接 文件全路径
 6.attributesOfItemAtPath: 指定文件全路径，就能获取文件属性
 7.获取文件尺寸
 8.累加
 */
- (NSInteger)getCacheSize {
    //获取 cache 文件夹路径
    NSString *cachePath = CACHEPATH;
    //创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //获取文件夹下的所有子路径
    NSArray *subPaths = [manager subpathsAtPath:cachePath];
//    NSLog(@"%@", subPaths);
    //遍历
    NSInteger totalSize = 0;
    for (NSString *subPath in subPaths) {
        //得到文件的全路径
        NSString *filePath = [cachePath stringByAppendingPathComponent:subPath];
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

//清除当前缓存
- (void)clearDiskCache {
    [[NSFileManager defaultManager] removeItemAtPath:CACHEPATH error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:CACHEPATH withIntermediateDirectories:YES attributes:nil error:nil];
}

//拼接内容
- (NSString *)sizeStr {
    NSString *str = @"清除缓存";
    NSInteger size = [self getCacheSize];
    
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

//更改清除缓存的 cell 可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath == [NSIndexPath indexPathForRow:0 inSection:1]) {
        self.cacheLabel.text = [self sizeStr];
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath == [NSIndexPath indexPathForRow:0 inSection:1]) {
        [SVProgressHUD showWithStatus:@"正在努力清理中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //清除缓存
            //方式一：
            //        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            //            [self.tableView reloadData];
            //        }];
            
            //方式二：
            [self clearDiskCache];
            [self.tableView reloadData];
            
            [SVProgressHUD dismiss];
        });
    }
}

@end
