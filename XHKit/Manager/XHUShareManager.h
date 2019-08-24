//
//  XHUShareTools.h
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+XHBlock.h"
#import "XHMacro.h"

#if kUseUShareSDK
#import <UShareUI/UShareUI.h>
#endif

typedef NS_ENUM(NSInteger, XHShareType) {
    XHShareTypeText,
    XHShareTypeImage,
    XHShareTypeTextImage,
    XHShareTypeUrl,
};

@interface XHUShareManager : NSObject

+ (instancetype)defaultManager;
#if kUseUShareSDK
/**
 友盟分享面板
 @param type 分享类型
 @param title 分享标题
 @param message 分享文字
 @param image 分享图片
 @param url 分享链接
 */
- (void)xh_showShareViewWithType:(XHShareType)type title:(NSString *)title message:(NSString *)message image:(id)image url:(NSString *)url;
/**
 友盟第三方登录
 @param platformType 第三方平台
 @param callBack 回调
 */
- (void)xh_getUserInfoForPlatform:(UMSocialPlatformType)platformType callBack:(void(^)(NSString *openId, NSString *name, NSString *iconurl))callBack;
#endif

@end
