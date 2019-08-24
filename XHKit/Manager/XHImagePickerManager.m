//
//  XHImagePickerManager.m
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHImagePickerManager.h"
#import "XHMacro.h"

@interface XHImagePickerManager ()
#if kUseTZImagePikerControllerSDK
<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
#endif

@property (nonatomic, weak) UIViewController *presentVC;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, copy) void (^cameraCallback)(UIImage *image);
@property (nonatomic, copy) void (^assetsCallback)(NSArray<UIImage *> *photos);

@end

@implementation XHImagePickerManager

#if kUseTZImagePikerControllerSDK
+ (instancetype)actionSheetWithController:(UIViewController *)controller didTakePhoto:(void(^)(UIImage *image))takePhoto didSelectedAssets:(void (^)(NSArray<UIImage *> *photos))selectedAssets {
    XHImagePickerManager *imagePickerManager = [[XHImagePickerManager alloc] init];
    imagePickerManager.presentVC = controller;
    imagePickerManager.cameraCallback = takePhoto;
    imagePickerManager.assetsCallback = selectedAssets;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [imagePickerManager takePhoto];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [imagePickerManager presentTZImagePickerController];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [controller presentViewController:alertVC animated:true completion:nil];
    
    return imagePickerManager;
}

+ (instancetype)cameraWithController:(UIViewController *)controller didTakePhoto:(void(^)(UIImage *image))takePhoto {
    XHImagePickerManager *imagePickerManager = [[XHImagePickerManager alloc] init];
    imagePickerManager.presentVC = controller;
    imagePickerManager.cameraCallback = takePhoto;
    return imagePickerManager;
}

+ (instancetype)assetsWithController:(UIViewController *)controller didSelectedAssets:(void (^)(NSArray<UIImage *> *photos))selectedAssets {
    XHImagePickerManager *imagePickerManager = [[XHImagePickerManager alloc] init];
    imagePickerManager.presentVC = controller;
    imagePickerManager.assetsCallback = selectedAssets;
    return imagePickerManager;
}

#pragma mark - Camera & Photo

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        [self showCameraAlert];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (@available(iOS 7.0, *)) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
    }
    else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self showPhotoAlert];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self presentImagePickerController];
    }
}

- (void)showCameraAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.presentVC presentViewController:alertController animated:true completion:nil];
}

- (void)showPhotoAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.presentVC presentViewController:alertController animated:true completion:nil];
}

- (void)presentImagePickerController {
    // 提前定位
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        self.location = locations[0];
    } failureBlock:^(NSError *error) {
        self.location = nil;
    }];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        self.imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.presentVC presentViewController:self.imagePickerVc animated:YES completion:^{
            self.imagePickerVc.delegate = self;
        }];
    } else {
        DLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)presentTZImagePickerController {
    NSInteger count = self.maxImageCount ? self.maxImageCount : 1;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.navigationItem.title = @"相册";
    imagePickerVc.naviBgColor = [UIColor darkGrayColor];
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = self.allowCrop;
    
    // 设置竖屏下的裁剪尺寸
    NSInteger centerY = kScreenHeight/2;
    imagePickerVc.cropRect = CGRectMake(0, centerY-kScreenWidth/2, kScreenWidth, kScreenWidth);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (self.assetsCallback) {
            self.assetsCallback(photos);
        }
    }];
    [self.presentVC presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if (!self.allowCrop) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.cameraCallback) {
            self.cameraCallback(image);
        }
        return;
    }
    
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        __weak typeof(self) weakSelf = self;
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error) {
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                DLog(@"图片保存失败 %@", error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                            if (self.cameraCallback) {
                                self.cameraCallback(cropImage);
                            }
                        }];
                        NSInteger centerY = kScreenHeight/2;
                        imagePicker.cropRect = CGRectMake(0, centerY-kScreenWidth/2, kScreenWidth, kScreenWidth);
                        [weakSelf.presentVC presentViewController:imagePicker animated:YES completion:nil];
                    }];
                }];
            }
        }];
    }
}


#pragma mark - Lazy Load

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.presentVC.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.presentVC.navigationController.navigationBar.barTintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

#endif

@end
