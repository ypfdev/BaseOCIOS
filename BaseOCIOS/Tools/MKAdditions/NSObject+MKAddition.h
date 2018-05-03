//
//  NSObject+MKAddition.h
//  Zhifubao
//
//  Created by 原鹏飞 on 16/4/26.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MKAddition)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)mk_objectWithDict:(NSDictionary *)dict;

@end
