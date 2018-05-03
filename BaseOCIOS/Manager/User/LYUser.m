//
//  LYUser.m
//  PureGarden
//
//  Created by xie dason on 2017/8/1.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "LYUser.h"
#import "LYUserModel.h"
#import <SAMKeychain.h>
#import "JPUSHService.h"// 引入JPush功能所需头文件

@implementation LYUser

static id _instance;

+ (LYUser *)defaultUser{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[super alloc]init];
    });
    
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [super allocWithZone:zone];
        
    });
    
    return _instance;
    
}

- (void)fillDataWithUserData:(LYUserModel *)model{
    
    _userId = model.userId;
    _pincode = model.pincode;
    _avatar = model.avatar;
    _user_type = model.user_type;
    _isMobile = model.isMobile;
    _mobile = model.mobile;
    _userRole = model.userRole;
    _shopUserId = model.shopUserId;
    
    //登录成功标记
    _login = _userId;
    
    if (_login) {
        //赋值登录成功过后应该把数据存在本地
        [SAMKeychain setPasswordData:[model yy_modelToJSONData] forService:[NSBundle mainBundle].bundleIdentifier account:@"userInfo"];
        
//    //设置指定用户的推送tag
//      NSSet *set = [[NSSet alloc]initWithObjects:@"121", nil];
//        [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//            NSLog(@"设置结果:%zd 用户别名:%@",iResCode,iTags);
//        } seq:0];
        
    //设置指定用户的推送别名  //与上面方法二选一
        NSString *aliasStr = [NSString stringWithFormat:@"%zd",_userId];
        [JPUSHService setAlias:aliasStr completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:0];
    }
}

- (void)presentLoginVCFromFatherVC:(UIViewController *)fatherVC{
    
    //初始化登录界面
    UIStoryboard *storyLoginVC = [UIStoryboard storyboardWithName:@"HCLoginVC" bundle:nil];
    UIViewController *loginVC = storyLoginVC.instantiateInitialViewController;

    
    [fatherVC presentViewController:loginVC animated:YES completion:nil];

}

//推出登录
- (void)logOut{
    
    _userId = 0;
    _pincode = @"";
    _avatar = @"";
    _user_type = 0;
    _login = NO;
    _isMobile = 0;
    _mobile = @"";
    _userRole = 0;
    
    [SAMKeychain deletePasswordForService:[NSBundle mainBundle].bundleIdentifier account:@"userInfo"];
    
//    //退出登录的时候置空tag
//    NSSet *set = [[NSSet alloc]initWithObjects:@"121", nil];
//    [JPUSHService deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//        
//    } seq:0];
 
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:0];
    
}

//根据身份类型返回对应身份类型的称谓
- (NSString *)userRoleName{
    
    NSString *userRoleName = @"";
    
    switch (_userRole) {
        case 0:
            
            break;
            
        case 1:
            userRoleName = @"[店主]";
            break;
            
        case 2:
            userRoleName = @"[店长]";
            break;
            
        case 3:
            userRoleName = @"[营业员]";
            break;
        default:
            break;
    }
    
    return userRoleName;
}

@end
