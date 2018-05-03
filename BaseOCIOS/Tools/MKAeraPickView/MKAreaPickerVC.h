//
//  MKAreaPickerVC.h
//  PickerView省市区三级联动
//
//  Created by 原鹏飞 on 2017/2/18.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKAreaPickerVC : UIViewController

//点击完成按钮的回调
@property (nonatomic,copy) void (^doneBlock)(NSDictionary *regionDict);

//点击取消按钮的回调
@property (nonatomic,copy) void (^cancelBlock)(void);

//需要修改的名字
@property (nonatomic, weak) UILabel *nameLabel;

//省的id
@property (nonatomic, assign) NSInteger proID;

//市的id
@property (nonatomic, assign) NSInteger cityID;

//区的id
@property (nonatomic, assign) NSInteger districtID;

//省的字符串
@property (nonatomic, copy) NSString *proStr;

//市的字符串
@property (nonatomic, copy) NSString *cityStr;

//区的字符串
@property (nonatomic, copy) NSString *districtStr;

//包含地理信息的字典
@property (nonatomic, copy) NSDictionary *regionDict;

@end
