//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import "UIControl+XHBlock.h"
#import <objc/runtime.h>
@implementation UIControl (XHBlock)

#define UIBUTTON_EVENT(methodName, eventName)                      \
-(void)methodName : (void (^)(UIControl *sender))eventBlock {                     \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);                                  \
[self addTarget:self                                                    \
action:@selector(methodName##Action:)                                    \
forControlEvents:UIControlEvent##eventName];                            \
}                                                                        \
-(void)methodName##Action:(UIControl *)sender {                                    \
void (^block)(UIControl *sender) = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block(sender);                                                                      \
}                                                                              \
}


UIBUTTON_EVENT(xh_touchDown, TouchDown)
UIBUTTON_EVENT(xh_touchDownRepeat, TouchDownRepeat)
UIBUTTON_EVENT(xh_touchDragInside, TouchDragInside)
UIBUTTON_EVENT(xh_touchDragOutside, TouchDragOutside)
UIBUTTON_EVENT(xh_touchDragEnter, TouchDragEnter)
UIBUTTON_EVENT(xh_touchDragExit, TouchDragExit)
UIBUTTON_EVENT(xh_touchUpInside, TouchUpInside)
UIBUTTON_EVENT(xh_touchUpOutside, TouchUpOutside)
UIBUTTON_EVENT(xh_touchCancel, TouchCancel)
UIBUTTON_EVENT(xh_valueChanged, ValueChanged)
UIBUTTON_EVENT(xh_primaryActionTriggered, PrimaryActionTriggered)
UIBUTTON_EVENT(xh_editingDidBegin, EditingDidBegin)
UIBUTTON_EVENT(xh_editingChanged, EditingChanged)
UIBUTTON_EVENT(xh_editingDidEnd, EditingDidEnd)
UIBUTTON_EVENT(xh_editingDidEndOnExit, EditingDidEndOnExit)

@end
