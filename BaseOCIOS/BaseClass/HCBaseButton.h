//
//  HCBaseButton.h
//  PureGarden
//
//  Created by xie dason on 2017/7/5.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <UIKit/UIKit.h>

///这是一个取消btn高亮状态的类
@interface HCBaseButton : UIButton

- (void)normalTitleColor:(UIColor *)normalColor andSelectedTitleColor:(UIColor *)selectedTitleColor  andNormalBgColor:(UIColor *)normalBgColor andSelectedBgColor:(UIColor *)selectedBgColor;

@end
