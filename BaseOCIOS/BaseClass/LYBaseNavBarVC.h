//
//  LYBaseNavBarVC.h
//  PureGarden
//
//  Created by xie dason on 2017/7/7.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SXBarViewPosition) {
    SXBarViewPositionLeft,
    SXBarViewPositionRight
};

@interface BarView : UIView
@property (nonatomic, assign) SXBarViewPosition position;
@property (nonatomic, assign) BOOL applied;
@end


@interface LYBaseNavBarVC : UIViewController

/** 主要用于设置返回按钮的文字 */
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *rightItemBtn;

#pragma mark -NavigationBar的一些默认设置,可在appdelegate中设置(默认值)
/** 设置NavigationBar默认的渲染色(NavigationBar的底色) */
+ (void)ly_setDefaultNavBarBarTintColor:(UIColor *)color;

/** 设置NavigationBar默认的图片(NavigationBar的底图) */
+ (void)ly_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** 设置NavigationBar中间title的默认文字属性 */
+ (void)ly_setDefaultNavBarTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes;

/** 设置NavigationBar默认的按钮渲染色(NavigationBar的按钮色) */
+ (void)ly_setDefaultNavBarTintColor:(UIColor *)color;


#pragma mark -NavigationBar的属性,可在有特殊需求的单个viewcontroller中设置
/** 设置NavigationBar的渲染色(NavigationBar的底色) */
- (void)ly_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)ly_navBarBarTintColor;

/** 设置NavigationBar的图片(NavigationBar的底图) */
- (void)ly_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)ly_navBarBackgroundImage;

/** 设置NavigationBar中间title的文字颜色 */
- (void)ly_setNavBarTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes;
- (NSDictionary<NSString *,id> *)ly_navBarTitleAttributes;

/** 设置NavigationBar的按钮渲染色(NavigationBar的按钮色) */
- (void)ly_setNavBarTintColor:(UIColor *)color;
- (UIColor *)ly_navBarTintColor;

@end
