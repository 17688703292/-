//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIControl (XHBlock)

/**
 *  点击事件
 *
 *  @param eventBlock 点击回调block
 */

- (void)xh_touchDown:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchDownRepeat:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchDragInside:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchDragOutside:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchDragEnter:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchDragExit:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchUpInside:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchUpOutside:(void (^)(UIControl *sender))eventBlock;
- (void)xh_touchCancel:(void (^)(UIControl *sender))eventBlock;
- (void)xh_valueChanged:(void (^)(UIControl *sender))eventBlock;
- (void)xh_primaryActionTriggered:(void (^)(UIControl *sender))eventBlock;
- (void)xh_editingDidBegin:(void (^)(UIControl *sender))eventBlock;
- (void)xh_editingChanged:(void (^)(UIControl *sender))eventBlock;
- (void)xh_editingDidEnd:(void (^)(UIControl *sender))eventBlock;
- (void)xh_editingDidEndOnExit:(void (^)(UIControl *sender))eventBlock;

@end
