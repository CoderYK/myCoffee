//
//  YKDataManager.m
//  MyCoffee
//
//  Created by yk on 16/5/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKDataManager.h"
#import <FMDB/FMDB.h>

@interface YKDataManager ()

@property (strong, nonatomic) FMDatabaseQueue *queue;

@end

@implementation YKDataManager

#pragma mark -------------------
#pragma mark 懒加载
- (FMDatabaseQueue *)queue {
    if (_queue == nil) {
        
        NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *filePath = [homePath stringByAppendingPathComponent:@"myCoffee.db"];

        _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    }
    
    return _queue;
}


// 获取数据管理者单例对象
+ (instancetype)shareYKDataManager
{
    static YKDataManager *_dataManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager = [[self alloc] init];
//        [_dataManager dropTable];
        [_dataManager createTable];
    });
    
    return _dataManager;
}


/**
 *  创建表格
 */
- (void)createTable {
    
    NSString *sql = @"create table if not exists t_shops(id integer primary key autoincrement, goods_name text not null, logo_pic text, price text, buyTime text)";
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql withVAList:nil];
        
        if (flag) {
            NSLog(@"创建表格成功");
        }
    }];
}


/**
 *  删除数据
 */
- (void)delectData:(NSString *)time {

    NSString *sql = [NSString stringWithFormat:@"delete from t_shops where buyTime = '%@'", time];
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql withVAList:nil];
        
        if (flag) {
            NSLog(@"删除数据成功");
        }
    }];
}

/**
 *  删除表格
 */
- (void)dropTable {
    NSString *sql = @"drop table if exists t_shops";
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql withVAList:nil];
        
        if (flag) {
            NSLog(@"删除表格成功");
        }
    }];
}


/**
 *  插入记录
 */
- (void)insertTableWithSql:(NSString *)sql {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql withVAList:nil];
        
        if (flag) {
            NSLog(@"插入记录成功");
        } else {
            NSLog(@"插入失败");
        }
    }];
}


/**
 *  查询表格
 */
- (NSMutableArray *)queryAll {
    
    NSString *sql = @"select * from t_shops";
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
    
       FMResultSet *resultSet = [db executeQuery:sql withVAList:nil];
    
        while (resultSet.next) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (int i = 0 ; i < resultSet.columnCount; i++) {
                dict[[resultSet columnNameForIndex:i]] = [resultSet stringForColumnIndex:i];
            }
            
            [arrM addObject:dict];
        }
    }];
    
    return arrM;
}









@end
