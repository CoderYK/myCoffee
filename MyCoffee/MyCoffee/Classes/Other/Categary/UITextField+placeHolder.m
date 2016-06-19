//
//  UITextField+placeHolder.m
//  BuDeJie
//
//  Created by yk on 16/4/29.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "UITextField+placeHolder.h"
#import <objc/message.h>

@implementation UITextField (placeHolder)

+(void)load
{
    //交换方法实现(对象方法)
    Method yk_setPlaceholderMethod =  class_getInstanceMethod([self class], @selector(set_ykPlaceholder:));
    Method setPlaceholderMethod = class_getInstanceMethod([self class], @selector(setPlaceholder:));
    method_exchangeImplementations(setPlaceholderMethod, yk_setPlaceholderMethod);
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //处理方法1:设置空的占位文字
//    if (self.placeholder == nil) {
//        self.placeholder = @" ";
//    }
    
    //处理方法2:保存传入的颜色,runtime 动态添加属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

-(void)set_ykPlaceholder:(NSString *)placeholder
{
    [self set_ykPlaceholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}



@end
