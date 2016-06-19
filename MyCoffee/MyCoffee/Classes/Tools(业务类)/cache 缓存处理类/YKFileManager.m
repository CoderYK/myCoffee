//
//  YKFileManager.m
//  BuDeJie
//
//  Created by yk on 16/5/1.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKFileManager.h"

@implementation YKFileManager

// 指定一个文件夹路径，就获取文件夹尺寸
+ (NSInteger)getSizeOfDirectory:(NSString *)directoryPath
{
    //取出该文件夹下的所有子级文件
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //对外界传进来的路径进行过滤
    //判断是否是文件夹路径
    BOOL isDirectory = NO;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        //如果不是抛出异常
        NSException *exception = [NSException exceptionWithName:@"fileError:[YKFileManager getSizeOfDirectory:]" reason:@"路径参数错误,要求传入的是全路径" userInfo: nil];
        [exception raise];
    };
    
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    //拼接全路径
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        //如果是隐藏文件,是文件就不需要计算
        if ([filePath containsString:@".DS"]) continue;
        //判断是否是文件夹
        BOOL isDirectory = NO;
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        //获取所有文件的属性 尺寸
        NSDictionary *attrDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //累加文件尺寸
        totalSize += [attrDict fileSize];
    }
    
    return totalSize;
}

+ (void)removeItemOfDirectory:(NSString *)directoryPath
{
    //清楚缓存
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //对外界传进来的路径进行过滤
    //判断是否是文件夹路径
    BOOL isDirectory = NO;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        //如果不是抛出异常
        NSException *exception = [NSException exceptionWithName:@"fileError:[YKFileManager removeItemOfDirectory:]" reason:@"路径参数错误,要求传入的是全路径" userInfo: nil];
        [exception raise];
    };
    
    //获取缓存路径下所有的子文件,只能获取到下一级
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:filePath error:nil];
    }
}
@end
