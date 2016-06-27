//
//  YKFastLoginView.m
//  BuDeJie
//
//  Created by yk on 16/4/28.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKFastLoginView.h"
#import "UMSocial.h"
#import "YKMainViewController.h"

@implementation YKFastLoginView

+ (instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YKFastLoginView" owner:nil options:nil] firstObject];
}

- (IBAction)wbLogin {
    
    // 1.创建UMSocialSnsPlatform对象
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 2.第三方登录
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            // 登录成功
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}
@end
