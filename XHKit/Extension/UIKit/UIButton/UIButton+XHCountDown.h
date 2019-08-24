//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XHCountDown)


/**
 倒计时

 @param timeout 过期时间
 @param tittle 默认标题
 @param waitTittle 倒计时标题
 */
- (void)xh_startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;

@end
