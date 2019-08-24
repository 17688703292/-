//
//  XHConfig.h
//  XHKitDemo
//
//  Created by zhu on 2018/11/14.
//  Copyright © 2018 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHExtern.h"

// 配置宏

/** 是否使用友盟 */
#define kUseUShareSDK 0
/** 是否使用TZImagePikerController */
#define kUseTZImagePikerControllerSDK 1

@interface XHConfig : NSObject

+ (NSDictionary *)getConfig;

@end
