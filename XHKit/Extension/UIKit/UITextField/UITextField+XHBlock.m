//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UITextField+XHBlock.h"
#import <objc/runtime.h>

@implementation UITextField (XHBlock)

+ (instancetype)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder {
    UITextField *textField = [[self alloc]initWithFrame:frame];
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    return textField;
}

+ (instancetype)textFieldWithTextColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder {
    UITextField *textField = [[self alloc]init];
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    return textField;
}

- (void)setIsMoneyKeyboard:(BOOL)isMoneyKeyboard {
    if (isMoneyKeyboard) {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        self.delegate = self;
    }
    objc_setAssociatedObject(self, _cmd, @(isMoneyKeyboard), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isMoneyKeyboard {
    return [objc_getAssociatedObject(self, @selector(setIsMoneyKeyboard:)) boolValue];
}

//返回是否正确金额格式输入
- (BOOL)whetherAmountIsEnteredCorrectly:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([self.text isEqualToString:@"0"] && ![string isEqualToString:@"."]) {
        self.text = nil;
    }
    if ([string isEqualToString:@"."] && self.text.length == 0) {
        return NO;
    }
    if ([string isEqualToString:@"."] && [self.text containsString:@"."]) {
        return NO;
    }
    if (self.text.length > 3 && [[self.text substringWithRange:NSMakeRange(self.text.length-3, 1)] isEqualToString:@"."]) {
        return NO;
    }
    return YES;
}

#define BIND_BLOCK \
self.delegate = self; \
objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

#pragma mark - UITextFieldDelegate to block
- (void)xh_shouldBeginEditing:(BOOL (^)(UITextField *textField))block {
    BIND_BLOCK
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL (^block)(UITextField *textField) = objc_getAssociatedObject(self, @selector(xh_shouldBeginEditing:));
    if (block) {
        return block(textField);
    } else {
        return YES;
    }
}

- (void)xh_didBeginEditing:(void (^)(UITextField *textField))block {
    BIND_BLOCK
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    void (^block)(UITextField *textField) = objc_getAssociatedObject(self, @selector(xh_didBeginEditing:));
    if (block) {
        block(textField);
    }
}

- (void)xh_shouldEndEditing:(BOOL (^)(UITextField *textField))block {
    BIND_BLOCK
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL (^block)(UITextField *textField) = objc_getAssociatedObject(self, @selector(xh_shouldEndEditing:));
    if (block) {
        return block(textField);
    } else {
        return YES;
    }
}

- (void)xh_didEndEditing:(void (^)(UITextField *textField))block {
    BIND_BLOCK
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    void (^block)(UITextField *textField) = objc_getAssociatedObject(self, @selector(xh_didEndEditing:));
    if (block) {
        block(textField);
    }
}

- (void)xh_shouldChange:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))block {
    BIND_BLOCK
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL (^block)(UITextField *textField, NSRange range, NSString *string) = objc_getAssociatedObject(self, @selector(xh_shouldChange:));
    BOOL isCorrectInput = YES;
    if (self.isMoneyKeyboard) {
        //处理金额输入
        isCorrectInput = [self whetherAmountIsEnteredCorrectly:string];
    }
    if (block) {
        return block(textField, range, string) && isCorrectInput;
    } else {
        return YES && isCorrectInput;
    }
}

- (void)xh_shouldClear:(BOOL (^)(UITextField *textField))block {
    BIND_BLOCK
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    BOOL (^block)(UITextField *textField) = objc_getAssociatedObject(self, @selector(xh_shouldClear:));
    if (block) {
        return block(textField);
    } else {
        return YES;
    }
}

- (void)xh_shouldReturn:(BOOL (^)(UITextField *textField))block {
    BIND_BLOCK
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL (^block)(UITextField *textField) = objc_getAssociatedObject(self, @selector(xh_shouldReturn:));
    if (block) {
        return block(textField);
    } else {
        return YES;
    }
}

@end
