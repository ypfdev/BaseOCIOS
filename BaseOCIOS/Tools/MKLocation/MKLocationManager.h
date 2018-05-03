//
//  MKLocationManager.h
//  AmapTest
//
//  Created by ypf on 2017/7/7.
//  Copyright © 2017年 ypf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface MKLocationManager : NSObject

//@property (strong, nonatomic) AMapLocationManager *locationManager;

///纬度
@property (nonatomic, assign) CGFloat latitude;

///经度
@property (nonatomic, assign) CGFloat longitude;

//逆地理信息(暂时没什么用)
//@property (strong, nonatomic) AMapLocationReGeocode *regeocode;

//@property (nonatomic, strong) AMapLocationPoint *point;

//兴趣点
@property (strong, nonatomic) NSString *poiName;

//城市
@property (strong, nonatomic) NSString *city;

+ (instancetype)sharedLocationManager;


/**
 定位
 */
- (void)locate ;


//定位的block返回地理位置
- (void)requestLocationsuccess:(void (^)(CLLocation *location, AMapLocationReGeocode *regeocode))success;

- (NSString *)generateLocation;

@end
