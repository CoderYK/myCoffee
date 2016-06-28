//
//  YKDataManager.h
//  MyCoffee
//
//  Created by yk on 16/5/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDataManager : NSObject

/**
 *  数据管理者单例对象
 *
 *  @return 数据管理者单例对象
 */
+ (instancetype)shareYKDataManager;

/**
 *  创建商品表格
 */
//- (void)createTableWithSql:(NSString *)sql;

/**
 *  插入商品
 */
- (void)insertTableWithSql:(NSString *)sql;

/**
 *  查询表格
 */
- (NSMutableArray *)queryAll;

/**
 *  根据时间戳删除数据
 *
 *  @param time 时间戳
 */
- (void)delectData:(NSString *)time;

/**
 *  删除已存在的表格
 */
- (void)dropTable;

@end
