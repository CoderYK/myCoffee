//
//  YKTabBarItem.m
//  MyCoffee
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKTabBarItem.h"


@implementation YKTabBarItem

-(void)awakeFromNib
{
    NSDictionary *attrDict = @{
                               NSForegroundColorAttributeName:YKMyCoffeeColor,
                               NSFontAttributeName:[UIFont systemFontOfSize:13]
                               };
    [self setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    
    
}


@end
