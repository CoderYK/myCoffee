//
//  YKEverBuyCell.m
//  MyCoffee
//
//  Created by yk on 16/5/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKEverBuyCell.h"
#import "YKloadImageManager.h"
#import "YKDrinkItem.h"

@interface YKEverBuyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;

@end

@implementation YKEverBuyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setItem:(YKDrinkItem *)item
{
    _item = item;
    
    self.nameView.text = item.goods_name;
    [YKloadImageManager sd_setImageWithURL:item.logo_pic placeholderImage:nil options:SDWebImageRetryFailed progress:nil completed:nil imageView:self.foodImageView];
    self.priceView.text = [NSString stringWithFormat:@"￥%@",item.price];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *ftr = [[NSDateFormatter alloc] init];
    ftr.dateFormat = @"yyyy-mm-dd HH:MM:ss";
    
    self.timeView.text = [ftr stringFromDate:date];
}

@end
