//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UIButton+XHSubmit.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *xh_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *xh_spinnerView;
@property(nonatomic, strong) UILabel *xh_spinnerTitleLabel;

@end

@implementation UIButton (XHSubmit)

- (void)xh_beginSubmitting:(NSString *)title {
    [self xh_endSubmitting];
    
    self.xh_submitting = @YES;
    self.hidden = YES;
    
    self.xh_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.xh_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.xh_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.xh_modalView.layer.borderWidth = self.layer.borderWidth;
    self.xh_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.xh_modalView.bounds;
    self.xh_spinnerView = [[UIActivityIndicatorView alloc]
                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.xh_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.xh_spinnerView.bounds;
    self.xh_spinnerView.frame = CGRectMake(
                                           15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                           spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.xh_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.xh_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.xh_spinnerTitleLabel.text = title;
    self.xh_spinnerTitleLabel.font = self.titleLabel.font;
    self.xh_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.xh_modalView addSubview:self.xh_spinnerView];
    [self.xh_modalView addSubview:self.xh_spinnerTitleLabel];
    [self.superview addSubview:self.xh_modalView];
    [self.xh_spinnerView startAnimating];
}

- (void)xh_endSubmitting {
    if (!self.isXHSubmitting.boolValue) {
        return;
    }
    
    self.xh_submitting = @NO;
    self.hidden = NO;
    
    [self.xh_modalView removeFromSuperview];
    self.xh_modalView = nil;
    self.xh_spinnerView = nil;
    self.xh_spinnerTitleLabel = nil;
}

- (NSNumber *)isXHSubmitting {
    return objc_getAssociatedObject(self, @selector(setXh_submitting:));
}

- (void)setXh_submitting:(NSNumber *)xh_submitting {
    objc_setAssociatedObject(self, @selector(setXh_submitting:), xh_submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)xh_spinnerView {
    return objc_getAssociatedObject(self, @selector(setxh_spinnerView:));
}

- (void)setxh_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setxh_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)xh_modalView {
    return objc_getAssociatedObject(self, @selector(setxh_modalView:));
    
}

- (void)setxh_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setxh_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)xh_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setxh_spinnerTitleLabel:));
}

- (void)setxh_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setxh_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
