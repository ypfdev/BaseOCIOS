//
//  LYNetWorkManager.h
//  PureGarden
//
//  Created by xie dason on 2017/12/20.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//#import <AFNetworkReachabilityManager.h>

@interface LYNetWorkManager : NSObject

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
                                progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
