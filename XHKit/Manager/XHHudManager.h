//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface XHHudManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic, assign) MBProgressHUDBackgroundStyle backgroundStyle; ///< 背景样式
@property (nonatomic, assign) UIBlurEffectStyle backgroundBlurEffectStyle;  ///< 背景毛玻璃样式（设置后透明无效）
@property (nonatomic, strong) UIColor *backGroundColor;                     ///< 背景颜色

@property (nonatomic, assign) MBProgressHUDBackgroundStyle bezelStyle;      ///< 框样式
@property (nonatomic, assign) UIBlurEffectStyle bezelBlurEffectStyle;       ///< 框毛玻璃样式（设置后透明无效）
@property (nonatomic, strong) UIColor *bezelColor;                          ///< 框颜色

@property (nonatomic, strong) UIColor *progressColor;      ///< 进度条颜色
@property (nonatomic, assign) CGSize minSize;              ///< 最小尺寸
@property (nonatomic, assign) NSTimeInterval showInterval; ///< 显示多久隐藏
@property (nonatomic, strong) UIColor *textColor;          ///< 文字颜色
@property (nonatomic, strong) UIFont *font;                ///< 文字字体

@property (nonatomic, strong) NSArray *gifImages;          ///< gif图片数组
@property (nonatomic, strong) NSArray *gifImageNames;      ///< gif图片名数组
@property (nonatomic, assign) NSTimeInterval animationDuration; ///< gif循环时间

/** 回复默认值 */
- (void)defaultStyle;

@end

