//
//  YKMenuViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/10.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKMenuViewController.h"
#import "YKCoffeeViewController.h"
#import "YKMilkViewController.h"
#import "YKChocolateViewController.h"

@interface YKMenuViewController ()

@end

@implementation YKMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最新菜单";
    
    //添加子控制器
    [self addAllChildViewController];
}

//添加子控制器
- (void)addAllChildViewController
{
    //咖啡
    YKCoffeeViewController *coffeeVc = [[YKCoffeeViewController alloc] init];
    coffeeVc.title = @"咖啡";
    [self addChildViewController:coffeeVc];
    
    //牛奶
    YKMilkViewController *milkVc = [[YKMilkViewController alloc] init];
    milkVc.title = @"牛奶";
    [self addChildViewController:milkVc];
    
    //巧克力
    YKChocolateViewController *chocolateVc = [[YKChocolateViewController alloc] init];
    chocolateVc.title = @"巧克力";
    [self addChildViewController:chocolateVc];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
