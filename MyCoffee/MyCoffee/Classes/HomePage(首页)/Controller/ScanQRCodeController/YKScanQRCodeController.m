//
//  YKScanQRCodeController.m
//  MyCoffee
//
//  Created by yk on 16/5/13.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKScanQRCodeController.h"
#import <WebKit/WebKit.h>
#import "YKTouchIDAuthodManager.h"
#import "YKSuccessViewController.h"

@interface YKScanQRCodeController ()<UIAlertViewDelegate>

@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) UILabel *messageLabel;

@end

@implementation YKScanQRCodeController

#pragma mark -------------------
#pragma mark lazy loading
- (WKWebView *)webView
{
    if (_webView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView = webView;
        [self.view addSubview:webView];
    }
    return _webView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        UILabel *messageLabel = [[UILabel alloc] init];
        _messageLabel = messageLabel;
        _messageLabel.numberOfLines = 0;
        _messageLabel.adjustsFontSizeToFitWidth = YES;
        _messageLabel.frame = CGRectMake(0, 0, 300, 30);
        _messageLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:messageLabel];

    }
    return _messageLabel;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //扫描成功后跳转到到webView 或者展示信息
    [self showMessage];
    
}
//展示二维码信息
- (void)showMessage
{
    //先判断 message 的类型
    if ([_message containsString:@"http://"]) {
        //提示用户是否允许访问网页
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否允许 App 访问网页？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"允许", nil];
        [alertView show];
    } else
    {

        typeof(self)weakSelf = self;
        //弹出指纹认证
        [YKTouchIDAuthodManager authodYourTouchIDCompleted:^{
            
            [weakSelf.navigationController pushViewController:[[YKSuccessViewController alloc] init] animated:YES];
        }];
    }

}

#pragma mark -------------------
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        NSURL *url = [NSURL URLWithString:_message];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:req];
    } else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
