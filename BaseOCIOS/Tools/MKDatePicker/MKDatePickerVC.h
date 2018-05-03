//
//  MKDatePickerVC.h
//  Demo-DatePicker
//
//  Created by 原鹏飞 on 2017/8/4.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKDatePickerVC : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, copy) void(^returnValueBlock)(NSString *backStr);

@end
