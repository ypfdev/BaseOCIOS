//
//  MKMovieRecorder.h
//  Miku
//
//  Created by 原鹏飞 on 2017/5/5.
//  Copyright © 2017年 原鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface MKMovieRecorder : NSObject

//视频保存的路径
@property(nonatomic,strong)NSURL *movieURL;



/**
 开始录制视频

 @param preView 预览视图
 @param block 完成回调
 */
- (void)beginMovieRocerderWithPreView:(UIView *)preView Completion:(void (^)(NSURL *))block;

- (void)stopRecorder;

@end
