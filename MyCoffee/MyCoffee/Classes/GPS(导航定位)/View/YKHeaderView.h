//
//  YKHeaderView.h
//  MyCoffee
//
//  Created by yk on 16/5/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKHeaderView : UIView

+ (instancetype)headerView;


@property (assign, nonatomic) double distance;

@property (strong, nonatomic) void(^block)();

@end
