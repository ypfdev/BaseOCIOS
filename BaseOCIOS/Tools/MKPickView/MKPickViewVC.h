//
//  MKPickViewVC.h
//  PureGarden
//
//  Created by 原鹏飞 on 2017/9/12.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKPickViewVC : UIViewController

//列数
@property (assign, nonatomic) NSInteger componentNum;

//保存各列数据的数组
@property (strong, nonatomic) NSArray <NSArray *> *componentArr;

//用来识别返回字符串格式的key
@property (copy, nonatomic) NSString *keyStr;

//返回字符串的回调
@property (copy, nonatomic) void(^returnValueBlock)(NSString *str);

@end
