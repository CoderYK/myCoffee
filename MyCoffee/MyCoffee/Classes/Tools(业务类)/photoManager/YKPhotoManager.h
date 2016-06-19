
/**
 *  获取已有相册,保存图片到自定义相册
 */

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface YKPhotoManager : NSObject

/**
 *  获取指定名称的相册
 *
 *  @param albumTitle 相册名称
 *
 *  @return 如果相册存在则返回该相册对象,不存在则返回空
 */
+ (PHAssetCollection *)getAlbumCollectionWithTitle:(NSString *)albumTitle;

/**
 *  自定义相册,把图片保存到指定名称的相册中
 *
 *  @param image             需要保存的图片
 *  @param albumTitle        相册的名称,如果不存在则新建一个相册
 *  @param completionHandler 保存完成时的回调
 */
+ (void)addAsset:(UIImage *)image toAlbum:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError * error))completionHandler;

@end
