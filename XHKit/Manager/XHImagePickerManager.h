//
//  XHImagePickerManager.h
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHConfig.h"

#if kUseTZImagePikerControllerSDK
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import <Photos/Photos.h>
#endif

@interface XHImagePickerManager : NSObject

@property (nonatomic, assign) NSInteger maxImageCount; ///< 最大选择数
@property (nonatomic, assign) BOOL allowCrop;          ///< 是否允许裁剪

#if kUseTZImagePikerControllerSDK
/**
 使用系统自带ActionSheet
 @param controller 模态的控制器
 @param takePhoto 拍照回调
 @param selectedAssets 相册回调
 @return 管理对象
 */
+ (instancetype)actionSheetWithController:(UIViewController *)controller didTakePhoto:(void(^)(UIImage *image))takePhoto didSelectedAssets:(void (^)(NSArray<UIImage *> *photos))selectedAssets;
/**
 调用相机
 @param controller 模态的控制器
 @param takePhoto 拍照回调
 @return 管理对象
 */
+ (instancetype)cameraWithController:(UIViewController *)controller didTakePhoto:(void(^)(UIImage *image))takePhoto;
/**
 调用相册
 @param controller 模态的控制器
 @param selectedAssets 相册回调
 @return 管理对象
 */
+ (instancetype)assetsWithController:(UIViewController *)controller didSelectedAssets:(void (^)(NSArray<UIImage *> *photos))selectedAssets;
/**
 拍照
 */
- (void)takePhoto;
/**
 相册
 */
- (void)presentTZImagePickerController;
#endif

@end

