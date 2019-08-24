//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XHBlock)
/**
 加载样式HUD
 
 @param view 显示的父视图
 @return HUD对象
 */
+ (instancetype)xh_showHudToView:(UIView *)view;

/**
 文字HUD 自动消失
 
 @param message 显示文字
 @param view 显示的父视图
 @param completion 隐藏后回调
 @return HUD对象
 */
+ (instancetype)xh_showHudWithMessage:(NSString *)message toView:(UIView *)view completion:(void(^)(void))completion;

/**
 吐司HUD
 
 @param message 显示文字
 @param view 显示的父视图
 @return HUD对象
 */
+ (instancetype)xh_showToastHudWithMessage:(NSString *)message toView:(UIView *)view completion:(void(^)(void))completion;

/**
 显示带图片的HUD 自动消失
 
 @param image 显示图片
 @param message 显示文字
 @param view 显示的父视图
 @param completion 隐藏后回调
 @return HUD对象
 */
+ (instancetype)xh_showImageHud:(UIImage *)image withMessage:(NSString *)message toView:(UIView *)view
                      comletion:(void(^)(void))completion;
/**
 环形进度条HUD

 @param message 显示文字
 @param view 父视图
 @return HUD对象
 */
+ (instancetype)xh_showAnnularDeterminateHudWithMessage:(NSString *)message toView:(UIView *)view;

/**
 饼状进度条HUD

 @param message 显示文字
 @param view 显示的父视图
 @return HUD对象
 */
+ (instancetype)xh_showDeterminateHudWithMessage:(NSString *)message toView:(UIView *)view;

/**
 横向进度条HUD

 @param message 显示文字
 @param view 显示的父视图
 @return HUD对象
 */
+ (instancetype)xh_showDeterminateHorizontalBarHudWithMessage:(NSString *)message toView:(UIView *)view;

/**
 GIF状态HUD 显示XHHudManager中的images

 @param view 显示的父视图
 @return HUD对象
 */
+ (instancetype)xh_showGIFHudToView:(UIView *)view;

/**
 GIF状态HUD

 @param images GIF图片数组
 @param view 显示的父视图
 @return HUD对象
 */
+ (instancetype)xh_showGifHudWithImages:(NSArray *)images toView:(UIView *)view;

/**
 GIF状态HUD

 @param images GIF图片数组
 @param view 显示的父视图
 @param backgroundColor 背景色
 @return HUD对象
 */
+ (instancetype)xh_showGifHudWithImages:(NSArray *)images toView:(UIView *)view backgroundColor:(UIColor *)backgroundColor;

@end

