//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XHConstructor)

#pragma mark - 初始化
+ (instancetype)labelWithFrame:(CGRect)frame
                          font:(UIFont *)font
                        inView:(UIView *)view;

+ (instancetype)labelWithFrame:(CGRect)frame
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                        inView:(UIView *)view;

+ (instancetype)labelWithFrame:(CGRect)frame
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                 textAlignment:(NSTextAlignment)textAlignment
                        inView:(UIView *)view;

+ (instancetype)labelWithFrame:(CGRect)frame
                         title:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                        inView:(UIView *)view;

+ (instancetype)labelWithFrame:(CGRect)frame
                         title:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                 textAlignment:(NSTextAlignment)textAlignment
                        inView:(UIView *)view;

+ (instancetype)labelWithFont:(UIFont *)font
                       inView:(UIView *)view;

+ (instancetype)labelWithTextColor:(UIColor *)textColor
                              font:(UIFont *)font
                            inView:(UIView *)view;

+ (instancetype)labelWithTextColor:(UIColor *)textColor
                              font:(UIFont *)font
                     textAlignment:(NSTextAlignment)textAlignment
                            inView:(UIView *)view;

+ (instancetype)labelWithTitle:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                        inView:(UIView *)view;

+ (instancetype)labelWithTitle:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                 textAlignment:(NSTextAlignment)textAlignment
                        inView:(UIView *)view;

@end
