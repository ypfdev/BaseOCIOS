//
//  LYBaseNavBarVC.m
//  PureGarden
//
//  Created by xie dason on 2017/7/7.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "LYBaseNavBarVC.h"

@implementation BarView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //因为iOS11导航栏的按钮添加了stackView控件,所以如果是iOS11就取出stackView然后重新设置约束
    if (self.applied || [[[UIDevice currentDevice] systemVersion] floatValue]  < 11) return;
    UIView *view = self;
    while (![view isKindOfClass:UINavigationBar.class] && view.superview) {
        view = [view superview];
        if ([view isKindOfClass:UIStackView.class] && view.superview) {
            if (self.position == SXBarViewPositionLeft) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeTrailing)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:0]];
                self.applied = YES;
            }
            else if (self.position == SXBarViewPositionRight) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeLeading)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeTrailing
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeTrailing
                                                                          multiplier:1.0
                                                                            constant:0]];
                self.applied = YES;
            }
            break;
        }
    }
}

@end


@interface LYBaseNavBarVC () <UIGestureRecognizerDelegate>

//navBar的背景色
@property (strong, nonatomic) UIColor *navBarBarTintColor;

//navBar的背景图
@property (strong, nonatomic) UIImage *navBarBackgroundImage;

//navBar的字体属性
@property (strong, nonatomic) NSDictionary<NSString *,id> *navBarTitleAttributes;

//navBar的按钮色
@property (strong, nonatomic) UIColor *navBarTintColor;

@end

//记录navBar的代理
static id<UIGestureRecognizerDelegate> _delegate;

//navBar的默认背景色
static UIColor *defaultNavBarBarTintColor;
//navBar的默认背景图
static UIImage *defaultNavBarBackgroundImage;
//navBar的默认字体属性
static NSDictionary<NSString *,id> *defaultNavBarTitleAttributes;
//navBar的默认按钮色
static UIColor *defaultNavBarTintColor;

@implementation LYBaseNavBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigationBar是navigationController的属性 //navigationItem是UIViewController的属性
    //这两个属性虽然都会影响导航栏,但是作用不同.navigationBar是影响视觉界别的一些背景色和背景图
    //navigationItem是控制按钮的
    
   
    //设置底色为白色
    self.view.backgroundColor = APP_COLOR_BG;

    //设置scrollview类不会自动下移64
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //透明度设置,显示我们希望的没有色差的颜色.系统默认为YES,会有额外的模糊view遮挡.设置为NO后没有这些view,但是视图weapperView会自动下移64个单位影响的地方多.
    self.navigationController.navigationBar.translucent = NO;
    //如果希望没有色差,可以通过颜色生成一张图片,然后设置BackgroundImage,这样就没有色差

}

#pragma mark - BarButtonItem
- (void)baseAddControl{

    // 自定义返回按钮
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_backButton setImage:[UIImage imageNamed:@"icon_backBtn"] forState:UIControlStateNormal];
    [_backButton setImage:[UIImage imageNamed:@"icon_backBtn"] forState:UIControlStateHighlighted];
    [_backButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [_backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //@available 第一个参数表示最低运行的版本,第二个参数表示平台(iphone ipad iwatch等)
    if (@available(iOS 11.0, *)) {
        BarView *barView = [[BarView alloc]initWithFrame:_backButton.bounds];
        
        [barView addSubview:_backButton];
        _backButton.center = barView.center;
        [barView setPosition:SXBarViewPositionLeft];
        //[self.navigationItem setLeftBarButtonItems:nil];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
    }else {
        //设置弹簧按钮,用于调整自定义返回按钮更加的靠近左边,因为ios11的stackView的问题,弹簧减少位置失效
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacer.width = -16;
        [self.navigationItem setLeftBarButtonItems:@[spacer, [[UIBarButtonItem alloc]initWithCustomView:_backButton]]];
    }

}
-(void)setRightItemBtn:(UIButton *)rightItemBtn{
    //导航栏右按钮
    _rightItemBtn = rightItemBtn;
    //@available 第一个参数表示最低运行的版本,第二个参数表示平台(iphone ipad iwatch等)
    if (@available(iOS 11.0, *)) {
        BarView *barView = [[BarView alloc] initWithFrame:_rightItemBtn.bounds];
        [barView addSubview:_rightItemBtn];
        self.rightItemBtn.center = barView.center;
        [barView setPosition:SXBarViewPositionRight];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
    }
    else{
        //设置弹簧按钮,用于调整自定义返回按钮更加的靠近右边,因为ios11的stackView的问题,弹簧减少位置失效
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacer.width = -16;
        [self.navigationItem setRightBarButtonItems:@[spacer, [[UIBarButtonItem alloc]initWithCustomView:_rightItemBtn]]];
        
    }
}

//返回按钮的方法
- (void)back:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //重置navBar属性
    //设置背景色
     [self.navigationController.navigationBar setBackgroundImage:self.ly_navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //当有背景图片的时候,背景色的设置无效
    [self.navigationController.navigationBar setBarTintColor:self.ly_navBarBarTintColor];
    //设置title属性
    [self.navigationController.navigationBar setTitleTextAttributes:self.ly_navBarTitleAttributes];
    //设置按钮渲染色
    [self.navigationController.navigationBar setTintColor:self.ly_navBarTintColor];
    
    if (self.navigationController.childViewControllers.count > 1) {
        //大于1的时候才表示有返回按钮
        [self baseAddControl];
    }
    
    if (self.navigationController.viewControllers.count > 1) {
        // 记录系统返回手势的代理
        _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        // 设置系统返回手势的代理为当前控制器
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
    self.navigationController.interactivePopGestureRecognizer.delegate = _delegate;
    
}

#pragma mark - UIGestureRecognizer
//UIGestureRecognizerDelegate手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark - 默认属性的设置方法
+ (void)ly_setDefaultNavBarBarTintColor:(UIColor *)color{
    defaultNavBarBarTintColor = color;
}

+ (void)ly_setDefaultNavBarBackgroundImage:(UIImage *)image{
    defaultNavBarBackgroundImage = image;
}

+ (void)ly_setDefaultNavBarTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes{
    defaultNavBarTitleAttributes = titleAttributes;
}

+ (void)ly_setDefaultNavBarTintColor:(UIColor *)color{
    defaultNavBarTintColor = color;
}

#pragma mark - 当前属性的设置方法
/** 设置NavigationBar的渲染色(NavigationBar的底色) */
- (void)ly_setNavBarBarTintColor:(UIColor *)color{
    _navBarBarTintColor = color;
}
- (UIColor *)ly_navBarBarTintColor{
    return _navBarBarTintColor ? _navBarBarTintColor : defaultNavBarBarTintColor;
}

/** 设置NavigationBar的图片(NavigationBar的底图) */
- (void)ly_setNavBarBackgroundImage:(UIImage *)image{
    //图片有可能尺寸不符合,所以拉伸图片
    _navBarBackgroundImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
}
- (UIImage *)ly_navBarBackgroundImage{
    return _navBarBackgroundImage ? _navBarBackgroundImage : defaultNavBarBackgroundImage;
}

/** 设置NavigationBar中间title的文字属性 */
- (void)ly_setNavBarTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes{
    _navBarTitleAttributes = titleAttributes;
}
- (NSDictionary<NSString *,id> *)ly_navBarTitleAttributes{
    return _navBarTitleAttributes ? _navBarTitleAttributes : defaultNavBarTitleAttributes;
}

/** 设置NavigationBar的按钮渲染色(NavigationBar的按钮色) */
- (void)ly_setNavBarTintColor:(UIColor *)color{
    _navBarTintColor = color;
}
- (UIColor *)ly_navBarTintColor{
    return _navBarTintColor ? _navBarTintColor : defaultNavBarTintColor;
}

@end
