//
//  YKNewsViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/13.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKNewsViewController.h"
#import <WebKit/WebKit.h>

@interface YKNewsViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation YKNewsViewController

- (WKWebView *)webView
{
    if (_webView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [_contentView addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.layer.contents = (id)[UIImage imageNamed:@"info_bg"].CGImage;
    
    //标题
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName:YKMyCoffeeColor,
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:20 weight:14]
                                                                    };
    

    //监听网页加载进度
    [self loadingProgress];
    
    self.toolBar.hidden = _isToolbarHidden;
    self.toolBar.tintColor = YKMyCoffeeColor;
    
    if (_isToolbarHidden) return;

    self.webView.scrollView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //展示最新消息
    [self showWebView];
}

#pragma mark -------------------
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.toolBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.toolBar.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.navigationController.navigationBarHidden = NO;
    });
}

//当控制器销毁时一定要移除监听
-(void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView.scrollView.delegate = nil;
}

//监听网页加载进度
- (void)loadingProgress
{
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

//属性发生改变时就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.progressView.hidden = _webView.estimatedProgress >= 1;
    self.progressView.progress = _webView.estimatedProgress;
}
//展示最新消息
- (void)showWebView
{
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark -------------------
#pragma mark Events
//后退
- (IBAction)backward:(id)sender {
    [_webView goBack];
}
//前进
- (IBAction)forward:(id)sender {
    [_webView goForward];
}
//刷新
- (IBAction)reload:(id)sender {
    [_webView reload];
}


@end
