//
//  YKDrinkItem.h
//  MyCoffee
//
//  Created by yk on 16/5/14.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDrinkItem : NSObject

//饮品名
@property (strong, nonatomic) NSString *goods_name;
//图片
@property (strong, nonatomic) NSString *logo_pic;
//赞
@property (strong, nonatomic) NSString *praise_num;
//价格
@property (strong, nonatomic) NSNumber *price;
//热1/冷>1
@property (assign, nonatomic) NSNumber *ishot;
//赞>1/踩0
@property (assign, nonatomic) BOOL ishb;

/**
 *  用户购买饮料的数量
 */
@property (assign, nonatomic) NSInteger number;


@end
