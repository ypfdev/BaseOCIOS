//
//  UIImage+HCImage.m
//  PureGarden
//
//  Created by xie dason on 2017/6/27.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "UIImage+HCImage.h"

@implementation UIImage (HCImage)

+ (UIImage *)imagewithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
