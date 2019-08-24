//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XHBadge)

@property (strong, nonatomic) UILabel *xh_badge; ///< 角标文本

@property (nonatomic) NSString *xh_badgeValue; ///< 角标值

@property (nonatomic) UIColor *xh_badgeBGColor; ///< 背景色

@property (nonatomic) UIColor *xh_badgeTextColor; ///< 文字颜色

@property (nonatomic) UIFont *xh_badgeFont; ///< 文字字体

@property (nonatomic) CGFloat xh_badgePadding; ///< 间距

@property (nonatomic) CGFloat xh_badgeMinSize; ///< 最小宽度

@property (nonatomic) CGFloat xh_badgeOriginX; ///< x
@property (nonatomic) CGFloat xh_badgeOriginY; ///< y

@property BOOL xh_shouldHideBadgeAtZero; ///< 当0时是否隐藏

@property BOOL xh_shouldAnimateBadge; ///< 是否显示动画

@end
