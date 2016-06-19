//
//  YKSuccessViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKSuccessViewController.h"
#import "YKEverBuyViewController.h"

@interface YKSuccessViewController ()

@end

@implementation YKSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付成功";
}
- (IBAction)backToMyRecored {
    
    [self.navigationController pushViewController:[[YKEverBuyViewController alloc] init]
                                         animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
