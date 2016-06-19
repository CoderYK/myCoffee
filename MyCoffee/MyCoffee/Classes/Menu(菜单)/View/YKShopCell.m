//
//  YKShopCell.m
//  瀑布流
//
//  Created by yk on 16/4/23.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "YKShopCell.h"
#import "YKDrinkItem.h"
#import "YKloadImageManager.h"
#import "YKImageView.h"


@interface YKShopCell ()

@property (weak, nonatomic) IBOutlet YKImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIButton *isHotView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *likeNumView;
@property (weak, nonatomic) IBOutlet UIImageView *likeView;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyView;


@end

@implementation YKShopCell

#pragma mark -------------------
#pragma mark 设置数据
- (void)setItem:(YKDrinkItem *)item
{
    _item = item;
    
    [YKloadImageManager sd_setImageWithURL:item.logo_pic placeholderImage:[UIImage imageNamed:@"placeH"] options:SDWebImageRetryFailed progress:nil completed:nil imageView:self.imageView];
    _titleView.text = item.goods_name;
    _likeNumView.text = item.praise_num;
    _isHotView.hidden = item.ishot.integerValue > 1? YES:NO;
    _priceView.text = [NSString stringWithFormat:@"￥%@",item.price];
    _moneyView.text = [NSString stringWithFormat:@"%ld*%@",_item.number, _item.price];
    _likeView.hidden = item.ishb;
    
}

#pragma mark -------------------
#pragma mark Events
- (IBAction)add:(id)sender {
    
    //修改模型
    _item.number++;
    //更新数据
    _moneyView.text = [NSString stringWithFormat:@"%ld*%@",_item.number, _item.price];
    
    _minusButton.hidden = NO;
    
    //发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YKAddNote object:self];
}
- (IBAction)minus:(UIButton *)sender {
    _item.number--;
    _moneyView.text = [NSString stringWithFormat:@"%ld*%@",_item.number, _item.price];
    if (_item.number == 0) {
        sender.hidden = YES;
    }
    
    //发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YKMinusNote object:self];
}



@end
