//
//  BWADViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/18.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWADViewController.h"

#define iPhone6p (screenH == 736)
#define iPhone6 (screenH == 667)
#define iPhone5 (screenH == 568)
#define iPhone4 (screenH == 480)

@interface BWADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 跳过按钮 */
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
 /** 占位视图：当一个界面层次结构确定，但是其中某一个结构尺寸不确定 */
@property (weak, nonatomic) IBOutlet UIView *placeView;

@end

@implementation BWADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //根据屏幕大小适应图片
    [self chooseImage];
}

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

//点击跳过按钮
- (IBAction)jumpBtnClick {
    
}

@end
