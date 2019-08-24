//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UITextView+XHBlock.h"
#import <objc/runtime.h>

@implementation UITextView (XHBlock)

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, _cmd, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self configurePlaceholder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurePlaceholder) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurePlaceholder) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurePlaceholder) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, @selector(setPlaceholder:));
}

- (void)configurePlaceholder{
    UILabel *placeholderLab;
    if (!objc_getAssociatedObject(self, _cmd)) {
        CGRect rect = [self.placeholder boundingRectWithSize:CGSizeMake(self.bounds.size.width - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
        placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(5, self.font.pointSize/2, rect.size.width, rect.size.height)];
        placeholderLab.font = self.font;
        placeholderLab.numberOfLines = 0;
        placeholderLab.textColor = [UIColor colorWithRed:0xd7/255.f green:0xd7/255.f blue:0xd7/255.f alpha:1];
        [self addSubview:placeholderLab];
        objc_setAssociatedObject(self, _cmd, placeholderLab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        placeholderLab = objc_getAssociatedObject(self, _cmd);
    }
    if (self.text.length == 0) {
        placeholderLab.text = self.placeholder;
    } else {
        placeholderLab.text = nil;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
}

#define BIND_BLOCK \
self.delegate = self; \
objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

#pragma mark - UITextViewDelegate to block
- (void)xh_shouldBeginEditing:(BOOL (^)(UITextView *textView))block {
    BIND_BLOCK
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    BOOL (^block)(UITextView *textView) = objc_getAssociatedObject(self, @selector(xh_shouldBeginEditing:));
    if (block) {
        return block(textView);
    } else {
        return YES;
    }
}

- (void)xh_shouldEndEditing:(BOOL (^)(UITextView *textView))block {
    BIND_BLOCK
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    BOOL (^block)(UITextView *textView) = objc_getAssociatedObject(self, @selector(xh_shouldEndEditing:));
    if (block) {
        return block(textView);
    } else {
        return YES;
    }
}

- (void)xh_didBeginEditing:(void (^)(UITextView *textView))block {
    BIND_BLOCK
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    void (^block)(UITextView *textView) = objc_getAssociatedObject(self, @selector(xh_didBeginEditing:));
    if (block) {
        block(textView);
    }
}

- (void)xh_didEndEditing:(void (^)(UITextView *textView))block {
    BIND_BLOCK
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    void (^block)(UITextView *textView) = objc_getAssociatedObject(self, @selector(xh_didEndEditing:));
    if (block) {
        block(textView);
    }
}

- (void)xh_shouldChangeText:(BOOL (^)(UITextView *textView, NSRange range, NSString *text))block {
    BIND_BLOCK
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL (^block)(UITextView *textView, NSRange range, NSString *text) = objc_getAssociatedObject(self, @selector(xh_shouldChangeText:));
    if (block) {
        return block(textView, range, text);
    } else {
        return YES;
    }
}

- (void)xh_didChange:(void (^)(UITextView *textView))block {
    BIND_BLOCK
}
- (void)textViewDidChange:(UITextView *)textView {
    void (^block)(UITextView *textView) = objc_getAssociatedObject(self, @selector(xh_didChange:));
    if (block) {
        block(textView);
    }
}

- (void)xh_didChangeSelection:(void (^)(UITextView *textView))block {
    BIND_BLOCK
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    void (^block)(UITextView *textView) = objc_getAssociatedObject(self, @selector(xh_didChangeSelection:));
    if (block) {
        block(textView);
    }
}

- (void)xh_shouldInteractWithURLInRange:(BOOL (^)(UITextView *textView, NSURL *URL, NSRange characterRange))block NS_AVAILABLE_IOS(7_0) {
    BIND_BLOCK
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    BOOL (^block)(UITextView *textView, NSURL *URL, NSRange characterRange) = objc_getAssociatedObject(self, @selector(xh_shouldInteractWithURLInRange:));
    if (block) {
        return block(textView, URL, characterRange);
    } else {
        return YES;
    }
}

- (void)xh_shouldInteractWithTextAttachmentInRange:(BOOL (^)(UITextView *textView, NSTextAttachment *textAttachment, NSRange characterRange))block NS_AVAILABLE_IOS(7_0) {
    BIND_BLOCK
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    BOOL (^block)(UITextView *textView, NSTextAttachment *textAttachment, NSRange characterRange) = objc_getAssociatedObject(self, @selector(xh_shouldInteractWithTextAttachmentInRange:));
    if (block) {
        return block(textView, textAttachment, characterRange);
    } else {
        return YES;
    }
}

@end
