//
//  CSScanVC.m
//  HHMeeting
//
//  Created by zhu on 2018/9/1.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "CSScanVC.h"

#import <AVFoundation/AVFoundation.h>

#define kBtnWH 18

@interface CSScanVC () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;               ///< 播放器
@property (nonatomic, strong) UIView *scanBgView;                        ///< 扫描框
@property (nonatomic, strong) UIView *scanView;                        ///< 扫描框
@property (nonatomic, strong) UIImageView *scanImgView;                ///< 动画图片
@property (nonatomic, strong) UILabel * noticeLabel;                   ///< 提示语
@property (nonatomic, strong) UIButton *lightBtn;                      ///< 手电筒按钮
@property (nonatomic, strong) CABasicAnimation *scanAnimation;         ///< 扫描动画
@property (strong,nonatomic) AVCaptureDevice *device;                  ///< 采集的设备
@property (strong,nonatomic) AVCaptureDeviceInput *input;              ///< 设备的输入
@property (strong,nonatomic) AVCaptureMetadataOutput *output;          ///< 输出
@property (strong,nonatomic) AVCaptureSession *session;                ///< 采集流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer; ///< 窗口

@end

@implementation CSScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫一扫";
//    [self.navigationController.navigationBar setShadowImage:[UIImage xh_imageWithColor:kRGBAColor(0, 0, 0, 0.7)]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage xh_imageWithColor:kRGBAColor(0, 0, 0, 0.7)] forBarMetrics:UIBarMetricsDefault];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized ||
       status == AVAuthorizationStatusNotDetermined) {
        // authorized
        [self startScan];
    } else if(status == AVAuthorizationStatusDenied){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertController animated:true completion:nil];
    }
    
    [self loadBeepSound];
    
    self.scanBgView.backgroundColor = KafkaColorWithRGBA(0, 0, 0, 0.7);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.view bringSubviewToFront:self.lightBtn];
    
}

#pragma mark - add subviews

- (void)addSubviews {
    [self.view addSubview:self.scanBgView];
    [self.scanBgView addSubview:self.scanView];
    [self.scanBgView addSubview:self.noticeLabel];
    [self.scanView addSubview:self.scanImgView];
    [self.scanBgView addSubview:self.lightBtn];
    
    return;
    UIButton *topLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    topLeft.userInteractionEnabled = false;
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [self.scanView addSubview:topLeft];
    [topLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scanView.mas_left);
        make.top.mas_equalTo(self.scanView.mas_top);
        make.width.height.mas_equalTo(kBtnWH);
    }];
    
    UIButton *topRight = [UIButton buttonWithType:UIButtonTypeCustom];
    topRight.userInteractionEnabled = false;
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [self.scanView addSubview:topRight];
    [topRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.scanView.mas_right);
        make.top.mas_equalTo(self.scanView.mas_top);
        make.width.height.mas_equalTo(kBtnWH);
    }];
    
    
    UIButton *bottomLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomLeft.userInteractionEnabled = false;
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [self.scanView addSubview:bottomLeft];
    [bottomLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scanView.mas_left);
        make.bottom.mas_equalTo(self.scanView.mas_bottom).offset(2);
        make.width.height.mas_equalTo(kBtnWH);
    }];
    
    UIButton *bottomRight = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomRight.userInteractionEnabled = false;
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [self.scanView addSubview:bottomRight];
    [bottomRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.scanView.mas_right);
        make.bottom.mas_equalTo(self.scanView.mas_bottom).offset(2);
        make.width.height.mas_equalTo(kBtnWH);
    }];
    
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.7 * kScreenWidth,  0.7 * kScreenWidth));
        make.centerX.mas_equalTo(self.scanBgView.mas_centerX);
        make.centerY.mas_equalTo(self.scanBgView.mas_centerY);
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 20));
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(self.scanView.mas_bottom).with.offset(20);
    }];
    
    [self.scanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.scanView.mas_top).offset(-0.7 * kScreenWidth);
        make.height.mas_equalTo(0.7 * kScreenWidth);
    }];
    
    [self.lightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.scanView.mas_top).offset(-50);
        make.centerX.mas_equalTo(self.scanBgView.mas_centerX);
        make.width.height.mas_equalTo(60);
    }];
}

#pragma mark - start saomiao

- (void)startScan {
    //添加框和线
    [self addSubviews];
   [self makeConstraintsForUI];
    
    dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_SERIAL), ^{
    // Device 实例化设备   //获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input 设备输入     //创建输入流
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output 设备的输出  //创建输出流
    self.output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // Session         //初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // 二维码类型 AVMetadataObjectTypeQRCode
    self.output.metadataObjectTypes =@[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    
    // Preview 扫描窗口设置
        
        dispatch_async(dispatch_get_main_queue(), ^{
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarAndNavigationBarHeight);
    self.output.rectOfInterest = CGRectMake((self.view.height/2-kScreenWidth*0.7/2)/self.view.height, 0.15, (0.7*kScreenWidth)/self.view.height, 0.7);
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    // Start 开始扫描   //开始捕获
    [self.session startRunning];
           
            [self.scanImgView.layer addAnimation:self.scanAnimation forKey:nil];
        });
   });
}


- (void)loadBeepSound {
    
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"scan" ofType:@"wav"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [self.audioPlayer prepareToPlay];
    }
}

#pragma mark - AVCaptureMetadataOutputObjects delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    if (metadataObjects.count>0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        
        NSString *result = metadataObject.stringValue;
        
        if (![result containsString:@"http://www.ydmall.xyz/mobile/register?code="]) {
            [MBProgressHUD xh_showHudWithMessage:@"非邀请人二维码" toView:self.view completion:^{
                // Start 开始扫描   //开始捕获
                [self.session startRunning];
                [self.scanImgView.layer addAnimation:self.scanAnimation forKey:nil];
            }];
        
            return;
        }else{
            
            if (self.ScanResult) {
                NSArray *arry = [result componentsSeparatedByString:@"http://www.ydmall.xyz/mobile/register?code="];
                self.ScanResult(arry.lastObject);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       
    }
}

#pragma mark - setter and getter


- (UIView *)scanBgView {
    if (!_scanBgView) {
        
        _scanBgView = [[UIView alloc] init];
        _scanBgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return _scanBgView;
}

- (UIView *)scanView {
    if (!_scanView) {
        _scanView = [[UIView alloc] init];
        _scanView.layer.borderColor = [UIColor whiteColor].CGColor;
        _scanView.layer.borderWidth = 0.5;
        _scanView.clipsToBounds = true;
    }
    return _scanView;
}

- (UIImageView *)scanImgView {
    if (!_scanImgView) {
        _scanImgView = [[UIImageView alloc] initWithImage:kImageName(@"scan_net")];
    }
    return _scanImgView;
}

- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.textColor = [UIColor whiteColor];
        _noticeLabel.font = [UIFont systemFontOfSize:15];
        _noticeLabel.text = @"将二维码/条码放入框内，即可进行扫描";
    }
    return _noticeLabel;
}

- (UIButton *)lightBtn {
    if (!_lightBtn) {
        _lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lightBtn setImage:kImageName(@"but_light_sel") forState:UIControlStateNormal];
        [_lightBtn addTarget:self
                     action:@selector(clickLightButton:)
           forControlEvents:UIControlEventTouchUpInside];
        _lightBtn.contentMode = UIViewContentModeCenter;

    }
    return _lightBtn;
}

- (void)clickLightButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (btn.selected) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}
- (CABasicAnimation *)scanAnimation {
    if (!_scanAnimation) {
        _scanAnimation = [CABasicAnimation animation];
        _scanAnimation.keyPath = @"transform.translation.y";
        _scanAnimation.byValue = @(0.7*kScreenWidth);
        _scanAnimation.duration = 2;//设置滑动动画时间间隔
        _scanAnimation.repeatCount = MAXFLOAT;
    }
    return _scanAnimation;
}

@end

