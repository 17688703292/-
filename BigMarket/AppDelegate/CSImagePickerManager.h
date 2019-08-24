//
//  CSImagePickerManager.h
//  HHMeeting
//
//  Created by zhu on 2018/9/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import <Photos/Photos.h>

@interface CSImagePickerManager : NSObject

@property (nonatomic, assign) NSInteger maxImageCount;
@property (nonatomic, assign) BOOL allowCrop;
+ (instancetype)presentVC:(UIViewController *)controller assetsCallback:(void (^)(NSArray<UIImage *> *photos))assetsCallback;
+ (instancetype)presentVC:(UIViewController *)controller cameraCallback:(void(^)(UIImage *image))cameraCallback assetsCallback:(void (^)(NSArray<UIImage *> *photos))assetsCallback;

@end

