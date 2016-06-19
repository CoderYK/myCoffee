//
//  YKAnnotation.h
//  MyCoffee
//
//  Created by yk on 16/5/17.
//  Copyright © 2016年 coderYK. All rights reserved.
//

/**
 *  大头针视图
 */

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YKAnnotation : NSObject<MKAnnotation>

// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
