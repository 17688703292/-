//
//  UIView+XHAnination.m
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UIView+XHAnination.h"

@implementation UIView (XHAnination)

#pragma mark - 动画相关
- (void)showAnimateFromPoint:(CGPoint)p {
    CGPoint center = self.center;
    self.hidden = NO;
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.center = p;
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
        self.alpha = 1.f;
        self.center = center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)hiddenAnimateToPoint:(CGPoint)p {
    CGPoint center = self.center;
    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
        self.center = p;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.center = center;
    }];
}

- (void)showAnimateFromPoint:(CGPoint)p completion:(void (^)(BOOL finished))completion {
    CGPoint center = self.center;
    self.hidden = NO;
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.center = p;
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
        self.alpha = 1.f;
        self.center = center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }];
}

- (void)hiddenAnimateToPoint:(CGPoint)p completion:(void (^)(BOOL finished))completion {
    CGPoint center = self.center;
    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
        self.center = p;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.center = center;
        if (completion) {
            completion(finished);
        }
    }];
}

@end
