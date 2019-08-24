//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "NSString+XHOthers.h"
//#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation NSString (XHOthers)
// 银行卡数值显示
+ (NSString *)xh_stringWithBankCardNumber:(NSString *)number withReplaceString:(NSString *)replaceString {
    NSString *replace = replaceString ? replaceString : @"X";
    NSMutableString *newNumber = [NSMutableString string];
    for (int i = 1; i <= number.length; i ++) {
        if (i < number.length-3) {
            [newNumber appendString:replace];
            if (i % 4 == 0) {
                [newNumber appendFormat:@" "];
            }
        }
        else {
            [newNumber appendFormat:@"%c", [number characterAtIndex:i-1]];
        }
    }
    return newNumber;
}

// 显示手机号
+ (NSString *)xh_stringWithPhoneNumber:(NSString *)phone {
    if (phone.length != 11) {
        return nil;
    }
    NSString *newPhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
    return newPhone;
}

// 获取当前WIFI的SSID
+ (NSString *)xh_currentSSID {
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}

@end
