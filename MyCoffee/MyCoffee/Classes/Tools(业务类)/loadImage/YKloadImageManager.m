
/**
 *  整个项目中,加载网络图片都使用这个类处理
 */

#import "YKloadImageManager.h"


@implementation YKloadImageManager

+ (void)sd_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock imageView:(UIImageView *)imageView
{
    //取出 SDWebImage 中的图片缓存
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    
    //此处优化的是避免大图重新绘制
    if (cacheImage) {
        
        //普通的设置图片不能展示 gif
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        
    } else
    {
        //SDWebImage会对图片进行压缩处理(compat)
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
    }
}

@end
