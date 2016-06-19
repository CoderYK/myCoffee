//
//  YKMyResumeViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/13.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKMyResumeViewController.h"
#import "YKNewsViewController.h"

#define YKBlogUrl @"http://www.cnblogs.com/coderYK/"
#define YKGithubUrl @"https://github.com/CoderYK"

@interface YKMyResumeViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) YKNewsViewController *webViewVc;

@end

@implementation YKMyResumeViewController

#pragma mark -------------------
#pragma mark lazy loading
- (YKNewsViewController *)webViewVc
{
    if (_webViewVc == nil) {
       _webViewVc = [[YKNewsViewController alloc] init];      
    }
    return _webViewVc;
}

#pragma mark -------------------
#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置头像的圆角半径
    self.iconView.layer.cornerRadius = self.iconView.yk_width *0.5;
    
    [self setUpbackButton];
    
    self.title = @"个人详情";
}

//跳转到个人博客网页
- (IBAction)bolgClick {
    self.webViewVc.title = @"个人博客";
    self.webViewVc.urlStr = YKBlogUrl;
    [self.navigationController pushViewController:self.webViewVc animated:YES];
}

//跳转到个人GitHub网页
- (IBAction)githubClick {
    self.webViewVc.title = @"Github";
    self.webViewVc.urlStr = YKGithubUrl;
    [self.navigationController pushViewController:self.webViewVc animated:YES];
}
//打电话
- (IBAction)callMe {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否允许应用程序拨打电话" message:@"将有可能产生一定资费" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alertView show];
}

#pragma mark -------------------
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13600386308"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
