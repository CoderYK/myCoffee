//
//  AppDelegate.m
//  MyCoffee
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "AppDelegate.h"
#import "YKMainViewController.h"
#import "YKLoginViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "YKNavigationController.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"

static NSString * const AppKey = @"576fedcbe0f55a0de000572a";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化友盟 SDK
    [self setupAppID];
    

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    YKNavigationController *navigationController = [[YKNavigationController alloc] initWithRootViewController:[[YKMainViewController alloc] init]];
    
    YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:loginViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"slider_bg"];

    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    self.window.rootViewController = sideMenuViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupAppID
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:AppKey];
    
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1746772904"
                                              secret:@"c6022bb8495faf28a317ac5e69920169"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}



// 配置系统回调

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    
    [UMSocialSnsService  applicationDidBecomeActive];
}

@end
