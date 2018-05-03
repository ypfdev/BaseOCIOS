//
//  UILabel+MKAddition.h
//  Miku
//
//  Created by 原鹏飞 on 16/4/21.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MKAddition)

/// 创建文本标签
///
/// @param text     文本
/// @param fontSize 字体大小
/// @param color    颜色
///
/// @return UILabel
+ (instancetype)mk_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;

@end
