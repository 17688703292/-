//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UILabel+XHConstructor.h"

@implementation UILabel (XHConstructor)

+ (instancetype)labelWithFrame:(CGRect)frame
                          font:(UIFont *)font
                        inView:(UIView *)view {
    UILabel *label = [[self alloc]initWithFrame:frame];
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.9;
    [view addSubview:label];
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                        inView:(UIView *)view {
    UILabel *label = [self labelWithFrame:frame font:font inView:view];
    label.textColor = textColor;
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                 textAlignment:(NSTextAlignment)textAlignment
                        inView:(UIView *)view {
    UILabel *label =  [self labelWithFrame:frame textColor:textColor font:font inView:view];
    label.textAlignment = textAlignment;
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame
                         title:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                        inView:(UIView *)view {
    UILabel *label = [self labelWithFrame:frame textColor:textColor font:font inView:view];
    label.text = title;
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame
                         title:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                 textAlignment:(NSTextAlignment)textAlignment
                        inView:(UIView *)view {
    UILabel *label = [self labelWithFrame:frame textColor:textColor font:font textAlignment:textAlignment inView:view];
    label.text = title;
    return label;
}

+ (instancetype)labelWithFont:(UIFont *)font
                       inView:(UIView *)view {
    UILabel *label = [[self alloc]init];
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.9;
    [view addSubview:label];
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor
                              font:(UIFont *)font
                            inView:(UIView *)view {
    UILabel *label = [self labelWithFont:font inView:view];
    label.textColor = textColor;
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor
                              font:(UIFont *)font
                     textAlignment:(NSTextAlignment)textAlignment
                            inView:(UIView *)view {
    UILabel *label =  [self labelWithTextColor:textColor font:font inView:view];
    label.textAlignment = textAlignment;
    return label;
}

+ (instancetype)labelWithTitle:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                        inView:(UIView *)view {
    UILabel *label = [self labelWithTextColor:textColor font:font inView:view];
    label.text = title;
    return label;
}

+ (instancetype)labelWithTitle:(NSString *)title
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font
                 textAlignment:(NSTextAlignment)textAlignment
                        inView:(UIView *)view {
    UILabel *label = [self labelWithTextColor:textColor font:font textAlignment:textAlignment inView:view];
    label.text = title;
    return label;
}

@end
