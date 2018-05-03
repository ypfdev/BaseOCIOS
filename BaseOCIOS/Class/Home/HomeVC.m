//
//  HomeVC.m
//  BaseOCIOS
//
//  Created by YPF on 2018/4/27.
//  Copyright © 2018年 YPF. All rights reserved.
//

#import "HomeVC.h"
#import <Masonry.h>
#import "MKAdditions.h"

@interface HomeVC ()

@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor redColor];
    [self myAddSubviews];
}

- (void)myAddSubviews {
    _testBtn = [[UIButton alloc]init];
    [self.view addSubview:_testBtn];
    [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
    }];
    [_testBtn setTitle:@"TestBtn" forState:UIControlStateNormal];
    _testBtn.layer.masksToBounds = YES;
    _testBtn.layer.cornerRadius = 10;
    _testBtn.layer.borderWidth = 1;
    _testBtn.layer.borderColor = UIColor.blackColor.CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
