//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XHConstructor)

#pragma mark - 初始化
+ (instancetype)imageViewWithFrame:(CGRect)frame
                            inView:(UIView *)view;

+ (instancetype)imageViewWithFrame:(CGRect)frame
                         imageName:(NSString *)imageName
                            inView:(UIView *)view;

+ (instancetype)imageViewWithFrame:(CGRect)frame
                         imageName:(NSString *)imageName
                      cornerRadius:(CGFloat)cornerRadius
                            inView:(UIView *)view;

@end
