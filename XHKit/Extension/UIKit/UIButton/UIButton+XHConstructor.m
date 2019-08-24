//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import "UIButton+XHConstructor.h"

NSString const *UIButtonCornerRadiusKey = @"UIButtonCornerRadiusKey";

@implementation UIButton (XHConstructor)

+ (instancetype)buttonWithFrame:(CGRect)frame
                         inView:(UIView *)view {
    UIButton *button = [[self alloc]initWithFrame:frame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:button];
    return button;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                           font:(UIFont *)font
                     titleColor:(UIColor *)titleColor
                         inView:(UIView *)view {
    UIButton *button = [[self alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [view addSubview:button];
    return button;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                           font:(UIFont *)font
               titleNormalColor:(UIColor *)titleNormalColor
               titleSelectColor:(UIColor *)titleSelectColor
                         inView:(UIView *)view {
    UIButton *button = [[self alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:titleNormalColor forState:UIControlStateNormal];
    [button setTitleColor:titleSelectColor forState:UIControlStateSelected];
    [view addSubview:button];
    return button;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                         inView:(UIView *)view {
    UIButton *button = [[self alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [view addSubview:button];
    return button;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
              selectedImageName:(NSString *)selectedImageName
                         inView:(UIView *)view {
    UIButton *button = [[self alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [view addSubview:button];
    return button;
}



- (CGFloat)getCornerRadius:(CGFloat )cornerRadius {
    NSNumber *number = objc_getAssociatedObject(self, &UIButtonCornerRadiusKey);
    return number.floatValue;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    NSNumber *number = [NSNumber numberWithBool:cornerRadius];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = true;
    objc_setAssociatedObject(self, &UIButtonCornerRadiusKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (NSAttributedString *)changestringArray:(NSArray *)strArray
                               colorArray:(NSArray *)colorArray
                                fontArray:(NSArray *)fontArray {
    
    NSMutableString *mustr = [NSMutableString string];
    for (NSString *str in strArray) {
        
        [mustr appendString:str];
    }
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc]initWithString:mustr];
    
    for (int i=0; i<strArray.count; i++) {
        
        if (colorArray.count >= i+1) {
            [mutAttStr addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:[mustr rangeOfString:strArray[i]]];
        }
        
        if (fontArray.count >= i+1) {
            [mutAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[fontArray[i] floatValue]] range:[mustr rangeOfString:strArray[i]]];
            
        }
    }
    
    return mutAttStr;
    
}

@end
