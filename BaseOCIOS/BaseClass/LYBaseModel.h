//
//  LYBaseModel.h
//  PureGarden
//
//  Created by xie dason on 2017/7/24.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYBaseModel : NSObject <YYModel>

@property(nonatomic)NSInteger errCode;

@property(nonatomic,strong)NSString *errMsg;

@end
