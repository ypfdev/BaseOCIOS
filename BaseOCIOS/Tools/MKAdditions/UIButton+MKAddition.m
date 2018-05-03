//
//  UIButton+MKAddition.m
//  Miku
//
//  Created by 原鹏飞 on 16/5/17.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "UIButton+MKAddition.h"

#import <objc/runtime.h>

@implementation UIButton (MKAddition)

#pragma mark - 扩大按钮的点击区域

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

/**
 对象方法：向四周扩大按钮的点击区域
 
 @param size 扩大区域的径向长度
 */
- (void)setEnlargeEdge:(CGFloat)size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 对象方法：（呈矩形）扩大按钮的点击区域
 
 @param top 顶部扩大范围
 @param left 左边扩大范围
 @param bottom 底部扩大范围
 @param right 右边扩大范围
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top AndLeft:(CGFloat)left AndBottom:(CGFloat)bottom AndRight:(CGFloat)right {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (CGRect)enlargedRect {
    
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}


#pragma mark - 快速创建仅文字无图片的按钮

/**
 快速创建文字按钮

 @param title 按钮文字
 @param fontSize 字号
 @param normalColor 默认状态下文字的颜色
 @param selectedColor 选中状态下文字的颜色
 @return 返回创建的按钮
 */
+ (instancetype)mk_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;
}


#pragma mark - 按钮文字和图片重新布局

/**
 使传入按钮的图片在上，文字在下

 @param btn 传入按钮
 */
- (void)mk_resetButton:(UIButton*)btn{
    
    //使图片和文字水平居中显示
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];

    //调整文本框位置
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height * 1.3, - btn.imageView.frame.size.width, 0, 0)];

    //设置文字
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:NO];

    //调整图片位置
    [btn setImageEdgeInsets:UIEdgeInsetsMake(- btn.titleLabel.bounds.size.height * 1.3, 0, 0, - btn.titleLabel.bounds.size.width)];
}



/**
 使按钮的图片在上，文字在下
 */
- (void)mk_resetButton {
    
    //使图片和文字水平居中显示
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    //调整文本框位置
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height * 1.3, - self.imageView.frame.size.width, 0, 0)];
    
    //设置文字
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setAdjustsFontSizeToFitWidth:NO];
    
    //调整图片位置
    [self setImageEdgeInsets:UIEdgeInsetsMake(- self.titleLabel.bounds.size.height * 1.3, 0, 0, - self.titleLabel.bounds.size.width)];
    
}


/**
 使按钮的图片在上，文字在下，并设置为灰色（不可用那种样子）
 */
- (void)mk_resetButtonDisable {
    
    //使图片和文字水平居中显示
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    //调整文本框位置
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height * 1.3, - self.imageView.frame.size.width, 0, 0)];
    
    //设置文字
    [self setTitleColor:[UIColor mk_colorWithRed:175 green:175 blue:175] forState:UIControlStateNormal];
    [self.titleLabel setAdjustsFontSizeToFitWidth:NO];
    
    //调整图片位置
    [self setImageEdgeInsets:UIEdgeInsetsMake(- self.titleLabel.bounds.size.height * 1.3, 0, 0, - self.titleLabel.bounds.size.width)];
    
}


/**
 重新设置按钮布局：文字在左，图片在右
 */
- (void)mk_resetButton_titleLeftImageRight {
    
    /** 原理
     uibutton默认是左图片，右文字。并且在设置edge insets之前，位置已经有了设定。所以设置title的edge insets，真实的作用是在原来的边距值基础上增加或减少某个间距，负值便是减少。以title为例，设置右边距增加图片宽度，就使得自己的右边界距离按钮的右边界多了图片的宽度，正好放下图片。此时，title lable变小了，而title lable的左边界还在原来的位置上，所以lable的左边界距离按钮的左边界减少图片的宽度，lable就和原来一样大了，而且左侧起始位置和图片的左侧起始位置相同了
     */
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.imageView.size.width, 0, self.imageView.size.width)];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, - self.titleLabel.bounds.size.width)];
    
}


//+ (instancetype)mk_Button:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor defaultImage:(UIimage *)defaultImage selectImage:(UIImage *)selectImage {
//    
//    UIButton *button = [[self alloc] init];
//    
//    [button setTitle:title forState:UIControlStateNormal];
//    
//    [button setTitleColor:normalColor forState:UIControlStateNormal];
//    [button setTitleColor:selectedColor forState:UIControlStateSelected];
//    
//    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
//    
//    [button sizeToFit];
//    
//    button.imageView = [UIImageView alloc] initWithImage:<#(nullable UIImage *)#>
    
//    return button;
//}

@end
