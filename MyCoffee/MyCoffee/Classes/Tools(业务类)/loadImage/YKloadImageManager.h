//
//  YKloadImageManager.h
//  BuDeJie
//
//  Created by yk on 16/5/3.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImageView+WebCache.h>

@interface YKloadImageManager : NSObject

/**
*  加载图片
*
*  @param url            需要加载图片的 URL
*  @param placeholder    占位视图
*  @param progressBlock  进度回调,可以监听图片的加载进度
*  @param completedBlock 加载完成后回调
*  @param imageView      展示图片的 imageView
*/
+ (void)sd_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock imageView:(UIImageView *)imageView;

@end
