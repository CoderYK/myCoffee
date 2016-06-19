//
//  YKFastLoginView.m
//  BuDeJie
//
//  Created by yk on 16/4/28.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKFastLoginView.h"

@implementation YKFastLoginView

+ (instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YKFastLoginView" owner:nil options:nil] firstObject];
}

@end
