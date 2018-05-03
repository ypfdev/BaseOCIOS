//
//  UILabel+MKAddition.m
//  Miku
//
//  Created by 原鹏飞 on 16/4/21.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "UILabel+MKAddition.h"

@implementation UILabel (MKAddition)

+ (instancetype)mk_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize*SizeScale];
    label.textColor = color;
    label.numberOfLines = 0;
    
    return label;
}

@end
