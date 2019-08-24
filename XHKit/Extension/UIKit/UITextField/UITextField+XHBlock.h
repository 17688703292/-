//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XHBlock) <UITextFieldDelegate>

/**
 是否金额格式输入键盘
 */
@property (nonatomic, assign) BOOL isMoneyKeyboard;

+ (instancetype)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder;
+ (instancetype)textFieldWithTextColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder;

#pragma mark - UITextFieldDelegate to block
- (void)xh_shouldBeginEditing:(BOOL (^)(UITextField *textField))block;
- (void)xh_didBeginEditing:(void (^)(UITextField *textField))block;
- (void)xh_shouldEndEditing:(BOOL (^)(UITextField *textField))block;
- (void)xh_didEndEditing:(void (^)(UITextField *textField))block;
- (void)xh_shouldChange:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))block;
- (void)xh_shouldClear:(BOOL (^)(UITextField *textField))block;
- (void)xh_shouldReturn:(BOOL (^)(UITextField *textField))block;

@end
