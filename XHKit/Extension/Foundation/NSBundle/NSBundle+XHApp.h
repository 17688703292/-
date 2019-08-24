//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (XHApp)

/**
 获取App图标路径
 @return 路径
 */
- (NSString*)xh_appIconPath;

/**
 获取App图标
 @return 图标
 */
- (UIImage *)xh_appIcon;

/**
 获取App版本
 @return 版本
 */
- (NSString *)xh_appVersion;

/**
 获取App名字
 @return 名字
 */
- (NSString *)xh_appName;

@end
