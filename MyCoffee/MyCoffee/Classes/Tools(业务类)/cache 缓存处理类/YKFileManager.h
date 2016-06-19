
/*
    作用:获取文件尺寸,处理文件
 */
/*
    业务类注意点:
        1.一定要在类的最前面说明这个类有什么用
        2.方法一定要使用文档注释
        3.方法的实现严谨,考虑到各种不利的情况
 */
#import <Foundation/Foundation.h>

@interface YKFileManager : NSObject

/**
 *  指定一个文件夹路径获取该文件夹的尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getSizeOfDirectory:(NSString *)directoryPath;

/**
 *  指定一个文件夹路径移除该文件夹下所有文件
 *
 *  @param directoryPath 文件夹全路径
 */
+ (void)removeItemOfDirectory:(NSString *)directoryPath;

@end
