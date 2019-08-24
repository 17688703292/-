//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (XHConstructor)

/**    上 */
@property (nonatomic, assign) CGFloat y;
/**    左 */
@property (nonatomic, assign) CGFloat x;
/**    下 */
@property (nonatomic, assign) CGFloat bottom;
/**    右 */
@property (nonatomic, assign) CGFloat right;
/**    宽 */
@property (nonatomic, assign) CGFloat width;
/**    高 */
@property (nonatomic, assign) CGFloat height;
/**    中心x */
@property (nonatomic, assign) CGFloat center_x;
/**    中心y */
@property (nonatomic, assign) CGFloat center_y;
/**    尺寸 */
@property (nonatomic, assign) CGSize size;
/**    坐标 */
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat cornerRadius; ///< 圆角


#pragma mark - 实用扩展
/**
 *  删除所有子控件
 */
- (void)removeAllSubviews;

/**
 *  创建view
 *
 *  @param frame           frame
 *  @param backgroundColor 背景颜色
 *  @param view            父视图
 *
 *  @return instancetype
 */
+ (instancetype)viewWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                       inView:(UIView *)view;

/**
 *  创建view的image
 *
 *  @return image
 */
- (UIImage *)makeImage;

/**
 *  创建消息数量的红点，18*18
 *
 *  @param badgeValue 消息数量
 *  @param center     红点基于self.bounds的center
 *
 *  @return badgeLabel
 */
- (UILabel *)setBadgeValue:(NSString *)badgeValue center:(CGPoint)center;

@end
