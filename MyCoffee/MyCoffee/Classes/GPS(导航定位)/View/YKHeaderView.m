//
//  YKHeaderView.m
//  MyCoffee
//
//  Created by yk on 16/5/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKHeaderView.h"
#import "YKHeadingManager.h"


@interface YKHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *detialView;
@property (weak, nonatomic) IBOutlet UILabel *distanceView;

@end

@implementation YKHeaderView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    _distanceView.text = @"0.0km";
}

- (void)setDistance:(double)distance{
    _distance = distance;
    
    _distanceView.text = [NSString stringWithFormat:@"%.2f km",distance / 1000];
}

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [YKHeadingManager headingToAddress:self.titleView.text];
}

@end
