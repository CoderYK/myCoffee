//
//  YKDataManager.m
//  MyCoffee
//
//  Created by yk on 16/5/19.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKDataManager.h"

@implementation YKDataManager

+ (void)writefile:(NSData *)jsonData fileName:(NSString *)fileName
{
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = [homePath stringByAppendingPathComponent:fileName];
    
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [jsonData writeToFile:filePath atomically:YES];
//    
//    if (![fileManager fileExistsAtPath:filePath]) {
//        //如果文件路径不存在，写入文件
//        [jsonData writeToFile:filePath atomically:YES];
//    } else
//    {
//        //追加写入文件
//        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
//        
//        [fileHandle seekToEndOfFile]; //将节点跳到文件的末尾
//        
//        [fileHandle writeData:jsonData];//写入数据
//        
//        //关闭文件句柄
//        [fileHandle closeFile];
//    }
}
@end
