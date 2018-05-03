//
//  UIImage+MKAddition.h
//  PureGarden
//
//  Created by 原鹏飞 on 2017/7/28.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MKAddition)

/**
 类方法：生成指定颜色的图片

 @param color 图片颜色
 @return 生成的纯色图片
 */
+ (UIImage *)mk_imageWithColor:(UIColor *)color;

/**
 类方法生成圆形图片
 
 @param image 传入的图片
 @return 处理过后的圆形图片
 */
+ (UIImage *)mk_circleImage:(UIImage *)image;


/**
 对象方法：生成圆形图片
 
 @return 圆形图片
 */
- (UIImage *)mk_circleImage;


/**
 生成带外圈的圆形图片
 
 @param loopWidth 圈的宽度
 @param color 圈的颜色
 @return 带外圈的圆形图片
 */
- (UIImage *)mk_circleImageWithLoopWidth:(float)loopWidth andLoopColor:(UIColor *)color;

/**
 按比例压缩图片尺寸

 @param scaleSize 压缩比例
 @return 压缩尺寸后的图片
 */
- (UIImage *)mk_scaleImageToScale:(float)scaleSize;

/**
 根据指定size压缩图片尺寸
 
 @param size 指定尺寸
 @return 压缩尺寸后的图片
 */
- (UIImage *)mk_compressedImageToSize:(CGSize)size;

@end
