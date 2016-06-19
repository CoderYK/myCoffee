//
//  YKTopLoginView.m
//  MyCoffee
//
//  Created by yk on 16/5/6.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKTopLoginView.h"
#import "YKLoginRegistrViewController.h"

@implementation YKTopLoginView

+ (instancetype)topLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (IBAction)loginRegistrBtnClick {
    
    YKLoginRegistrViewController *LoginRegistrVc = [[YKLoginRegistrViewController alloc] init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:LoginRegistrVc animated:YES completion:nil];
}

@end
