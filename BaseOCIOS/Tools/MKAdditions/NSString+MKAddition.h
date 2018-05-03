//
//  NSString+MKAddition.h
//  PureGarden
//
//  Created by 原鹏飞 on 2017/12/29.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MKAddition)

/**
 转换成md5字符串
 
 @return md5
 */
- (NSString *)md5String;

@end
