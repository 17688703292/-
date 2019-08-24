//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (XHBlock)

/**
 确定 提醒框
 
 */
+ (UIAlertController *)xh_AlertWithTitle:(NSString *)title message:(NSString *)message doneCompletionOneBtn:(void(^)(void))completion;

/**
 取消 确定 提醒框
 
 @param title 提醒框标题
 @param message 提醒框内容
 @param completion 确定block
 */
+ (UIAlertController *)xh_AlertWithTitle:(NSString *)title message:(NSString *)message doneCompletion:(void(^)(void))completion;

/**
 提醒框 多按钮
 
 @param title 提醒框标题
 @param message 提醒框内容
 @param titles 按钮标题
 @param callback 回调
 @return 返回提醒框
 */
+ (UIAlertController *)xh_AlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSArray *)titles clickCallback:(void(^)(NSInteger index))callback;

@end
