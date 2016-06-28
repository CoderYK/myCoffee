//
//  YKShopView.m
//  MyCoffee
//
//  Created by yk on 16/5/14.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKShopView.h"
#import "YKShopCell.h"
#import "YKDrinkItem.h"
#import "YKPayViewController.h"
#import "YKNavigationController.h"
#import <MJExtension/MJExtension.h>


@interface YKShopView ()
@property (weak, nonatomic) IBOutlet UILabel *ChosenFoodView;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceView;
@property (weak, nonatomic) IBOutlet UIButton *showShopsView;
@property (weak, nonatomic) IBOutlet UIView *allFoodsView;
@property (strong, nonatomic) NSMutableArray *itemArr;


@end
static int count = 0;
@implementation YKShopView

- (NSMutableArray *)itemArr
{
    if (_itemArr == nil) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

+ (instancetype)shopView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    _orderBtn.enabled = NO;
    
    //在较早的时刻监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusClick:) name:YKAddNote object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusClick:) name:YKMinusNote object:nil];
}


//移除通知监听
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听通知
- (void)plusClick:(NSNotification *)note
{
    //发布者
    YKShopCell *cell = note.object;
    [self.itemArr addObject:cell.item];
    
    //计算总价
    int totalPrice = self.totalPriceView.text.intValue + cell.item.price.intValue;

    self.totalPriceView.text = [NSString stringWithFormat:@"%d",totalPrice];
    
    //修改购买按钮的状态
    self.orderBtn.enabled = YES;
    
    count++;
    self.ChosenFoodView.text = [NSString stringWithFormat:@"已选%d道饮料",count];
}

- (void)minusClick:(NSNotification *)note
{
    //发布者
    YKShopCell *cell = note.object;
    [self.itemArr removeLastObject];
    
    //计算总价
    int totalPrice = self.totalPriceView.text.intValue - cell.item.price.intValue;

    self.totalPriceView.text = [NSString stringWithFormat:@"%d",totalPrice];

    self.orderBtn.enabled = totalPrice > 0;
    
    count--;
    self.ChosenFoodView.text = [NSString stringWithFormat:@"已选%d道饮料",count];
    
}

#pragma mark -------------------
#pragma mark Events
- (IBAction)arrowBtn:(UIButton *)sender {
    self.allFoodsView.hidden = !self.allFoodsView.hidden;
    sender.selected = !sender.selected;
}
//下单
- (IBAction)orderButtonClick:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"YKPayViewController" bundle:nil];
    YKPayViewController *payVc = [storyBoard instantiateInitialViewController];
    payVc.totalPrice = self.totalPriceView.text;
    payVc.itemArr = self.itemArr;
    YKNavigationController *nav = [[YKNavigationController alloc] initWithRootViewController:payVc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];

    
}

@end
