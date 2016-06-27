//
//  YKMapViewController.m
//  MyCoffee
//
//  Created by yk on 16/5/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YKAnnotation.h"
#import "YKHeadViewController.h"
#import "YKHeaderView.h"

@interface YKMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
/**
 *  定位管理者
 */
@property (strong, nonatomic) CLLocationManager *locationManager;
/**
 *  地理编码
 */
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *searchToolBar;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) CLPlacemark *placemark;
@property (weak, nonatomic) id observer;
@property (weak, nonatomic) YKHeaderView *headVc;

@end

@implementation YKMapViewController

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
    
    self.title = @"导航定位";
    self.view.backgroundColor = YKBgColor;
    
    //初始化控件
    [self initGUI];
    
    // 计算两个地点的距离
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //停止跟踪定位
    [self.locationManager stopUpdatingHeading];
}


#pragma mark -------------------
#pragma mark 添加地图控件
- (void)initGUI
{
    //添加地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.searchToolBar.yk_height, YKScreenW, 350)];
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
    
    YKHeaderView *headVc = [YKHeaderView headerView];
    headVc.frame = CGRectMake(0, CGRectGetMaxY(mapView.frame), YKScreenW, 60);
    self.headVc = headVc;
    [self.view addSubview:headVc];
    
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
#pragma mark 搜索定位
- (IBAction)searchButton:(id)sender {
    [self getCoordinateByAddress:self.searchTextField.text];
    [self.view endEditing:YES];
    [_mapView removeAnnotations:_mapView.annotations];
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
#pragma mark 开始定位
- (void)beginLocationFollow
{
    //判断定位服务开启情况
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务尚未开启，请到设置中打开！");
        return;
    }
    /*
     授权的状态
     kCLAuthorizationStatusNotDetermined    用户还未决定是否启用定位服务
     kCLAuthorizationStatusRestricted       没有权限获得用户授权使用定位服务
     kCLAuthorizationStatusDenied           用户关闭了定位服务
     kCLAuthorizationStatusAuthorizedAlways 应用获得授权可以一直使用定位服务，即使应用不在使用状态
     kCLAuthorizationStatusAuthorizedWhenInUse 应用在使用过程中允许访问定位服务
     */
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

#pragma mark -------------------
#pragma mark CLLocationManagerDelegate
//只要位置发生改变机会执行（只要定位到相应地位置）
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations firstObject];//取出第一个位置
    
    [self.geocoder geocodeAddressString:@"广东省湛江市湖光岩风景区" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *plcs = [placemarks firstObject];
        
        self.headVc.distance = [location distanceFromLocation: plcs.location];
        
        
    }];
    
   
    
}



//
///**
// *  当用户进入某个区域的时候就会调用
// */
//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
//{
//    NSLog(@"didEnterRegion");
//}
///**
// *  当用户离开某个区域的时候就会调用
// */
//- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
//{
//    NSLog(@"didExitRegion");
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
