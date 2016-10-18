//
//  BWADViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/18.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWADViewController.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import "BWADItem.h"
#import "BWTabBarController.h"

#define iPhone6p (screenH == 736)
#define iPhone6 (screenH == 667)
#define iPhone5 (screenH == 568)
#define iPhone4 (screenH == 480)
/** 参数 */
#define ADURL @"http://mobads.baidu.com/cpro/ui/mads.php"
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface BWADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 跳过按钮 */
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
/** 占位视图：当一个界面层次结构确定，但是其中某一个结构尺寸不确定 */
@property (weak, nonatomic) IBOutlet UIView *placeView;
/** 广告数据模型 */
@property (nonatomic, strong) BWADItem *adItem;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation BWADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //根据屏幕大小适应图片
    [self chooseImage];
    
    //网络请求广告数据
    //请求数据 => 接口文档 => AFN发送请求 => 解析数据 => 1.写成plist 2.在线解析 => 设计模型 => 字典转模型 => 直接把模型展示到界面
    [self getAD];
    
    //创建一个定时器，广告倒计时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDown) userInfo:nil repeats:YES];
}

//根据屏幕大小适应图片
- (void)chooseImage {
    
    if (iPhone6p) {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone4) {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

//网络请求广告数据
- (void)getAD {
    //创建会话管理者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager BWMangeer];
    //设置参数
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    parametersDict[@"code2"] = code2;
    //进行 GET 请求
    [manger GET:ADURL parameters:parametersDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取返回数据字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        //字典转模型
        self.adItem = [BWADItem mj_objectWithKeyValues:adDict];
        //下载 image
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW / self.adItem.w * screenH)];
        imageV.userInteractionEnabled = YES;
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.adItem.w_picurl] placeholderImage:nil];
        //将广告图片加到占位视图显示出来
        [self.placeView addSubview:imageV];
        
        //给图片添加点按手势，点按时跳转到广告界面
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesClick)];
        [imageV addGestureRecognizer:tapGes];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

//点按广告图片跳转到广告界面
- (void)tapGesClick {
    
    NSURL *adurl = [NSURL URLWithString:self.adItem.curl];
    if ([[UIApplication sharedApplication] canOpenURL:adurl]) {
        [[UIApplication sharedApplication] openURL:adurl];
    }
}

//广告倒计时
- (void)timerDown {
    static int count = 3;
    count --;
    
    if (count >= 0) {
        [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%i)", count] forState:UIControlStateNormal];
    } else {
        //销毁定时器，调整程序根控制器
        [self jumpBtnClick];
    }
}

//点击跳过按钮
- (IBAction)jumpBtnClick {
    //调整 tabBarVC 为程序的根控制器
    BWTabBarController *tabBarVC = [[BWTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
    //销毁定时器
    [self.timer invalidate];
}

@end
