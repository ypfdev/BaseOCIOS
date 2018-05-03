//
//  UIButton+MKAddition.h
//  Miku
//
//  Created by 原鹏飞 on 16/5/17.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MKAddition)

/**
 对象方法：向四周扩大按钮的点击区域

 @param size 扩大区域的径向长度
 */
- (void)setEnlargeEdge:(CGFloat)size;


/**
 对象方法：（呈矩形）扩大按钮的点击区域

 @param top 顶部扩大范围
 @param left 左边扩大范围
 @param bottom 底部扩大范围
 @param right 右边扩大范围
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top AndLeft:(CGFloat)left AndBottom:(CGFloat)bottom AndRight:(CGFloat)right;


/// 创建文本按钮
///
/// @param title         文本
/// @param fontSize      字体大小
/// @param normalColor   默认颜色
/// @param selectedColor 选中颜色
///
/// @return UIButton
+ (instancetype)mk_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

/**
 使传入按钮的图片在上，文字在下
 
 @param btn 传入按钮
 */
-(void)mk_resetButton:(UIButton*)btn;


/**
 重置按钮布局：文字在上，图片在下
 */
- (void)mk_resetButton;


/**
 重置按钮布局：文字在上，图片在下，主题色不可用
 */
- (void)mk_resetButtonDisable;


/**
 重新设置按钮布局：文字在左，图片在右
 */
- (void)mk_resetButton_titleLeftImageRight;

@end
