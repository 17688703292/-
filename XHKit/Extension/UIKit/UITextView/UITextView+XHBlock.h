//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (XHBlock) <UITextViewDelegate>

/**
 *  底部提示文字,在此之前请先设置textView的font
 */
@property (nonatomic, copy) NSString *placeholder;

#pragma mark - UITextViewDelegate to block
- (void)xh_shouldBeginEditing:(BOOL (^)(UITextView *textView))block;
- (void)xh_shouldEndEditing:(BOOL (^)(UITextView *textView))block;
- (void)xh_didBeginEditing:(void (^)(UITextView *textView))block;
- (void)xh_didEndEditing:(void (^)(UITextView *textView))block;
- (void)xh_shouldChangeText:(BOOL (^)(UITextView *textView, NSRange range, NSString *text))block;
- (void)xh_didChange:(void (^)(UITextView *textView))block;
- (void)xh_didChangeSelection:(void (^)(UITextView *textView))block;
- (void)xh_shouldInteractWithURLInRange:(BOOL (^)(UITextView *textView, NSURL *URL, NSRange characterRange))block NS_AVAILABLE_IOS(7_0);
- (void)xh_shouldInteractWithTextAttachmentInRange:(BOOL (^)(UITextView *textView, NSTextAttachment *textAttachment, NSRange characterRange))block NS_AVAILABLE_IOS(7_0);

@end
