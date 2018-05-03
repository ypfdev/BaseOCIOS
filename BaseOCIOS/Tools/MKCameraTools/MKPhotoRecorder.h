//
//  MKPhotoRecorder.h
//  Miku
//
//  Created by 原鹏飞 on 2017/5/19.
//  Copyright © 2017年 原鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol MKPhotoRecorderDelegate;

@interface MKPhotoRecorder : NSObject

//创建自定义相机  参数：预览视图
- (instancetype)initWithPreView:(UIView *)preView;

- (void)start;

- (void)stop;

//前后摄像头对调
- (void)switchCamera;

//拍照
- (void)capture:(void(^)(UIImage *))completion;

@property(nonatomic,weak)id<MKPhotoRecorderDelegate>delegate;

@end

@protocol MKPhotoRecorderDelegate <NSObject>

- (void)waterImage:(MKPhotoRecorder *)recorder;



@end
