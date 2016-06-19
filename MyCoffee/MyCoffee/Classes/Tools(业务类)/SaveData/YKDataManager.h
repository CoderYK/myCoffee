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
 *  保存 JSON 数据到沙盒中
 *
 *  @param jsonData 需要保存的 JSON 数据
 *  @param fileName 保存的路径
 */
+(void)writefile:(NSData *)jsonData fileName:(NSString *)fileName;

@end
