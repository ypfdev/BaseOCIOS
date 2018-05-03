//
//  MKQRCodeScaner.h
//  Miku
//
//  Created by 原鹏飞 on 2017/4/26.
//  Copyright © 2017年 原鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface MKQRCodeScaner : NSObject

+ (instancetype)shareInstance;


- (void)beginQRCodeScanWithPreView:(UIView *)preView Completion:(void(^)(NSString *))block;


@end
