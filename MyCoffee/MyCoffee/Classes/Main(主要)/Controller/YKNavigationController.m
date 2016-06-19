//
//  YKNavigationController.m
//  MyCoffee
//
//  Created by yk on 16/5/6.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKNavigationController.h"
#import "UIImage+Image.h"

@interface YKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.tintColor = YKMyCoffeeColor;
    
    //添加 pan 手势实现全屏滑动返回
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    //禁用边缘侧滑返回手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    pan.delegate = self;
    
    //修改
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:239 / 255.0 green:215/255.0 blue:137/255.0 alpha:1]];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //设置导航条内容
    [self setupNavBar];
}

- (void)setupNavBar
{
    self.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName:YKMyCoffeeColor,
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:20 weight:14]
                                                                    };
}

#pragma mark -------------------
#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //根控制器为 NO, 非根控制器为 YES
    return self.childViewControllers.count > 1;
}

//统一设置返回按钮,当非跟控制器被push 时,修改返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //非根控制器才需要修改,根控制器被 push 时,导航控制器的子控制器还没有值,所有不能通过数组取值的方式,否则就会数组越界
    if (self.childViewControllers.count) {
        //设置返回按钮样式
        [self setUpbackButton:viewController];
        
        //隐藏底部条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //注意:需要早 push 之前修改
    [super pushViewController:viewController animated:animated];
}

//设置返回按钮样式
- (void)setUpbackButton:(UIViewController *)viewController
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState: UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setTitleColor:YKMyCoffeeColor forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton sizeToFit];
    
    //左移按钮
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

//点击返回按钮
- (void) back
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
