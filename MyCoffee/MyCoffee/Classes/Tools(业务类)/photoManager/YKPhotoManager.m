
/**
 *  获取已有相册,保存图片到自定义相册
 */

#import "YKPhotoManager.h"

@implementation YKPhotoManager

//获取已相册
+ (PHAssetCollection *)getAlbumCollectionWithTitle:(NSString *)albumTitle
{
    PHFetchResult<PHAssetCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

//保存图片到自定义相册
+ (void)addAsset:(UIImage *)image toAlbum:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError * error))completionHandler
{
    //1.1获取相簿
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //对相簿的操作一定要在这个 block 中执行
        
        //创建相册请求
        PHAssetCollectionChangeRequest *collectionChangeRequest;
        
        //获取已相册
        PHAssetCollection *assetCollection = [self getAlbumCollectionWithTitle:albumTitle];
        
        if (assetCollection) {
            //相册存在,直接获取
            collectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else
        {   //不存在则新建
            collectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        
        //创建照片
        PHAssetCreationRequest *createAssetRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:image];
        
        //该方法是异步执行的,有可能在图片生成之前就执行完了,所以先占着位置
        PHObjectPlaceholder *assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
        
        //添加照片到相册中
        [collectionChangeRequest addAssets:@[ assetPlaceholder ]];
        
    } completionHandler:completionHandler];
}

@end
