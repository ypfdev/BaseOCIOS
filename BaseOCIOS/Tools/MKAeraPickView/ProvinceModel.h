//
//  ProvinceModel.h
//  KVO_键值编码
//
//  Created by 原鹏飞 on 2017/2/12.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface ProvinceModel : NSObject

//省名
@property (nonatomic, copy) NSString *name;

//ID
@property (nonatomic, copy) NSString *id;

//快速检索首字母
@property (nonatomic, copy) NSString *letter;

//装下属市模型的数组
@property (nonatomic, strong) NSArray<CityModel *> *data;

@end
