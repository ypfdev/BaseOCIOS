//
//  UIImage+MKAddition.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/7/28.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "UIImage+MKAddition.h"

@implementation UIImage (MKAddition)

/**
 生成指定颜色的图片
 
 @param color 图片颜色
 @return 生成的纯色图片
 */
+ (UIImage *)mk_imageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 生成圆角图片的类方法

 @param image 传入的图片
 @return 处理过后的圆角图片
 */
+ (UIImage *)mk_circleImage:(UIImage *)image {
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [image drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}


/**
 生成圆形图片
 
 @return 圆形图片
 */
- (UIImage *)mk_circleImage {
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}



/**
 生成带外圈的圆形图片

 @param loopWidth 圈的宽度
 @param color 圈的颜色
 @return 带外圈的圆形图片
 */
- (UIImage *)mk_circleImageWithLoopWidth:(float)loopWidth andLoopColor:(UIColor *)color {
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画圈
    // 设置一个范围
    CGRect loopRect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, loopRect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [[UIImage imagewithColor:color] drawInRect:loopRect];
    
    //绘制图片
    // 设置一个范围
    CGRect imageRect = CGRectMake(loopWidth / 2, loopWidth / 2, self.size.width - loopWidth, self.size.height - loopWidth);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, imageRect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [self drawInRect:imageRect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

//按比例压缩图片
- (UIImage *)mk_scaleImageToScale:(float)scaleSize{
    //dason
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//按size压缩图片
- (UIImage *)mk_compressedImageToSize:(CGSize)size{

    //dason
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}



@end
