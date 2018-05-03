//
//  LYUser.h
//  PureGarden
//
//  Created by xie dason on 2017/8/1.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYUserModel;
@interface LYUser : NSObject

//服务器返回的身份识别
@property(nonatomic,strong,readonly)NSString *pincode;

//用户Id
@property(nonatomic,assign,readonly)NSInteger userId;

//用户类型：0-普通会员（即买家，默认），1-代理商，2-门店, 4-经销商
@property (nonatomic, assign, readonly) NSInteger user_type;

//用户头像
@property(nonatomic,strong)NSString *avatar;

//是否已经登录
@property(nonatomic,assign,getter=isLogin,readonly)BOOL login;

/**
 ----------新增手机绑定相关参数----------
 */
//当前是否绑定手机号的状态：1-已绑定
@property (nonatomic, assign) NSInteger isMobile;
//当前已绑定的手机号
@property (nonatomic, strong) NSString *mobile;

/**
 ----------新增“我的”页面运营中心显示当前登录账户的团队角色----------
 */
//用户门店身份：0普通会员，1店主，2店长，3营业员
@property (nonatomic, assign, readonly) NSInteger userRole;
@property (nonatomic, assign) NSInteger shopUserId;//店铺用户id

//单例类
+ (instancetype)defaultUser;

//用户的信息填充
- (void)fillDataWithUserData:(LYUserModel*)model;

//登出操作
- (void)logOut;

//推出登录页面
- (void)presentLoginVCFromFatherVC:(UIViewController *)fatherVC;

//返回用户对应的身份类型
- (NSString *)userRoleName;

@end
