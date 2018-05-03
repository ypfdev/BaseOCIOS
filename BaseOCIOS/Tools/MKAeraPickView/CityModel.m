//
//  CityModel.m
//  KVO_键值编码
//
//  Created by 原鹏飞 on 2017/2/12.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import "CityModel.h"
#import "DistrictModel.h"

@implementation CityModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[DistrictModel class]};
}

@end
