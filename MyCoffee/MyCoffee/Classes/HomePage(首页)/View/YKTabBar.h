//
//  YKTabBar.h
//  MyCoffee
//
//  Created by yk on 16/5/10.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKTabBar : UITabBar

@property (strong, nonatomic) void(^pushBlock)();

@end
