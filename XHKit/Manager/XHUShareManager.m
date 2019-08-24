//
//  XHUShareTools.m
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHUShareManager.h"

@interface XHUShareManager ()
#if kUseUShareSDK
<UMSocialShareMenuViewDelegate>
#endif

@end

@implementation XHUShareManager

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    static XHUShareManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[XHUShareManager alloc] init];
    });
    return manager;
}

#if kUseUShareSDK
/**
 友盟分享面板
 @param type 分享类型
 @param title 分享标题
 @param message 分享文字
 @param image 分享图片
 @param url 分享链接
 */
- (void)xh_showShareViewWithType:(XHShareType)type title:(NSString *)title message:(NSString *)message image:(id)image url:(NSString *)url {
    [UMSocialUIManager setShareMenuViewDelegate:self];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession), @(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_QQ)]];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        switch (type) {
            case XHShareTypeText: {
                [self shareTextToPlatformType:platformType withTitle:title withMessage:message];
            }
                break;
            case XHShareTypeImage: {
                [self shareImageToPlatformType:platformType withTitle:title image:image];
            }
                break;
            case XHShareTypeTextImage: {
                [self shareImageAndTextToPlatformType:platformType withTitle:title image:image message:message];
            }
                break;
            case XHShareTypeUrl: {
                [self shareWebPageToPlatformType:platformType url:url title:title descr:message image:image];
            }
                break;
        }
    }];
}

/**
 友盟第三方登录
 @param platformType 第三方平台
 @param callBack 回调
 */
- (void)xh_getUserInfoForPlatform:(UMSocialPlatformType)platformType callBack:(void(^)(NSString *openId, NSString *name, NSString *iconurl))callBack {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [MBProgressHUD xh_showHudWithMessage:@"请求授权失败" toView:[UIApplication sharedApplication].keyWindow completion:nil];
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            DLog(@" uid: %@", resp.uid);
            DLog(@" openid: %@", resp.openid);
            DLog(@" accessToken: %@", resp.accessToken);
            DLog(@" refreshToken: %@", resp.refreshToken);
            DLog(@" expiration: %@", resp.expiration);
            // 用户数据
            DLog(@" name: %@", resp.name);
            DLog(@" iconurl: %@", resp.iconurl);
            DLog(@" gender: %@", resp.unionGender);
            // 第三方平台SDK原始数据
            DLog(@" originalResponse: %@", resp.originalResponse);
            callBack(resp.openid, resp.name, resp.iconurl);
        }
    }];
}

/**
 *  分享面板显示的回调
 */
- (void)UMSocialShareMenuViewDidAppear {
    DLog(@"分享面板调用成功");
}

/**
 *  返回分享面板的父窗口,用于嵌入在父窗口上显示
 *
 *  @param defaultSuperView 默认加载的父窗口
 *
 *  @return 返回实际的父窗口
 *  @note 返回的view应该是全屏的view，方便分享面板来布局。
 *  @note 如果用户要替换成自己的ParentView，需要保证该view能覆盖到navigationbar和statusbar
 *  @note 当前分享面板已经是在window上,如果需要切换就重写此协议，如果不需要改变父窗口则不需要重写此协议
 */
- (UIView*)UMSocialParentView:(UIView*)defaultSuperView {
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - Helper
// 分享文字
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title withMessage:(NSString *)message {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.title = title;
    messageObject.text = message;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            [MBProgressHUD xh_showHudWithMessage:@"分享失败" toView:[UIApplication sharedApplication].keyWindow completion:nil];
        }else{
            DLog(@"share response : %@", data);
        }
    }];
}
// 分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title image:(UIImage *)image {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = title;
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = image;
    [shareObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            [MBProgressHUD xh_showHudWithMessage:@"分享失败" toView:[UIApplication sharedApplication].keyWindow completion:nil];
        }else{
            DLog(@"share response : %@", data);
        }
    }];
}

// 图文
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title image:(UIImage *)image message:(NSString *)message {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = title;
    //设置文本
    messageObject.text = message;
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = image;
    [shareObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            [MBProgressHUD xh_showHudWithMessage:@"分享失败" toView:[UIApplication sharedApplication].keyWindow completion:nil];
        }else{
            DLog(@"share response : %@", data);
        }
    }];
}

// 网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType url:(NSString *)urlStr title:(NSString *)title descr:(NSString *)descr image:(id)icon
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:icon];
    //设置网页地址
    shareObject.webpageUrl = urlStr;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            [MBProgressHUD xh_showHudWithMessage:@"分享失败" toView:[UIApplication sharedApplication].keyWindow completion:nil];
        }else{
            DLog(@"share response : %@", data);
        }
    }];
}

#endif

@end
