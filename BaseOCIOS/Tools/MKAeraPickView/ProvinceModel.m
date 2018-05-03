//
//  ProvinceModel.m
//  KVO_键值编码
//
//  Created by 原鹏飞 on 2017/2/12.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

//实现协议中的 modelContainerPropertyGenericClass，返回 Model 属性容器中需要存放的对象类型，YYModel 会自动进行处理
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[CityModel class]};
}

@end
