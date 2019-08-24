//
//  UIImageView+XHConstructor.m
//  XHKitDemo
//
//  Created by zhu on 2018/11/15.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "UIImageView+XHConstructor.h"

@implementation UIImageView (XHConstructor)

+ (instancetype)imageViewWithFrame:(CGRect)frame
                            inView:(UIView *)view {
    UIImageView *imageView = [[self alloc]initWithFrame:frame];
    [view addSubview:imageView];
    return imageView;
}

+ (instancetype)imageViewWithFrame:(CGRect)frame
                         imageName:(NSString *)imageName
                            inView:(UIView *)view {
    UIImageView *imageView = [[self alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    return imageView;
}

+ (instancetype)imageViewWithFrame:(CGRect)frame
                         imageName:(NSString *)imageName
                      cornerRadius:(CGFloat)cornerRadius
                            inView:(UIView *)view {
    UIImageView *imageView = [[self alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.layer.cornerRadius = cornerRadius;
    imageView.clipsToBounds = YES;
    [view addSubview:imageView];
    return imageView;
}

@end
