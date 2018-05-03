//
//  LYNetWorkManager.m
//  PureGarden
//
//  Created by xie dason on 2017/12/20.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "LYNetWorkManager.h"

@implementation LYNetWorkManager

#ifdef DEBUG //处于开发测试阶段
//端口号
//NSString * const LYBaseURL = @"http://api.puregarden.cn:59911/";
NSString * const LYBaseURL = @"http://api1.lenwin.cn:59913/";

///< 关闭https SSL 验证
#define kOpenHttpsAuth NO

#else //处于发布正式阶段

NSString * const LYBaseURL = @"http://api.lenwin.cn:53621/";

///< 开启https SSL 验证
#define kOpenHttpsAuth YES

#endif

static AFHTTPSessionManager *manager;


+ (AFHTTPSessionManager *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这里写成单例是因为afn的manager不是单例,每次获取都会重新创建,造成内存泄漏
        manager =[AFHTTPSessionManager manager];
       
        //http协议
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    
    return manager;
}


/**
 http请求
 
 @param module 模块名eg:"HomePage"
 @param path 方法名eg:"GetIndexAd"
 @param parameters 参数字典
 @param uploadProgress 进度block
 @param success 成功的block
 @param failure 失败的block
 @return task
 */
+ (NSURLSessionDataTask *)POSTWithmodule:(NSString *)module
                                    path:(NSString *)path
                              parameters:(id)parameters
                                progress:(void (^)(NSProgress *))uploadProgress
                                 success:(void (^)(NSURLSessionDataTask *, id))success
                                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    AFHTTPSessionManager *manager =[LYNetWorkManager shareManager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@.asmx/%@?WSDL",LYBaseURL,module,path];
    
    //公共参数 @"sign":@"",@"t":INTERVAL_STRING,@"from":@"iOS",@"UserId":0
    //记录:sign只是安全验证(张科说的)
    //注意,现在后台不区分大小写,所以这里添加了userid如果有其他接口需要传同样的key(不区分大小写)的时候,会请求失败,所以在单个请求的时候,我们就不传那个userid了,但是如果key是"user_id"的话还是需要传的
    NSMutableDictionary *publicParameter = [NSMutableDictionary dictionaryWithDictionary: @{@"sign":@"",@"t":INTERVAL_STRING,@"from":@"iOS",@"UserId":@([LYUser defaultUser].userId)}];
    
    [publicParameter addEntriesFromDictionary:parameters];
    
    return [manager POST:urlStr parameters:publicParameter progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        //历史遗留问题,导致了返回值带有xml的标签,这里做截取字符串处理
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSRange range1 = [str rangeOfString:@"<string"];
        NSString *str1 = [str substringFromIndex:range1.location+range1.length];
        
        NSRange range2 = [str1 rangeOfString:@">"];
        NSString *str2 = [str1 substringFromIndex:range2.location+range2.length];
        
        NSRange range3 = [str2 rangeOfString:@"</string>"];
        NSString *str3 = [str2 substringToIndex:range3.location];
        
        // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
        id obj = [NSJSONSerialization JSONObjectWithData:[str3 dataUsingEncoding:(NSUTF8StringEncoding)] options:0 error:NULL];
        
        if (obj) {
            //成功后,外界不需要再判断转model会不会失败
            success(task,obj);
        }else{
            //转换失败后直接调用失败的block
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1000 userInfo:@{NSStringEncodingErrorKey:@"获取的网络数据转json失败"}];
            NSLog(@"%@",error);
            if (failure) {failure(task,error);}
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (failure) {failure(task,error);}        
    }];
    
}


@end
