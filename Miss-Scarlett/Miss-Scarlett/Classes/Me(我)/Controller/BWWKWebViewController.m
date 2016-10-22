//
//  BWWKWebViewController.m
//  Miss-Scarlett
//
//  Created by mortal on 16/10/22.
//  Copyright © 2016年 mortal. All rights reserved.
//

#import "BWWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface BWWKWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackBtnItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtnItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) WKWebView *wkWeb;
@end

@implementation BWWKWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    self.wkWeb = wkWeb;
    [self.contentView addSubview:wkWeb];
    
    //展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [wkWeb loadRequest:request];
    
    //KVO 监听属性的改变
    [wkWeb addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [wkWeb addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    //监听进度值
    [wkWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [wkWeb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

//只要监听的属性值改变就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    self.goBackBtnItem.enabled = self.wkWeb.canGoBack;
    self.forwardBtnItem.enabled = self.wkWeb.canGoForward;
    //设置进度值
    self.progressView.progress = self.wkWeb.estimatedProgress;
    self.progressView.hidden = self.wkWeb.estimatedProgress >= 1.0;
    //设置导航栏标题
    self.navigationItem.title = self.wkWeb.title;
}

//使用 KVO 必须移除观察者
- (void)dealloc {
    [self.wkWeb removeObserver:self forKeyPath:@"canGoBack"];
    [self.wkWeb removeObserver:self forKeyPath:@"canGoForward"];
    [self.wkWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWeb removeObserver:self forKeyPath:@"title"];
}

//回退
- (IBAction)goBack:(id)sender {
    [self.wkWeb goBack];
}

//前进
- (IBAction)forward:(id)sender {
    [self.wkWeb goForward];
}

//刷新
- (IBAction)refresh:(id)sender {
    [self.wkWeb reload];
}

@end
