//
//  YKLoginTextField.m
//  BuDeJie
//
//  Created by yk on 16/4/29.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKLoginTextField.h"
#import "UITextField+placeHolder.h"

@implementation YKLoginTextField

-(void)awakeFromNib
{
    //修改主题颜色
    self.tintColor = [UIColor whiteColor];
    
    //修改占位文字的颜色编辑状态白色,平时灰色
    //监听文本框的状态:1.代理 2.通知 3.target
    //1.当前类就是UITextField,避免成为自己的代理,否则就违背了代理的设计理念
    //通知不常用,故使用 target
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //设置默认为灰色
    self.placeholderColor = [UIColor lightGrayColor];
    
    
}

//开始编辑
- (void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
}

//结束编辑
- (void)textEnd
{
   self.placeholderColor = [UIColor lightGrayColor];
}

//方案2:显示占位文字的子控件是 Label?
- (void) test2
{
    // 目标:快速设置占位文字颜色
    //1.猜测显示占位文字的是 Label, 验证是 Label,验证方法:通过小面包查看控件的类型UITextFieldLabel
    //2.获取到 Label 知道属性名就能直接访问系统的东西
    //3.查看苹果有没有提供这样的属性给我们访问
    //4.即使没有提供属性给我们访问,但是只要获取到私有属性名,我们就能访问  runtime 遍历所有属性,取出与之对应的属性
    //5.获取私有属性名:给对象打断点
    //    UITextField *field;  _placeholderLabel	id	0x0
    //6.使用 KVC 就能拿到占位文字控件属性
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor whiteColor];
    
    // self.placeholderColor = []
    //UILabel *label;
    //label.textColor;
}

//方案1:修改attributedPlaceholder
- (void) test1
{
    NSDictionary *attrDict = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
}
@end
