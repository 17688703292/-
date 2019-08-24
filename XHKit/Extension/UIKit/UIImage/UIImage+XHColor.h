//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (XHColor)
/**
 *  创建只有一个像素点的透明图片
 *
 *  @return 透明图片的Image对象
 */
+ (instancetype)xh_transparentImage;

/**
 *  创建指定大小的透明图片
 *
 *  @param size 透明图片的尺寸
 *
 *  @return 透明图片的Image对象
 */
+ (instancetype)xh_transparentImageWithSize:(CGSize)size;

/**
 获取纯色图片
 
 @param color 颜色
 @param size 大小
 @return 纯色图片
 */
+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 获取1像素纯色图片
 
 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)xh_imageWithColor:(UIColor *)color;

/**
 获得圆形图片
 
 @param name 图片名称
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 圆形图片
 */
+ (instancetype)xh_circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

