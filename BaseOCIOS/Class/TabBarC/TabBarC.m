//
//  TabBarC.m
//  BaseOCIOS
//
//  Created by YPF on 2018/4/27.
//  Copyright © 2018年 YPF. All rights reserved.
//

#import "TabBarC.h"
#import "HomeVC.h"
#import "CartVC.h"
#import "MeVC.h"

@interface TabBarC ()

@end

@implementation TabBarC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    self.tabBar.tintColor = UIColor.redColor;
    [self myAddChildVC];
}


/**
 添加子控制器
 */
- (void)myAddChildVC {
    
    // 添加首页
    HomeVC *homeVc = [[HomeVC alloc]init];
    [self addChildVC:homeVc andTitle:@"首页" andNormalImgName:@"icon_tab_home" andSelectedImgName:@"icon_tab_home_highlighted"];
    
    // 添加购物车
    CartVC *cartVC = [[CartVC alloc]init];
    [self addChildVC:cartVC andTitle:@"购物车" andNormalImgName:@"icon_tab_cart" andSelectedImgName:@"icon_tab_cart_highlighted"];
    
    // 添加我的
    MeVC *meVC = [[MeVC alloc]init];
    [self addChildVC:meVC andTitle:@"我的" andNormalImgName:@"icon_tab_me" andSelectedImgName:@"icon_tab_me_highlighted"];
    
    self.selectedIndex = 0;
}

- (void)addChildVC:(UIViewController *)childVC andTitle:(NSString *)title andNormalImgName:(NSString *)norImgName andSelectedImgName:(NSString *)selImgName {
    
    childVC.title = title;
    
    UIImage *norImg = [[UIImage imageNamed:norImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selImg = [[UIImage imageNamed:selImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:childVC];
    navC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:norImg selectedImage:selImg];
    
    [self addChildViewController:navC];
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
