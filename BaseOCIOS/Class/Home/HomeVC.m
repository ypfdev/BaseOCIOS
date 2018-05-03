//
//  HomeVC.m
//  BaseOCIOS
//
//  Created by YPF on 2018/4/27.
//  Copyright © 2018年 YPF. All rights reserved.
//

#import "HomeVC.h"
#import "MKAreaPickerVC.h"

@interface HomeVC ()

@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            //此处注意设置 y的值 不要使用屏幕高度 - 49 ，因为还有tabbar的高度 ，用当前tabbarController的View的高度 - 49即可
            view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-49, view.frame.size.width, 49);
        }
    }
    // 此处是自定义的View的设置 如果使用了约束 可以不需要设置下面,_bottomView的frame
//    _bottomView.frame = self.tabBar.bounds;
    
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
    [_testBtn addTarget:self action:@selector(testBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _testBtn.layer.masksToBounds = YES;
    _testBtn.layer.cornerRadius = 10;
    _testBtn.layer.borderWidth = 1;
    _testBtn.layer.borderColor = UIColor.blackColor.CGColor;
}

- (void)testBtnClicked:(UIButton *)sender {
    MKAreaPickerVC *targetVC = [[MKAreaPickerVC alloc]initWithNibName:@"MKAreaPickerVC" bundle:nil];
    targetVC.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 49);
    targetVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:targetVC animated:YES completion:^{
        
    }];
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
