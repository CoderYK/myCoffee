//
//  YKImageView.m
//  MyCoffee
//
//  Created by yk on 16/5/18.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKImageView.h"
#import "YKBigPictureViewController.h"

@implementation YKImageView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YKBigPictureViewController *pictureVc= [[YKBigPictureViewController alloc] init];
    pictureVc.image = self.image;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVc animated:YES completion:nil];
}

@end
