//
//  NSString+MKAddition.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/12/29.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "NSString+MKAddition.h"

@implementation NSString (MKAddition)

/**
 转换成md5字符串

 @return md5
 */
- (NSString *)md5String {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str),result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16 ; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return [hash lowercaseString];//小写
}

@end
