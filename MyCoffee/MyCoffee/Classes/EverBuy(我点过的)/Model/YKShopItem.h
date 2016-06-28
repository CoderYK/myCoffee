//
//  YKShopItem.h
//  MyCoffee
//
//  Created by yk on 16/6/28.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKShopItem : NSObject

//饮品名
@property (strong, nonatomic) NSString *goods_name;
//图片
@property (strong, nonatomic) NSString *logo_pic;
//价格
@property (strong, nonatomic) NSNumber *price;

//时间
@property (strong, nonatomic) NSString *buyTime;

@end
