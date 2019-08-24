//
//  UIColor+XHHexColor.h
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XHHexColor)
/**
 16进制颜色
 @param hexString 16进制颜色
 @return 颜色对象
 */
+ (instancetype)colorWithHexString:(NSString *)hexString;
/**
 16进制颜色
 @param hexString 16进制颜色
 @param alpha 透明度
 @return 颜色对象
 */
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
