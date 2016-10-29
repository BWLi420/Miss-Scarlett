//
//  BWSettingTabVC.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/16.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWSettingTabVC.h"
#import "BWFileManager.h"

#import <SDImageCache.h>
#import <SVProgressHUD.h>

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
}

//更改清除缓存的 cell 可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath == [NSIndexPath indexPathForRow:0 inSection:1]) {
        [BWFileManager directorySizeString:CACHEPATH completion:^(NSString *str) {
            self.cacheLabel.text = str;
        }];
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
            [BWFileManager removeDirectoryPath:CACHEPATH];
            [self.tableView reloadData];
            
            [SVProgressHUD dismiss];
        });
    }
}

@end
