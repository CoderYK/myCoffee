//
//  UIButton+animation.h
//  MyCoffee
//
//  Created by yk on 16/5/10.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (animation)


/**
 *  动画跳转
 *
 *  @param viewController 需要跳转的控制器
 */
- (void)pushWithAnimations:(UIViewController *)viewController navigationController:(UINavigationController *)navigationController;

@end
