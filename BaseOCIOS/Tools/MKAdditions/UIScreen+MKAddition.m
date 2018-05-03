//
//  UIScreen+MKAddition.m
//  Miku
//
//  Created by 原鹏飞 on 16/5/17.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "UIScreen+MKAddition.h"

@implementation UIScreen (MKAddition)

+ (CGFloat)mk_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)mk_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)mk_scale {
    return [UIScreen mainScreen].scale;
}

@end
