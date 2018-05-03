//
//  DistrictModel.h
//  KVO_键值编码
//
//  Created by 原鹏飞 on 2017/2/12.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistrictModel : NSObject

//区名
@property (nonatomic, copy) NSString *name;

//ID
@property (nonatomic, copy) NSString *id;

//快速检索首字母
@property (nonatomic, copy) NSString *letter;


@end
