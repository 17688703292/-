//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (XHGesture)

/** 点击事件 */
@property (nonatomic, strong) void (^eventBlock)(NSInteger tag, id obj);

/**
 *  初始化，会执行 preloadSubviews 方法
 *
 *  @param frame      frame
 *  @param eventBlock 回调block
 *
 *  @return instancetype
 */
+ (instancetype)viewWithFrame:(CGRect)frame
                   eventBlock:(void(^)(NSInteger tag, id obj))eventBlock;

/**
 *  预加载子控件，用于自定义view重写
 */
- (void)setupSubviews;

#pragma mark - 手势相关
/**
 *  单击手势
 *
 *  @param block 回调事件
 */
- (void)tapGestureRecognizer:(void (^)(UITapGestureRecognizer *gestureRecognizer))block;

/**
 *  拖手势
 *
 *  @param block 回调事件
 */
- (void)panGestureRecognizer:(void (^)(UIPanGestureRecognizer *gestureRecognizer))block;

/**
 *  捏手势
 *
 *  @param block 回调事件
 */
- (void)pinchGestureRecognizer:(void (^)(UIPinchGestureRecognizer *gestureRecognizer))block;

/**
 *  扫手势
 *
 *  @param block 回调事件
 */
- (void)swipeGestureRecognizerDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer *gestureRecognizer))block;

/**
 *  旋转手势
 *
 *  @param block 回调事件
 */
- (void)rotationGestureRecognizer:(void (^)(UIRotationGestureRecognizer *gestureRecognizer))block;

/**
 *  长按手势
 *
 *  @param block 回调事件
 */
- (void)longPressGestureRecognizer:(void (^)(UILongPressGestureRecognizer *gestureRecognizer))block;

/**
 *  双击手势
 *
 *  @param block 回调事件
 */
- (void)doubleClickTapGestureRecognizer:(void (^)(UITapGestureRecognizer *gestureRecognizer))block;

@end
