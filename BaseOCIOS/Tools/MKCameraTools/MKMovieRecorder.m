//
//  MKMovieRecorder.m
//  Miku
//
//  Created by MK09 on 2017/5/5.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "MKMovieRecorder.h"

//多媒体（音视频）框架
#import <AVFoundation/AVFoundation.h>

//iOS9之后新增
#import <SafariServices/SafariServices.h>
/**
 #import <AVFoundation/AVCaptureDevice.h>
 #import <AVFoundation/AVCaptureInput.h>
 #import <AVFoundation/AVCaptureOutput.h>
 #import <AVFoundation/AVCaptureSession.h>
 #import <AVFoundation/AVCaptureVideoPreviewLayer.h>
 */



@interface MKMovieRecorder ()<AVCaptureFileOutputRecordingDelegate>

//输入设备(摄像头,录制画面)
@property(nonatomic,strong)AVCaptureDeviceInput *captureDeviceInputMovie;

//输入设备(麦克风，录制声音)
@property(nonatomic,strong)AVCaptureDeviceInput *captureDeviceInputMicro;

//输出设备：输出视频数据
//AVCaptureMovieFileOutput:直接使用url路径来录制视频  AVCaptureVideoDataOutput:通过二进制录制视频需要解码操作
@property(nonatomic,strong)AVCaptureMovieFileOutput *captureMovieFileOutput;

//拍摄会话
@property(nonatomic,strong)AVCaptureSession *captureSession;

//预览图层
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

//录制完成回调
@property(nonatomic,copy)void(^block)(NSURL *);

@end

@implementation MKMovieRecorder

+ (instancetype)shareInstance
{
    static MKMovieRecorder* manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MKMovieRecorder alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    //搭建拍摄会话
    
    return self;
}


- (void)beginMovieRocerderWithPreView:(UIView *)preView Completion:(void (^)(NSURL *))block
{
    //0.创建设备  defaultDeviceWithMediaType:根据多媒体类型创建默认设备（iPhone有两个摄像头  前置摄像头和后置摄像头  默认为后置摄像头）
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //1.创建输入设备 参数device：硬件设备（摄像头）
    self.captureDeviceInputMovie = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    
    //创建麦克风设备
    AVCaptureDevice *device1 = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //2.创建输入设备 参数device：硬件设备（麦克风）
    self.captureDeviceInputMicro = [[AVCaptureDeviceInput alloc] initWithDevice:device1 error:nil];
    
    //3.创建输出设备
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    //4.拍摄会话
    self.captureSession = [[AVCaptureSession alloc] init];
    
    //5.将输入设备添加到拍摄会话
    //添加之前需要做一个能够添加的判断:1.硬件损坏  2.模拟器
    if ([self.captureSession canAddInput:self.captureDeviceInputMicro] ) {
        [self.captureSession addInput:self.captureDeviceInputMicro];
    }
    if ([self.captureSession canAddInput:self.captureDeviceInputMovie] ) {
        [self.captureSession addInput:self.captureDeviceInputMovie];
    }
    
    if ([self.captureSession canAddOutput:self.captureMovieFileOutput] ) {
        [self.captureSession addOutput:self.captureMovieFileOutput];
    }
    
    
    
    //6.预览图层
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    
    //7.layer本身不能直接显示，需要添加到视图中
    [preView.layer addSublayer:self.captureVideoPreviewLayer];
    
    //8.1 layer通过bounds属性设置大小  通过position属性来设置位置（锚点）
    self.captureVideoPreviewLayer.bounds = preView.bounds;
    //    self.captureVideoPreviewLayer.position = preView.center;
    self.captureVideoPreviewLayer.anchorPoint = CGPointMake(0, 0);
    
    //9.开启拍摄会话
    [self.captureSession startRunning];
    
    //10.开始录制  url:视频保存的路径  Delegate：代理
    [self.captureMovieFileOutput startRecordingToOutputFileURL:self.movieURL recordingDelegate:self];
    //保存block
    self.block = block;
    
}

- (void)stopRecorder
{
    //1.拍摄会话结束工作
    [self.captureSession stopRunning];
    //2.移除预览图层
    [self.captureVideoPreviewLayer removeFromSuperlayer];
    //3.结束录制视频
    [self.captureMovieFileOutput stopRecording];
}

#pragma mark -AVCaptureFileOutputRecordingDelegate录制视频代理

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    NSLog(@"开始录制");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput willFinishRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    
    NSLog(@"结束录制");
    NSLog(@"视频地址%@",fileURL);
    
    //执行回调
    self.block(fileURL);
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSLog(@"结束录制");
    NSLog(@"视频地址%@",outputFileURL);
    
    //执行回调
    self.block(outputFileURL);
}

@end
