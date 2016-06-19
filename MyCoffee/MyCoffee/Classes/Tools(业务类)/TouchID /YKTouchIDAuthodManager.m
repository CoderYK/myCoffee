//
//  YKTouchIDAuthodManager.m
//  MyCoffee
//
//  Created by yk on 16/5/18.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKTouchIDAuthodManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation YKTouchIDAuthodManager

+ (void)authodYourTouchIDCompleted:(void (^)(void))completedBlock
{
    //创建LAContext实例对象，用于执行认证政策
    LAContext *context = [[LAContext alloc] init];
    NSError *errorMessage = nil;
    
    BOOL isAvailable = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&errorMessage];
    
    if (isAvailable) {
        //touchID 可用
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"认证您的 touchID 进行支付" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                [SVProgressHUD showSuccessWithStatus:@"验证成功正在支付..."];
                
                //回到主线程刷新 UI
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        completedBlock();
                    });
                
            } else if(error.code == -2) //点击取消按钮 code == -2
            {
                return ;
            } else if (error.code == -3) //点击输入密码按钮 code == -3
            {
                return;
            }
            
        }];
    }
}

@end
