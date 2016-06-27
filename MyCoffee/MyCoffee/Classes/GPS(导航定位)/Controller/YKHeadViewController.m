//
//  YKHeadViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKHeadViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YKAnnotation.h"

@interface YKHeadViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

/**
 *  定位管理者
 */
@property (strong, nonatomic) CLLocationManager *locationManager;
/**
 *  地理编码
 */
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLPlacemark *placemark;

@end

@implementation YKHeadViewController
#pragma mark -------------------
#pragma mark lazy loading
- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}
- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Heading";
    self.view.backgroundColor = YKBgColor;
    
    //添加地图控件
    [self addMapView];
    
    //地理编码
    [self getCoordinateByAddress:_userInfoDict[@"title"]];
    
}

#pragma mark -------------------
#pragma mark 初始化
//添加地图控件
- (void)addMapView
{
    //添加地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    _mapView = mapView;
    //设置代理
    mapView.delegate = self;
    
    //请求定位服务
    [self beginLocationFollow];
    
    //用户位置追踪
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图类型
    mapView.mapType = MKMapTypeStandard;
}


/**
 *  根据地理名确定地理坐标
 */
- (void)getCoordinateByAddress:(NSString *)address
{
    //地理编码
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //取出第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        _placemark = [placemarks firstObject];
       
        //添加大头针
        [self addAnnotation];
    }];
}

#pragma mark -------------------
#pragma mark 添加大头针
- (void)addAnnotation{
    YKAnnotation *annotation1 = [[YKAnnotation alloc] init];
    annotation1.title =_placemark.name;
    annotation1.subtitle = _placemark.thoroughfare;
    annotation1.coordinate = _placemark.location.coordinate;
    [_mapView setCenterCoordinate:_placemark.location.coordinate animated:YES];
    [_mapView addAnnotation:annotation1];
}

#pragma mark -------------------
#pragma mark 开始定位
- (void)beginLocationFollow
{
    //判断定位服务开启情况
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务尚未开启，请到设置中打开！");
        return;
    }
    //判断授权情况，如果没有授权就要请求授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        //设置代理
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //最佳精度
        //定位频率，每隔多少米定位一次
        CLLocationDistance distance = 10;
        self.locationManager.distanceFilter = distance;
        //启动跟踪定位
        [self.locationManager startUpdatingLocation];
        
    }
}


@end
