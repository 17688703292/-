//
//  XHConfig.m
//  XHKitDemo
//
//  Created by zhu on 2018/11/14.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XHConfig.h"
#import <UIKit/UIKit.h>

@implementation XHConfig

+ (NSDictionary *)getConfig {
    return @{
             XHBaseUrl:                         @"http://www.ydmall.xyz/xmall-manager-web/",
             XHBaseImageUrl:                    @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/shop/store/goods/",
             XHUploadUrl: @"http://www.ydmall.xyz/upload/uploadFile",
             XHBaseBackgroundColor:             [UIColor whiteColor],
             XHNavigationColor:                 kThemeColor,//[UIColor colorWithHexString:@"#70bd4b"],
             XHNavigationTitleColor:            [UIColor whiteColor],
             XHNavigationTitleFont:             [UIFont boldSystemFontOfSize:18],
             XHNavigationBackImage:             [UIImage imageNamed:@"jiantou_left"],
             XHResponseSuccessImage:            [UIImage imageNamed:@"xh_icon_alert_success"],
             XHResponseErrorImage:              [UIImage imageNamed:@"xh_icon_alert_error"],
             };
}

@end
