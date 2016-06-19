//
//  YKHeadingManager.m
//  MyCoffee
//
//  Created by yk on 16/5/18.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import "YKHeadingManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface YKHeadingManager ()


@end

@implementation YKHeadingManager

+ (void)headingToAddress:(NSString *)address{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkplacemark=[[MKPlacemark alloc]initWithPlacemark:clPlacemark];//定位地标转化为地图的地标
        NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
        MKMapItem *mapItem=[[MKMapItem alloc]initWithPlacemark:mkplacemark];
        [MKMapItem openMapsWithItems:@[mapItem] launchOptions:options];
    }];
}

@end
