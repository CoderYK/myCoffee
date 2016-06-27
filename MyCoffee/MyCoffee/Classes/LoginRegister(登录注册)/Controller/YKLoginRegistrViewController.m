//
//  YKLoginRegistrViewController.m
//  BuDeJie
//
//  Created by yk on 16/4/28.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKLoginRegistrViewController.h"
#import "YKLoginRegisterView.h"
#import "YKFastLoginView.h"

@interface YKLoginRegistrViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConst;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

//思想:越是复杂的界面,越是要抽取出来...复用
@implementation YKLoginRegistrViewController

//此时控件的约束还没被执行
- (void)viewDidLoad {
    [super viewDidLoad];

    //添加登录 View:一个 View 从 XIB 加载,默认是等于 XIB 的尺寸的
    YKLoginRegisterView *loginView = [YKLoginRegisterView loginView];
    [_contentView addSubview:loginView];
    
    //添加注册 View
    YKLoginRegisterView *registerView = [YKLoginRegisterView registerView];
    [_contentView addSubview:registerView];
    
    //快速登录界面
    YKFastLoginView *fastLoginView = [YKFastLoginView fastLoginView];
    [_bottomView addSubview:fastLoginView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //设置登录 View 的 frame
    YKLoginRegisterView *loginView = _contentView.subviews[0];
    loginView.frame = CGRectMake(0, 0, _contentView.yk_width * 0.5, _contentView.yk_height);
    
    //设置注册 View 的 frame
    YKLoginRegisterView *registerView = _contentView.subviews[1];
    registerView.frame = CGRectMake(_contentView.yk_width * 0.5, 0, _contentView.yk_width * 0.5, _contentView.yk_height);
    
    //设置快来登录界面尺寸
    YKFastLoginView *fastLoginView = _bottomView.subviews[0];
    fastLoginView.frame = _bottomView.bounds;
}

//点击屏幕时退出键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//点击关闭按钮
- (IBAction)dismiss {
    //退出立即登录界面
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击注册按钮
- (IBAction)register:(UIButton *)sender {
    sender.selected = !sender.selected;
    
//    _contentView.yk_x = YKScreenW;
    //修改中间 View 的约束
    _leftConst.constant = _leftConst.constant == 0 ? -YKScreenW : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}





@end
