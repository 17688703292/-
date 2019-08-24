//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import "UIView+XHConstructor.h"
#import <objc/runtime.h>

NSString const *UIViewCornerRadiusKey = @"UIViewCornerRadiusKey";

@implementation UIView (XHConstructor)

@dynamic cornerRadius;

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x { return self.frame.origin.x; }

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y { return self.frame.origin.y; }

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)right { return self.frame.origin.x + self.frame.size.width; }

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom { return self.frame.origin.y + self.frame.size.height; }

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width { return self.frame.size.width; }

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height { return self.frame.size.height; }

- (void)setCenter_x:(CGFloat)center_x {
    CGPoint center = self.center;
    center.x = center_x;
    self.center = center;
}

- (CGFloat)center_x { return self.center.x; }

- (void)setCenter_y:(CGFloat)center_y {
    CGPoint center = self.center;
    center.y = center_y;
    self.center = center;
}

- (CGFloat)center_y { return self.center.y; }


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size { return self.frame.size; }

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin { return self.frame.origin; }

- (void)removeAllSubviews {
    while (self.subviews.count > 0) {
        UIView *subview = [self.subviews objectAtIndex:0];
        [subview removeFromSuperview];
    }
}

- (UIImage *)makeImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)viewWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                       inView:(UIView *)view {
    UIView *v = [[self alloc]initWithFrame:frame];
    v.backgroundColor = backgroundColor;
    [view addSubview:v];
    return v;
}

- (UILabel *)setBadgeValue:(NSString *)badgeValue center:(CGPoint)center {
    UILabel *badgeLabel = objc_getAssociatedObject(self, _cmd);
    if (!badgeLabel && CGRectContainsPoint(self.bounds, center)) {
        badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        badgeLabel.text = badgeValue;
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.font = [UIFont boldSystemFontOfSize:10];
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.center = center;
        badgeLabel.backgroundColor = [UIColor redColor];
        badgeLabel.layer.cornerRadius = 9;
        badgeLabel.clipsToBounds = YES;
        badgeLabel.adjustsFontSizeToFitWidth = YES;
        badgeLabel.minimumScaleFactor = 0.9;
        [self addSubview:badgeLabel];
    }
    if ([badgeValue integerValue]) {
        if ([badgeValue integerValue] > 99) {
            badgeLabel.text = @"99+";
        } else {
            badgeLabel.text = badgeValue;
        }
        badgeLabel.hidden = NO;
    } else {
        badgeLabel.hidden = YES;
    };
    objc_setAssociatedObject(self, _cmd, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return badgeLabel;
}

- (CGFloat)getCornerRadius:(CGFloat )cornerRadius {
    NSNumber *number = objc_getAssociatedObject(self, &UIViewCornerRadiusKey);
    return number.floatValue;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    NSNumber *number = [NSNumber numberWithBool:cornerRadius];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = true;
    objc_setAssociatedObject(self, &UIViewCornerRadiusKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
