//
//  YKBigPictureViewController.m
//  BuDeJie
//
//  Created by yk on 16/5/5.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Photos/Photos.h>
#import "YKPhotoManager.h"
#import "YKDrinkItem.h"

static NSString * const albumTitle = @"myCoffee";
@interface YKBigPictureViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) UIImageView *imageView;


@end

@implementation YKBigPictureViewController

#pragma mark -------------------
#pragma mark showPic
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    imageView.image = _image;
    
    CGFloat h = YKScreenW /_image.size.width * _image.size.height;
    imageView.frame = CGRectMake(0, 0, YKScreenW, h);
   
    imageView.center = CGPointMake(YKScreenW * 0.5, YKScreenH * 0.5);
    
    //设置缩放比例
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 1.5;

    [self.scrollView addSubview:imageView];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
#pragma mark -------------------
#pragma mark Events
//退出页面
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -------------------
#pragma mark 保存图片到自定义相册
/*
    自定义相册:
        PHAssetCreationRequest:创建照片或者视频
        PHAssetCollectionChangeRequest:创建相册
        PHAsset:照片
        PHPhotoLibrary:相簿
 */

//method can only be called from inside of -[PHPhotoLibrary performChanges:completionHandler:] or -[PHPhotoLibrary performChangesAndWait:error:]
/*
    用户授权状态:
     PHAuthorizationStatusNotDetermined = 0   不确定
     PHAuthorizationStatusRestricted,        拒绝访问(家长控制)
     PHAuthorizationStatusDenied,            拒绝访问     
     PHAuthorizationStatusAuthorized         允许访问
 */

//保存图片:图片应用保存图片的方式是先把照片保存到系统相册,然后再拷贝一份到对应的相册中
- (IBAction)save:(id)sender {
    
    //判断用户的授权状态,在允许的情况下才执行保存操作
    PHAuthorizationStatus status =  [PHPhotoLibrary authorizationStatus];
    
    
    
    if (status == PHAuthorizationStatusAuthorized) {
        //允许访问
        //1.自定义相册//保存图片
        [YKPhotoManager addAsset:_image toAlbum:albumTitle completionHandler:^(BOOL success, NSError *error) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            } else
                
            {
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }
        }];
    } else if (status == PHAuthorizationStatusNotDetermined)
    {
        //不确定,显示弹窗,询问用户是否允许访问
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                
                //允许访问
                [YKPhotoManager addAsset:_image toAlbum:albumTitle completionHandler:^(BOOL success, NSError *error) {
                    if (success) {
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    } else
                        
                    {
                        [SVProgressHUD showErrorWithStatus:@"保存失败"];
                    }
                }];
            }
        }];
    } else
    {
        //提示用户到设置中心进行设置
        [SVProgressHUD showInfoWithStatus:@"点击设置，找到当前app,打开照片开关，即可保存图片"];
    }
}


/*
    问题:每次保存都创建新的相册
    判断当前相册是否存在?存在的话就不用创建了
    怎么判断?搜索相册是否已经存在
 */


//隐藏状态栏View controller-based status bar appearance
//[UIApplication sharedApplication].statusBarHidden不好使
- (BOOL)prefersStatusBarHidden
{
    return YES;
}





@end
