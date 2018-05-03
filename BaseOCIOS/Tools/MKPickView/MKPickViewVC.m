//
//  MKPickViewVC.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/9/12.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "MKPickViewVC.h"

@interface MKPickViewVC () <UIPickerViewDataSource, UIPickerViewDelegate>

//选择器
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

//按钮的背景
@property (weak, nonatomic) IBOutlet UIView *btnBGView;

//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

//完成按钮
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

//第0列的选择的字符串
@property (copy, nonatomic) NSString *componentZeroStr;

//第1列的选择的字符串
@property (copy, nonatomic) NSString *componentOneStr;

//第2列的选择的字符串
@property (copy, nonatomic) NSString *componentTwoStr;

//返回的字符串
@property (copy, nonatomic) NSString *backStr;

////半透明遮罩背景
//@property (strong, nonatomic) ViewController *vc;

@end

@implementation MKPickViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    //当有传入数据数组时，设置默认选项
    if (_componentArr.count != 0) {
        switch (_componentArr.count) {
            case 1:
                _componentZeroStr = _componentArr[0][0];
                break;
            case 2:
                _componentZeroStr = _componentArr[0][0];
                _componentOneStr = _componentArr[1][0];
                break;
            case 3:
                _componentZeroStr = _componentArr[0][0];
                _componentOneStr = _componentArr[1][0];
                _componentTwoStr = _componentArr[2][0];
                break;
                
            default:
                NSLog(@"出错了");
                break;
        }
    }
}


- (void)setupUI {
    
    //MARK: 设置页面的半透明背景色
    self.view.backgroundColor = ColorAlphaBlack;
    //    self.view.alpha = 0.5;
    
    
    //MARK: 设置选择器
    
    [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(APPWidth * 0.576);  //216
    }];
    
    [self.pickView setShowsSelectionIndicator:YES];
    [self.pickView setBackgroundColor:[UIColor whiteColor]];
    [self.pickView setDataSource:self];
    [self.pickView setDelegate:self];
    

    //MARK: 设置按钮背景
    [_btnBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.pickView.mas_top);
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


//点击取消按钮
- (IBAction)cancelBtnClick:(id)sender {
    
    //模态返回上一个控制器
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"取消");
    }];
}


//点击完成按钮
- (IBAction)FinishBtnClick:(id)sender {
    
    //通过block传值出去
    if(self.returnValueBlock) {
        
        //根据数据数组
        switch (_componentArr.count) {
            case 1:
                _backStr = _componentZeroStr;
                self.returnValueBlock(_backStr);
                break;
            case 2:
                _backStr = [_componentZeroStr stringByAppendingString:@" - "];
                _backStr = [_backStr stringByAppendingString:_componentOneStr];
                self.returnValueBlock(_backStr);
                break;
            case 3:
                _backStr = [_componentZeroStr stringByAppendingString:@" - "];
                _backStr = [_backStr stringByAppendingString:_componentOneStr];
                _backStr = [_backStr stringByAppendingString:@" - "];
                _backStr = [_backStr stringByAppendingString:_componentTwoStr];
                self.returnValueBlock(_backStr);
                break;
                
            default:
                _backStr = @"出错了";
                self.returnValueBlock(_backStr);
                break;
        }
        
    }
    
    //模态返回上一个控制器
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"完成");
    }];
}


#pragma mark - UIPickViewDataSource

//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if (_componentArr.count != 0) {
        return _componentArr.count;
    }
    
    return 0;
}

//返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (_componentArr.count != 0) {
        return _componentArr[component].count;
    }
    
    return 0;
}


#pragma mark - UIPickViewDelegate

//返回每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    //根据列数（传入数据数组的count）设置每列的宽度
    switch (_componentArr.count) {
        case 1:
            return pickerView.bounds.size.width;
            break;
        case 2:
            return pickerView.bounds.size.width / 2;
            break;
        case 3:
            return pickerView.bounds.size.width / 3;
            break;
            
        default:
            return pickerView.bounds.size.width;
            break;
    }
}

//返回每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 30;
}


/**
 返回某列某行的显示的标题
 
 @param pickerView 选择器视图
 @param row 行数
 @param component 列数
 @return title字符串
 */
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = [NSString stringWithFormat:@"%@", _componentArr[component][row]];
    
    return title;
}


/**
 选择某列某行
 
 @param pickerView 选择器视图
 @param row 行数
 @param component 列数
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //    // 使用一个UIAlertView来显示用户选中的列表项
    //    UIAlertView* alert = [[UIAlertView alloc]
    //                          initWithTitle:@"提示"
    //                          message:[NSString stringWithFormat:@"选中的是：%@"
    //                                   , _componentArr[component][row]]
    //                          delegate:nil
    //                          cancelButtonTitle:@"确定"
    //                          otherButtonTitles:nil];
    //    [alert show];
    
    
    //    //返回字符串
    //    if ([_keyStr isEqualToString:@"state"] == YES) {
    //        _backStr = [NSString stringWithFormat:@"%@", _componentArr[component][row]];
    //    }
    //    else if ([_keyStr isEqualToString:@"birthday"] == YES) {
    //
    //    }
    
    switch (component) {
        case 0:
            _componentZeroStr = _componentArr[0][row];
            break;
        case 1:
            _componentOneStr = _componentArr[1][row];
            break;
        case 2:
            _componentTwoStr = _componentArr[2][row];
            break;
        default:
            NSLog(@"出错了");
            break;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
