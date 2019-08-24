//
//  AutoScrollLabel.h
//  Slumbers
//
//  Created by RedSky on 2019/4/13.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoScrollLabel : UIScrollView



/// 每秒移动多少像素
@property(nonatomic) float scrollSpeed;
/// 滚动到结束时,暂停多长时间
@property(nonatomic) NSTimeInterval pauseInterval;
@property (nonatomic,strong) UILabel * textLabel ;
/// 设置完textLabel.text调用
- (void)startScrollIfNeed ;


@end

NS_ASSUME_NONNULL_END
