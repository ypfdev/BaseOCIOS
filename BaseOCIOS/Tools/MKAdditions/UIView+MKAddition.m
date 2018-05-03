//
//  UIView+MKAddition.m
//  Miku
//
//  Created by 原鹏飞 on 16/5/11.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "UIView+MKAddition.h"

@implementation UIView (MKAddition)

- (UIImage *)mk_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
