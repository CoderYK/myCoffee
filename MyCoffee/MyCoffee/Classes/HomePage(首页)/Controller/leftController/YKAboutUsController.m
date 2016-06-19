//
//  YKAboutUsController.m
//  MyCoffee
//
//  Created by yk on 16/5/6.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKAboutUsController.h"
#import "YKLoginRegistrViewController.h"
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>

#define urlStr @"http://mp.weixin.qq.com/s?__biz=MzIwMTc0NDgwNw==&mid=100000154&idx=1&sn=f7db88e4279564c9c44185c71d77b0f5&scene=18#wechat_redirect"

@interface YKAboutUsController ()

@property (weak, nonatomic) WKWebView *webView;
@property (strong, nonatomic) AVPlayer *player;

@end

@implementation YKAboutUsController

#pragma mark -------------------
#pragma mark lozy loading
- (WKWebView *)webView
{
    if (_webView == nil) {
       WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView = webView;
        [self.view addSubview:webView];
        
    }
    return _webView;
}

#pragma mark -------------------
#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    [self setUpbackButton];
    
    //展示网页
    [self loadWebView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //加载音乐
    [self playMusic];
}

//加载音乐
- (void)playMusic
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Shelby Lynne - I Only Want To Be With You" withExtension:@"mp3"];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
    _player = player;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [player play];
    });
}
//展示网页
- (void)loadWebView
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)postNote
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"home" object:nil];
}

//设置返回按钮样式
- (void)setUpbackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState: UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];

    [backButton setTitleColor:YKMyCoffeeColor forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(postNote) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton sizeToFit];
    
    //左移按钮
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

@end
