//
//  UIView+YKView.m
//  LuckyDog
//
//  Created by yk on 16/3/27.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "UIView+YKView.h"

@implementation UIView (YKView)

-(CGFloat)yk_x
{
    return self.frame.origin.x;
}

-(CGFloat)yk_y
{
    return self.frame.origin.y;
}

-(CGFloat)yk_width
{
    return self.frame.size.width;
}

-(CGFloat)yk_height
{
    return self.frame.size.height;
}

-(void)setYk_x:(CGFloat)yk_x
{
    CGRect frame = self.frame;
    frame.origin.x = yk_x;
    self.frame = frame;
}

-(void)setYk_y:(CGFloat)yk_y
{
    CGRect frame = self.frame;
    frame.origin.y = yk_y;
    self.frame = frame;
}

-(void)setYk_width:(CGFloat)yk_width
{
    CGRect frame = self.frame;
    frame.size.width = yk_width;
    self.frame = frame;
}

-(void)setYk_height:(CGFloat)yk_height
{
    CGRect frame = self.frame;
    frame.size.height = yk_height;
    self.frame = frame;
}

-(void)setYk_centerX:(CGFloat)yk_centerX
{
    CGPoint center = self.center;
    center.x = yk_centerX;
    self.center = center;
}

-(CGFloat)yk_centerX
{
    return self.center.x;
}

-(void)setYk_centerY:(CGFloat)yk_centerY
{
    CGPoint center = self.center;
    center.y = yk_centerY;
    self.center = center;
}

-(CGFloat)yk_centerY
{
    return self.center.y;
}


@end
