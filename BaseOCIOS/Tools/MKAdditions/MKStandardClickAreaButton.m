//
//  MKStandardClickAreaButton.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/11/17.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "MKStandardClickAreaButton.h"

@implementation MKStandardClickAreaButton

//重写方法，实现增大按钮的有效点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
