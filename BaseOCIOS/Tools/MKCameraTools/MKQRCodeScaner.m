//
//  MKQRCodeScaner.m
//  Miku
//
//  Created by 原鹏飞 on 2017/4/26.
//  Copyright © 2017年 原鹏飞. All rights reserved.
//

#import "MKQRCodeScaner.h"

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



@interface MKQRCodeScaner ()<AVCaptureMetadataOutputObjectsDelegate>

//输入设备(摄像头，麦克风)
@property(nonatomic,strong)AVCaptureDeviceInput *captureDeviceInput;

//输出设备：二维码的原理就是用摄像头捕捉信息流

@property(nonatomic,strong)AVCaptureMetadataOutput *captureMetadataOutput;

//拍摄会话
@property(nonatomic,strong)AVCaptureSession *captureSession;

//预览图层
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

//扫描完成回调
@property(nonatomic,copy)void(^block)(NSString *);

@end

@implementation MKQRCodeScaner

+ (instancetype)shareInstance
{
    static MKQRCodeScaner* manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MKQRCodeScaner alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    //搭建拍摄会话

    return self;
}


- (void)beginQRCodeScanWithPreView:(UIView *)preView Completion:(void (^)(NSString *))block
{
    //0.创建设备  defaultDeviceWithMediaType:根据多媒体类型创建默认设备（iPhone有两个摄像头  前置摄像头和后置摄像头  默认为后置摄像头）
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //1.创建输入设备 参数device：硬件设备（摄像头，麦克风）
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    
    //2.创建输出设备
    self.captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //3.设置输出设备的代理（当摄像头捕捉到数据时通过代理告知APP）
    [self.captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    
    
    //4.拍摄会话
    self.captureSession = [[AVCaptureSession alloc] init];
    
    //5.将输入设备添加到拍摄会话
    //添加之前需要做一个能够添加的判断:1.硬件损坏  2.模拟器
    if ([self.captureSession canAddInput:self.captureDeviceInput] ) {
        [self.captureSession addInput:self.captureDeviceInput];
    }
    
    if ([self.captureSession canAddOutput:self.captureMetadataOutput] ) {
        [self.captureSession addOutput:self.captureMetadataOutput];
    }
    
    //6.设置输出设备捕捉信息流类型：这是一个数组  AVMetadataObjectTypeQRCode:二维码 AVMetadataObjectTypeEAN13Code：中国常用的一维码
    /*注意！！！！！  输出设备要先添加到拍摄会话中才可以设置捕捉类型，否会崩溃报错：[AVCaptureMetadataOutput setMetadataObjectTypes:] - unsupported type found.  Use -availableMetadataObjectTypes*/
    //1.捕捉类型越多，扫描数据的耗时就越长  2.一维码世界各国有很多标准  中国：EAN格式
    [self.captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
   
    
    //7.预览图层
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    
    //8.layer本身不能直接显示，需要添加到视图中
    [preView.layer addSublayer:self.captureVideoPreviewLayer];
    
    //8.1 layer通过bounds属性设置大小  通过position属性来设置位置（锚点）
    self.captureVideoPreviewLayer.bounds = preView.bounds;
//    self.captureVideoPreviewLayer.position = preView.center;
    self.captureVideoPreviewLayer.anchorPoint = CGPointMake(0, 0);
    
    //9.开启拍摄会话
    [self.captureSession startRunning];
    
    
    //保存block
    self.block = block;
    
}

#pragma mark -AVCaptureMetadataOutputObjectsDelegate扫描代理

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描到的数据
    NSLog(@"%@",metadataObjects);
    
    //遍历数组
    for (AVMetadataMachineReadableCodeObject *object in metadataObjects) {
        
        NSLog(@"%@",object.stringValue);
        
        if(self.block)
        {
            self.block(object.stringValue);
        }
    }
}

@end
