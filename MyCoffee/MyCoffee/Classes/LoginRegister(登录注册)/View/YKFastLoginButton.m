//
//  YKFastLoginButton.m
//  BuDeJie
//
//  Created by yk on 16/4/28.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKFastLoginButton.h"

@implementation YKFastLoginButton

-(void)layoutSubviews
{
    //计算子控件的位置
    [super layoutSubviews];
    
    self.imageView.yk_x = (self.yk_width - self.imageView.yk_width) * 0.5;
    self.imageView.yk_y = 0;
    
    //设置文字的位置
    [self.titleLabel sizeToFit];
    self.titleLabel.yk_x = (self.yk_width - self.titleLabel.yk_width) * 0.5;
    self.titleLabel.yk_y = self.yk_height - self.titleLabel.yk_height;

}

@end
