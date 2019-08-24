//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UIButton+XHBadge.h"
#import <objc/runtime.h>

NSString const *xh_UIButton_badgeKey = @"xh_UIButton_badgeKey";
NSString const *xh_UIButton_badgeBGColorKey = @"xh_UIButton_badgeBGColorKey";
NSString const *xh_UIButton_badgeTextColorKey = @"xh_UIButton_badgeTextColorKey";
NSString const *xh_UIButton_badgeFontKey = @"xh_UIButton_badgeFontKey";
NSString const *xh_UIButton_badgePaddingKey = @"xh_UIButton_badgePaddingKey";
NSString const *xh_UIButton_badgeMinSizeKey = @"xh_UIButton_badgeMinSizeKey";
NSString const *xh_UIButton_badgeOriginXKey = @"xh_UIButton_badgeOriginXKey";
NSString const *xh_UIButton_badgeOriginYKey = @"xh_UIButton_badgeOriginYKey";
NSString const *xh_UIButton_shouldHideBadgeAtZeroKey = @"xh_UIButton_shouldHideBadgeAtZeroKey";
NSString const *xh_UIButton_shouldAnimateBadgeKey = @"xh_UIButton_shouldAnimateBadgeKey";
NSString const *xh_UIButton_badgeValueKey = @"xh_UIButton_badgeValueKey";

@implementation UIButton (XHBadge)

@dynamic xh_badgeValue, xh_badgeBGColor, xh_badgeTextColor, xh_badgeFont;
@dynamic xh_badgePadding, xh_badgeMinSize, xh_badgeOriginX, xh_badgeOriginY;
@dynamic xh_shouldHideBadgeAtZero, xh_shouldAnimateBadge;

- (void)xh_badgeInit
{
    // Default design initialization
    self.xh_badgeBGColor   = [UIColor redColor];
    self.xh_badgeTextColor = [UIColor whiteColor];
    self.xh_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.xh_badgePadding   = 6;
    self.xh_badgeMinSize   = 8;
    self.xh_badgeOriginX   = self.frame.size.width - self.xh_badge.frame.size.width/2;
    self.xh_badgeOriginY   = -4;
    self.xh_shouldHideBadgeAtZero = YES;
    self.xh_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)xh_refreshBadge
{
    // Change new attributes
    self.xh_badge.textColor        = self.xh_badgeTextColor;
    self.xh_badge.backgroundColor  = self.xh_badgeBGColor;
    self.xh_badge.font             = self.xh_badgeFont;
}

- (CGSize) xh_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self xh_duplicateLabel:self.xh_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)xh_updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self xh_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.xh_badgeMinSize) ? self.xh_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.xh_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.xh_badge.frame = CGRectMake(self.xh_badgeOriginX, self.xh_badgeOriginY, minWidth + padding, minHeight + padding);
    self.xh_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.xh_badge.layer.masksToBounds = YES;
}

// Handle the badge changing value
- (void)xh_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.xh_shouldAnimateBadge && ![self.xh_badge.text isEqualToString:self.xh_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.xh_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.xh_badge.text = self.xh_badgeValue;
    
    // Animate the size modification if needed
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self xh_updateBadgeFrame];
    }];
}

- (UILabel *)xh_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)xh_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.xh_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.xh_badge removeFromSuperview];
        self.xh_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)xh_badge {
    return objc_getAssociatedObject(self, &xh_UIButton_badgeKey);
}
-(void)setXh_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &xh_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)xh_badgeValue {
    return objc_getAssociatedObject(self, &xh_UIButton_badgeValueKey);
}
-(void)setXh_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &xh_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.xh_shouldHideBadgeAtZero)) {
        [self xh_removeBadge];
    } else if (!self.xh_badge) {
        // Create a new badge because not existing
        self.xh_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.xh_badgeOriginX, self.xh_badgeOriginY, 20, 20)];
        self.xh_badge.textColor            = self.xh_badgeTextColor;
        self.xh_badge.backgroundColor      = self.xh_badgeBGColor;
        self.xh_badge.font                 = self.xh_badgeFont;
        self.xh_badge.textAlignment        = NSTextAlignmentCenter;
        [self xh_badgeInit];
        [self addSubview:self.xh_badge];
        [self xh_updateBadgeValueAnimated:NO];
    } else {
        [self xh_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)xh_badgeBGColor {
    return objc_getAssociatedObject(self, &xh_UIButton_badgeBGColorKey);
}
-(void)setXh_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &xh_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_refreshBadge];
    }
}

// Badge text color
- (UIColor *)xh_badgeTextColor {
    return objc_getAssociatedObject(self, &xh_UIButton_badgeTextColorKey);
}
- (void)setXh_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &xh_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_refreshBadge];
    }
}

// Badge font
- (UIFont *)xh_badgeFont {
    return objc_getAssociatedObject(self, &xh_UIButton_badgeFontKey);
}
- (void)setXh_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &xh_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_refreshBadge];
    }
}

// Padding value for the badge
- (CGFloat)xh_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &xh_UIButton_badgePaddingKey);
    return number.floatValue;
}
- (void)setXh_badgePadding:(CGFloat)badgePadding {
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &xh_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_updateBadgeFrame];
    }
}

// Minimum size badge to small
- (CGFloat)xh_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &xh_UIButton_badgeMinSizeKey);
    return number.floatValue;
}

- (void)setXh_badgeMinSize:(CGFloat)badgeMinSize {
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &xh_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
- (CGFloat)xh_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &xh_UIButton_badgeOriginXKey);
    return number.floatValue;
}
- (void)setXh_badgeOriginX:(CGFloat)badgeOriginX {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &xh_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_updateBadgeFrame];
    }
}

- (CGFloat)xh_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &xh_UIButton_badgeOriginYKey);
    return number.floatValue;
}
- (void)setXh_badgeOriginY:(CGFloat)badgeOriginY {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &xh_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.xh_badge) {
        [self xh_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL)xh_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &xh_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setXh_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero {
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &xh_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
- (BOOL)xh_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &xh_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setXh_shouldAnimateBadge:(BOOL)shouldAnimateBadge {
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &xh_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
