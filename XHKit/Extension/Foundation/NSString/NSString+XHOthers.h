//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XHOthers)

/**
 * 银行卡数值显示
 * @param number 卡号
 * @param replaceString 替换文字
 * @return 隐藏后的卡号
 */
+ (NSString *)xh_stringWithBankCardNumber:(NSString *)number withReplaceString:(NSString *)replaceString;

/**
 * 显示手机号
 * @param phone 手机号的显示样式文字 index 3-7 用*代替
 */
+ (NSString *)xh_stringWithPhoneNumber:(NSString *)phone;

/**
 * 获取当前连接WiFi的SSID
 */
+ (NSString *)xh_currentSSID;

@end

NS_ASSUME_NONNULL_END
