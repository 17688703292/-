//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XHConstructor)

@property (nonatomic, assign) CGFloat cornerRadius;

#pragma mark - 初始化
+ (instancetype)buttonWithFrame:(CGRect)frame
                         inView:(UIView *)view;

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                           font:(UIFont *)font
                     titleColor:(UIColor *)titleColor
                         inView:(UIView *)view;

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                           font:(UIFont *)font
               titleNormalColor:(UIColor *)titleNormalColor
               titleSelectColor:(UIColor *)titleSelectColor
                         inView:(UIView *)view;

+ (instancetype)buttonWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                         inView:(UIView *)view;

+ (instancetype)buttonWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
              selectedImageName:(NSString *)selectedImageName
                         inView:(UIView *)view;

+ (NSAttributedString *)changestringArray:(NSArray *)strArray
                               colorArray:(NSArray *)colorArray
                                fontArray:(NSArray *)fontArray;
@end
