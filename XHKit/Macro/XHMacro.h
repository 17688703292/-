//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#ifndef XHMacro_h
#define XHMacro_h

#import <UIKit/UIKit.h>
#import "XHConfig.h"

#pragma mark - Helper
//------------------- Helper -------------------------
#define kImageName(a) [UIImage imageNamed:a]
#define kImageUrl(storeId,a) [NSURL URLWithString:[a containsString:@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com"] || [a containsString:@"https://ydshop-photo.oss-cn-shenzhen.aliyuncs.com"] || [a containsString:@"http"] ? a: [NSString stringWithFormat:@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/shop/store/goods/%@/%@",storeId,a]]

#define kImageStr(storeId,a) [a containsString:@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com"] || [a containsString:@"https://ydshop-photo.oss-cn-shenzhen.aliyuncs.com"] || [a containsString:@"http"] ? a: [NSString stringWithFormat:@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/shop/store/goods/%@/%@",storeId,a]

#define kConfig(key) [[XHConfig getConfig] objectForKey:key]
#define kStoryboradController(a, b) [[UIStoryboard storyboardWithName:a bundle:nil] instantiateViewControllerWithIdentifier:b]
// 验证值存在且不为null
#define kValuableValue(value) value && ![value isEqual:[NSNull null]]
// 比例
#define kRatio         (kScreenWidth/375.0f)

#pragma mark - App
//------------------- App -------------------------
#define kAppDelegate    ((AppDelegate *)[UIApplication sharedApplication].delegate)

//------------------- 屏幕 -------------------------
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds


#pragma mark - Phone 手机
//------------------- 手机 -------------------------

#define is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

//------------------- 打印日志 -------------------------
#pragma mark - 打印日志
#ifdef DEBUG
/** DEBUG 模式下打印日志,当前行 */
#define DLog(fmt, ...) NSLog((@"\n%s\nline = %d\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//弱引用
#define kWeak(self) @autoreleasepool{} __weak typeof(self) self##Weak = self;
//强引用
#define kStrong(self) @autoreleasepool{} __strong typeof(self##Weak) self = self##Weak;

//提示需要实现父类方法
#define NS_REQUIRES_SUPER __attribute__((objc_requires_super))


// 安全区域
#define kSafeAreaTop(view) [XHTools safeAreaInsetsInView:view].top
#define kSafeAreaBottm(view) [XHTools safeAreaInsetsInView:view].bottom
#define kSafeAreaLeft(view) [XHTools safeAreaInsetsInView:view].left
#define kSafeAreaRight(view) [XHTools safeAreaInsetsInView:view].right

/**    状态栏高度 */
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
/**    导航栏高度 */
#define kNavigationBarHeight self.navigationController.navigationBar.height
/**    状态栏加导航栏高度 */

#define kStatusBarAndNavigationBarHeight \
([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.height)
/**    tabbar高度 */
#define kTabBarHeight  self.tabBarController.tabBar.height

#endif /* XHMacro_h */

/** 加载页面出错，重新加载*/
#define LoadViewResult @"LoadViewResult"
