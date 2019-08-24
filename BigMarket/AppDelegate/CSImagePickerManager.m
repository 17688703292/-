//
//  CSImagePickerManager.m
//  HHMeeting
//
//  Created by zhu on 2018/9/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "CSImagePickerManager.h"
#import <TZImagePickerController/TZImageManager.h>

@interface CSImagePickerManager () <TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIViewController *presentVC;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, copy) void (^cameraCallback)(UIImage *image);
@property (nonatomic, copy) void (^assetsCallback)(NSArray<UIImage *> *photos);

@end

@implementation CSImagePickerManager

+ (instancetype)presentVC:(UIViewController *)controller cameraCallback:(void (^)(UIImage *))cameraCallback assetsCallback:(void (^)(NSArray<UIImage *> *))assetsCallback  {
    
    CSImagePickerManager *imagePickerManager = [[CSImagePickerManager alloc] init];
    imagePickerManager.presentVC = controller;
    imagePickerManager.cameraCallback = cameraCallback;
    imagePickerManager.assetsCallback = assetsCallback;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [imagePickerManager takePhoto];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [imagePickerManager pushTZImagePickerController];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [controller presentViewController:alertVC animated:true completion:nil];
    
    return imagePickerManager;
}

+ (instancetype)presentVC:(UIViewController *)controller assetsCallback:(void (^)(NSArray<UIImage *> *))assetsCallback {
    
    CSImagePickerManager *imagePickerManager = [[CSImagePickerManager alloc] init];
    imagePickerManager.presentVC = controller;
    imagePickerManager.assetsCallback = assetsCallback;
    [imagePickerManager pushTZImagePickerController];
    
    return imagePickerManager;
}

#pragma mark - Camera & Photo

- (void)takePhoto {
    
    __weak typeof(self) weakSelf = self;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        [self showCameraAlert];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
    }
    else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self showPhotoAlert];
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [weakSelf takePhoto];
        }];
    } else {
        [self pushImagePickerController];
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

- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = locations[0];
    } failureBlock:^(NSError *error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            self.imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self.presentVC presentViewController:self.imagePickerVc animated:YES completion:^{
            self.imagePickerVc.delegate = self;
        }];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController {
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
        NSLog(@"-----%@", assets);
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
        // save photo and get asset / 保存图片，获取到asse
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
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
                            NSLog(@"%@", asset);
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
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.presentVC.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.presentVC.navigationController.navigationBar.barTintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

@end
