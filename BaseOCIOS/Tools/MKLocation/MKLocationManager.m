//
//  MKLocationManager.m
//  AmapTest
//
//  Created by ypf on 2017/7/7.
//  Copyright © 2017年 ypf. All rights reserved.
//

#import "MKLocationManager.h"

@interface MKLocationManager ()

@property (strong, nonatomic) AMapLocationManager *locationManager;

@end


@implementation MKLocationManager


+ (instancetype)sharedLocationManager
{
    // 保存在静态存储区
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

//重写init方法，并在其中为经纬度赋初始值0
- (instancetype)init {
    if (self = [super init]) {
        _latitude = 0;
        _longitude = 0;
    }
    
    return self;
}

#pragma mark - get/set
- (NSString *)poiName{

    if (_poiName == nil) {
        _poiName = @"";
    }
    return _poiName;
}

- (NSString *)city{
    
    if (_city == nil) {
        _city = @"";
    }
    return _city;
}

/**
 开始定位
 */
- (void)locate {
    
    AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
    
    _locationManager = locationManager;
    
    
    //推荐：kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    
    //    //高精度：kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右，超时时间请设置到10s，如果到达10s时没有获取到足够精度的定位结果，会回调当前精度最高的结果。
    //    // 带逆地理信息的一次定位（返回坐标和地址信息）
    //    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //    //   定位超时时间，最低2s，此处设置为10s
    //    self.locationManager.locationTimeout =10;
    //    //   逆地理请求超时时间，最低2s，此处设置为10s
    //    self.locationManager.reGeocodeTimeout = 10;
    
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        //出错
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        
//        //打印定位信息（经纬度、精度）
//        NSLog(@"location:%@", location);
//        //打印逆地理
//        NSLog(@"reGeocode:%@", regeocode);
        
        //返回经纬度
        if (location) {
            _latitude = location.coordinate.latitude;
            _longitude = location.coordinate.longitude;
        }
        
        //返回逆地理
        if (regeocode) {
//            _regeocode = regeocode;
            _poiName = regeocode.POIName;
            _city = regeocode.city;
        }
    }];
    
}

//这是一个回调方法,因为获取位置是一个延时操作,所以直接拿数据有可能拿不到数据,需要获取完数据后回调才是正确的--Dason
- (void)requestLocationsuccess:(void (^)(CLLocation *location, AMapLocationReGeocode *regeocode))success{

    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if(error == nil)
        {
            //返回经纬度
            if (location) {
                _latitude = location.coordinate.latitude;
                _longitude = location.coordinate.longitude;
            }
            //返回逆地理
            if (regeocode) {
//                _regeocode = regeocode;
                _poiName = regeocode.POIName;
                _city = regeocode.city;
            }
            
            //成功后走回调
            //block,得到数据后的回调
            success(location,regeocode);
        }
    }];
}

//返回经纬度拼接的字符串
- (NSString *)generateLocation{
    
    NSString *location = @"";
    
    if (_longitude == 0 && _latitude == 0) {
        return location.copy;
    }
    
    location = [NSString stringWithFormat:@"%lf,%lf",_longitude,_latitude];
    
    return location.copy;
}

@end
