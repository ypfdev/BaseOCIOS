//
//  HCBaseButton.m
//  PureGarden
//
//  Created by xie dason on 2017/7/5.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "HCBaseButton.h"
#import "UIImage+HCImage.h"

@implementation HCBaseButton

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = Font12;
    }
    return self;
}

//创建btn时,提供选中和未选中的文字颜色和背景颜色
- (void)normalTitleColor:(UIColor *)normalColor andSelectedTitleColor:(UIColor *)selectedTitleColor  andNormalBgColor:(UIColor *)normalBgColor andSelectedBgColor:(UIColor *)selectedBgColor{
    
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    
    [self setBackgroundImage:[UIImage imagewithColor:normalBgColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imagewithColor:selectedBgColor] forState:UIControlStateSelected];
    
}

//重写方法,取消高亮状态
- (void)setHighlighted:(BOOL)highlighted{
}

@end
