//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import "UIView+XHGesture.h"
#import <objc/runtime.h>

@implementation UIView (XHGesture)

+ (instancetype)viewWithFrame:(CGRect)frame
                   eventBlock:(void (^)(NSInteger tag, id obj))eventBlock {
    UIView *v = [[self alloc] initWithFrame:frame];
    v.eventBlock = eventBlock;
    [v setupSubviews];
    return v;
}

- (void)setupSubviews {}

- (void)setEventBlock:(void (^)(NSInteger tag, id obj))eventBlock {
    objc_setAssociatedObject(self, _cmd, eventBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(NSInteger tag, id obj))eventBlock {
    return objc_getAssociatedObject(self, @selector(setEventBlock:));
}

#pragma mark - 手势相关

#define GestureRecognizerMethod(clsName,methodName) \
- (void)methodName:(void (^)(UI##clsName *gestureRecognizer))block {\
self.userInteractionEnabled = YES;\
objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
UI##clsName *gestureRecognizer = [[UI##clsName alloc]initWithTarget:self action:@selector(methodName##Action:)];\
[self addGestureRecognizer:gestureRecognizer];\
}\
- (void)methodName##Action:(UIGestureRecognizer *)gestureRecognizer {\
void (^block)(UIGestureRecognizer *gestureRecognizer) = objc_getAssociatedObject(self, @selector(methodName:));\
if (block) {\
block(gestureRecognizer);\
}\
}

GestureRecognizerMethod(TapGestureRecognizer, tapGestureRecognizer)
GestureRecognizerMethod(PanGestureRecognizer, panGestureRecognizer)
GestureRecognizerMethod(PinchGestureRecognizer, pinchGestureRecognizer)
GestureRecognizerMethod(RotationGestureRecognizer, rotationGestureRecognizer)
GestureRecognizerMethod(LongPressGestureRecognizer, longPressGestureRecognizer)

//扫手势
- (void)swipeGestureRecognizerDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer *gestureRecognizer))block {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizerDirectionAction:)];
    gestureRecognizer.direction = direction;
    [self addGestureRecognizer:gestureRecognizer];
}
- (void)swipeGestureRecognizerDirectionAction:(UISwipeGestureRecognizer *)gestureRecognizer {
    void (^block)(UISwipeGestureRecognizer *gestureRecognizer) = objc_getAssociatedObject(self, @selector(swipeGestureRecognizerDirection:block:));
    if (block) {
        block(gestureRecognizer);
    }
}

//双击手势
- (void)doubleClickTapGestureRecognizer:(void (^)(UITapGestureRecognizer *gestureRecognizer))block {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClickTapGestureRecognizerAction:)];
    gestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:gestureRecognizer];
}
- (void)doubleClickTapGestureRecognizerAction:(UITapGestureRecognizer *)gestureRecognizer {
    void (^block)(UIGestureRecognizer *gestureRecognizer) = objc_getAssociatedObject(self, @selector(doubleClickTapGestureRecognizer:));
    if (block) {
        block(gestureRecognizer);
    }
}

@end
