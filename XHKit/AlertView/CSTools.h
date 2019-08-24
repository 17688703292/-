//
//  CSTools.h
//  GuTangFinance
//
//  Created by 朱学鸿 on 2018/3/24.
//  Copyright © 2018年 com.carson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTools : NSObject

/** 表情符号的判断 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/** 是否九宫格键盘 */
+ (BOOL)isNineKeyBoard:(NSString *)string;

/** 邮箱验证 */
+ (BOOL)validateEmail:(NSString *)email;

/** 手机号码验证 */
+ (BOOL)validateMobile:(NSString *)mobile;

/** 判断密码 */
+(BOOL)judgePassWordLegal:(NSString *)pass;

/** 判断密码 */
+ (int)checkIsHaveNumAndLetter:(NSString*)password;

/** 获取Window当前显示的ViewController */
+ (UIViewController *)currentViewController;

/** 制作二维码 */

// 生成二维码
+ (UIImage *)creatQRcodeWithInfo:(NSString *)path withSize:(CGSize)imageSize;

/**
 显示Hud
 @param view 显示的父视图
 */
+ (void)showHudToView:(UIView *)view;

+ (void)hideHudToView:(UIView *)view;

/**
 显示Hud
 
 @param message 显示的文字
 @param view 显示的父视图
 */
+ (void)showHudWithMessage:(NSString *)message toView:(UIView *)view;


/**
 显示HUD1.5秒自动消失
 
 @param message 显示的文字
 @param view 显示的父视图
 */
+ (void)showhudAutoHideWithMessage:(NSString *)message toView:(UIView *)view completion:(void(^)(void))completion;


/**
 成功HUD 带成功图片 1.5秒消失
 
 @param message 提示文字
 @param view 父视图
 @param completion 消失后回调
 */
+ (void)showScucessAutoHideWithMessage:(NSString *)message toView:(UIView *)view completion:(void(^)(void))completion;


/**
 错误HUD 带错误图标 1.5秒消失
 
 @param message 提示文字
 @param view 父视图
 @param completion 消失后回调
 */
+ (void)showErrorAutoHideWithMessage:(NSString *)message toView:(UIView *)view completion:(void(^)(void))completion;


/**
 带图片的HUD 1.5秒后消失
 
 @param imgName 图片
 @param message 提示文字
 @param view 父视图
 @param completion 消失后回调
 */
+ (void)showHudAutoHideWithImageName:(NSString *)imgName message:(NSString *)message toView:(UIView *)view completion:(void(^)(void))completion;


/**
 取消 确定 提醒框
 
 @param title 提醒框标题
 @param message 提醒框内容
 @param completion 确定block
 */
+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message doneCompletion:(void(^)(void))completion;


/**
 确定 提醒框
 
 @param title 提醒框标题
 @param message 提醒框内容
 */
+ (UIAlertController *)showAlertOneButtonWithTitle:(NSString *)title message:(NSString *)message doneCompletion:(void(^)(void))completion;


+ (void)validateResponse:(id)response error:(NSError *)error toView:(UIView *)view sucess:(void(^)(void))completion;

+ (void)validateDict:(NSDictionary *)dict toView:(UIView *)view sucess:(void(^)(void))completion;

+ (void)showRequestErrorToView:(UIView *)view;

+ (NSString *)showBackCardNumer:(NSString *)number;

/**
 显示手机号，
 
 @param phone 手机号的显示样式文字 index 3-7 用*代替
 */
+ (NSString *)showPhone:(NSString *)phone;

/**
 
 
 */
+(NSString *)convertToJsonData:(NSMutableDictionary *)dict;
@end
