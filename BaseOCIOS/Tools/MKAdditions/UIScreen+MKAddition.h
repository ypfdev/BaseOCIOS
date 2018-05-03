//
//  UIScreen+MKAddition.h
//  Miku
//
//  Created by 原鹏飞 on 16/5/17.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (MKAddition)

/// 屏幕宽度
+ (CGFloat)mk_screenWidth;
/// 屏幕高度
+ (CGFloat)mk_screenHeight;
/// 分辨率
+ (CGFloat)mk_scale;

@end
