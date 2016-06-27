//
//  YKMainViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKMainViewController.h"
#import "YKMenuViewController.h"
#import "YKEverBuyViewController.h"
#import "YKMyResumeViewController.h"
#import "YKMySumViewController.h"
#import "YKMenuViewController.h"
#import "YKTabBar.h"
#import "UIButton+animation.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import "YKScanQRCodeController.h"
#import "YKNewsViewController.h"
#import "YKMapViewController.h"
#define urlString @"http://mp.weixin.qq.com/s?__biz=MzIwMTc0NDgwNw==&mid=2247483700&idx=1&sn=36890c6ff28899fbabbd63ec66c4ab09&scene=2&srcid=0425CkYL8nfC4Au5ZkhzbplD&from=timeline&isappinstalled=0#wechat_redirect"

@interface YKMainViewController ()<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet YKTabBar *myBarbar;
@property (strong, nonatomic) NSMutableArray<UIViewController *> *pushControllers;
@property (strong, nonatomic) QRCodeReaderViewController *reader;

@end

@implementation YKMainViewController

- (void)Objective_C
{
    NSLog(@"hello Objective-C");
}

#pragma mark -------------------
#pragma mark lazy loading
-(NSMutableArray<UIViewController *> *)pushControllers
{
    if (_pushControllers == nil) {
        YKEverBuyViewController *everBuyVc = [[YKEverBuyViewController alloc] init];
        YKMyResumeViewController *contactUsVc = [[YKMyResumeViewController alloc] init];
        YKMySumViewController *mySumVc = [[YKMySumViewController alloc] init];
        YKMenuViewController *menuVc = [[YKMenuViewController alloc] init];
        _pushControllers = [NSMutableArray arrayWithObjects:everBuyVc,contactUsVc,mySumVc,menuVc, nil];
    }
    return _pushControllers;
}

#pragma mark -------------------
#pragma mark initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加导航条内容按钮
    [self addBarButtonItem];
    
    _myBarbar.delegate = self;
    
}

//添加左边按钮
- (void)addBarButtonItem
{
    //左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bar_1"] style:UIBarButtonItemStylePlain target:self action: @selector(presentLeftMenuViewController:)];
    
    //右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bar_2"] style:UIBarButtonItemStylePlain target:self action: @selector(scanQRCode)];
    
    //标题
    self.navigationItem.title = @"欢迎光临";
    
}

#pragma mark -------------------
#pragma mark Events
//菜单
- (IBAction)menuBtnClick:(UIButton *)sender {
    [sender pushWithAnimations:[[YKMenuViewController alloc] init] navigationController:self.navigationController];
}
//最新消息
- (IBAction)newsBtnClick:(UIButton *)sender {
    YKNewsViewController *vc = [[YKNewsViewController alloc] init];
    vc.urlStr = urlString;
    vc.title = @"最新消息";
    vc.isToolbarHidden = YES;
    [sender pushWithAnimations:vc navigationController:self.navigationController];
}
//导航定位
- (IBAction)GPSBtnClick:(UIButton *)sender {
    [sender pushWithAnimations:[[YKMapViewController alloc] init] navigationController:self.navigationController];
}

//点击 tabBarItem 跳转到指定控制器
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self.navigationController pushViewController:self.pushControllers[item.tag] animated:YES];
}

//点击扫描二维码
- (void)scanQRCode
{
    NSArray *types = @[AVMetadataObjectTypeQRCode];
    _reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
    
    typeof(self) weakSelf = self;
    [_reader setCompletionWithBlock:^(NSString *resultAsString) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            if (resultAsString) {
                YKScanQRCodeController *showMessageVc = [[YKScanQRCodeController alloc] init];
                showMessageVc.message = resultAsString;
                [weakSelf.navigationController pushViewController:showMessageVc animated:YES];
            }
            
        }];
    }];
    
    [self presentViewController:_reader animated:YES completion:NULL];
}





@end
