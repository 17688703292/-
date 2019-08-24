//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XHAnination)

#pragma mark - 动画相关
/**
 *  从某点弹出视图
 *
 *  @param p 点
 */
- (void)showAnimateFromPoint:(CGPoint)p;

/**
 *  从某点弹出视图
 *
 *  @param p          点
 *  @param completion 结束执行代码块
 */
- (void)showAnimateFromPoint:(CGPoint)p completion:(void (^)(BOOL finished))completion;

/**
 *  从某点隐藏隐藏
 *
 *  @param p 点
 */
- (void)hiddenAnimateToPoint:(CGPoint)p;

/**
 *  从某点隐藏隐藏
 *
 *  @param p 点
 *  @param completion 结束执行代码块
 */
- (void)hiddenAnimateToPoint:(CGPoint)p completion:(void (^)(BOOL finished))completion;

@end
