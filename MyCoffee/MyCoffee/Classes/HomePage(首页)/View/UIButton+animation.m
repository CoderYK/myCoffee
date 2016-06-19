//
//  UIButton+animation.m
//  MyCoffee
//
//  Created by yk on 16/5/10.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "UIButton+animation.h"

@implementation UIButton (animation)

//动画跳转
- (void)pushWithAnimations:(UIViewController *)viewController navigationController:(UINavigationController *)navigationController
{
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 50, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [navigationController pushViewController:viewController animated:YES];
        }];
    }];
}

@end
