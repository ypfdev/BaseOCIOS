//
//  MKDatePickerVC.m
//  Demo-DatePicker
//
//  Created by 原鹏飞 on 2017/8/4.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import "MKDatePickerVC.h"

@interface MKDatePickerVC ()

//按钮背景
@property (weak, nonatomic) IBOutlet UIView *btnBGView;

//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

//完成按钮
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (strong, nonatomic) NSDate *date;

@property (copy, nonatomic) NSString *backStr;

@end

@implementation MKDatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    //设置最小日期
    _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:86400];

    //设置最大日期
    _datePicker.maximumDate = [NSDate date];
}


- (void)setupUI {
    
    //MARK: 设置页面的半透明背景色
    self.view.backgroundColor = ColorAlphaBlack;
    
    
    //MARK: 设置选择器
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(APPWidth * 0.576);  //216
    }];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    
    
    //MARK: 设置按钮背景
    [_btnBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(APPWidth * 0.12);   //45
    }];
    
    
    //MARK: 设置按钮
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnBGView);
        make.left.equalTo(self.btnBGView).offset(APPWidth * 0.024); //9
        make.height.mas_equalTo(APPWidth * 0.12);   //45
        make.width.mas_equalTo(APPWidth * 0.16);    //60
    }];
    [self.cancelBtn setTitleColor:APP_COLOR forState:UIControlStateNormal];
    
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(self.cancelBtn);
        make.right.equalTo(self.btnBGView).offset(- APPWidth * 0.024);
    }];
    [self.finishBtn setTitleColor:APP_COLOR forState:UIControlStateNormal];
}


#pragma mark - 点击事件

//点击取消按钮
- (IBAction)cancelBtnClick:(id)sender {
    
    //模态返回上一个控制器
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"取消");
    }];
}


- (IBAction)finishBtnClick:(id)sender {
    
    //从 UIdatePicker 中获取事件
    NSDate * date = [self.datePicker date];
    //创建 Date 格式化工具
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    //格式日期格式化格式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //将日期转为格式化好的字符串
    NSString * dateString = [formatter stringFromDate:date];
    
//    //创建 警告对话框
//    NSString * message = [NSString stringWithFormat:@"UIDatePicker 被选中的时间是 %@", dateString];
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"时间选择" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    //显示警告对话框
//    [alertView show];
    
    //准备传值出去
    if(self.returnValueBlock) {
        _backStr = dateString;
        self.returnValueBlock(_backStr);
    }
    
    //
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"完成");
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
