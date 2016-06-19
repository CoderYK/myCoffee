//
//  YKLoginRegisterView.m
//  BuDeJie
//
//  Created by yk on 16/4/28.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKLoginRegisterView.h"
#import <AFNetworking/AFNetworking.h>
#import "YKLoginTextField.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface YKLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) AFHTTPSessionManager *mgr;
@property (weak, nonatomic) IBOutlet YKLoginTextField *accoutTextField;
@property (weak, nonatomic) IBOutlet YKLoginTextField *pwdTextField;
@property (weak, nonatomic) IBOutlet YKLoginTextField *registerAccountTextField;
@property (weak, nonatomic) IBOutlet YKLoginTextField *registerPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation YKLoginRegisterView

#pragma mark -------------------
#pragma mark lazy loading
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

//从 XIB 加载完成时调用,只来一次
-(void)awakeFromNib
{
    //修改按钮的背景图不被拉伸,只需修改一次
    UIImage *image = _loginButton.currentBackgroundImage;
    
    //返回一张不被拉伸的图片
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    //重新设置按钮的背景图
    [_loginButton setBackgroundImage:image forState:UIControlStateNormal];
    
    //高亮状态
    image = [[_loginButton backgroundImageForState:UIControlStateHighlighted] stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [_loginButton setBackgroundImage:image forState:UIControlStateHighlighted];
    
}

#pragma mark -------------------
#pragma mark Events
//登录
- (IBAction)loginBtnClick {
    
    if (self.pwdTextField.text.length && self.accoutTextField.text.length) {
        [SVProgressHUD showWithStatus:@"正在登录..."];
    } else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入账号或密码"];
        return;
    }
    
    NSDictionary *parameters = @{
                                 @"password":self.pwdTextField.text,
                                 @"phone":self.accoutTextField.text
                                 };
    
    [self.mgr POST:YKBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        
    }];
}
//获取验证码
- (IBAction)getCodeClick:(id)sender {
    
    if (self.registerAccountTextField.text.length == 11) {
        [SVProgressHUD showWithStatus:@"正在发送消息"];
    } else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    NSDictionary *parameters = @{
                                 @"phone":self.registerAccountTextField.text
                                 };
    
    [self.mgr POST:YKBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"短信发送成功，请注意查收！"];
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"获取验证码失败，请重试！"];
        NSLog(@"%@",error);
        
    }];
}

//注册
- (IBAction)registerBtnClick {
    
    if ((self.registerAccountTextField.text.length == 11) && (self.registerPwdTextField.text.length >= 6) && self.codeTextField.text.length) {
        [SVProgressHUD showWithStatus:@"正在注册"];
    } else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确格式字符"];
        return;
    }
    
    NSDictionary *parameters = @{
                                 @"code":self.codeTextField.text,
                                 @"password":self.registerPwdTextField.text,
                                 @"phone":self.registerAccountTextField.text
                                 };
    
    [self.mgr POST:YKBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"注册失败"];
        
    }];
}


//快速创建登录界面
+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YKLoginRegisterView" owner:nil options:nil] firstObject];
}

//快速创建注册界面
+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YKLoginRegisterView" owner:nil options:nil] lastObject];
}

- (void)dealloc
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}


@end
