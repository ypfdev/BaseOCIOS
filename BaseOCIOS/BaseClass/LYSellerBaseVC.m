//
//  LYSellerBaseVC.m
//  PureGarden
//
//  Created by suhailian on 2017/9/15.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "LYSellerBaseVC.h"

@interface LYSellerBaseVC ()

@end

@implementation LYSellerBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//
    
    [self ly_setNavBarBackgroundImage:[UIImage imageNamed:@"seller_navigate_bar"]];
//    self.view.backgroundColor = APP_COLOR_BG;
//    [self setNavigationBar];
    
}

#pragma mark - 设置导航栏
//- (void)setNavigationBar{
//    
//    //设置导航栏
//    [self.navigationController.navigationBar setTintColor:APP_COLOR];
//
//    //返回按钮
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_backBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
//    self.navigationItem.leftBarButtonItem = backItem;
//}
//
////返回
//- (void)backClick {
//    
//    [self.navigationController popViewControllerAnimated:true];
//}

@end
