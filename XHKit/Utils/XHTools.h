//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface XHTools : NSObject

#pragma mark - Validate
/** 表情符号的判断 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/** 是否九宫格键盘 */
+ (BOOL)isNineKeyBoard:(NSString *)string;

/** 邮箱验证 */
+ (BOOL)validateEmail:(NSString *)email;

/** 手机号码验证 */
+ (BOOL)validateMobile:(NSString *)mobile;

/** 判断密码 */
+(BOOL)judgePassWordLegal:(NSString *)pass;

/** 判断密码 */
+ (int)checkIsHaveNumAndLetter:(NSString*)password;

#pragma mark - App
/** 获取Window当前显示的ViewController */
+ (UIViewController *)currentViewController;

#pragma mark - SafeArea
+ (UIEdgeInsets)safeAreaInsetsInView:(UIView *)view;

#pragma mark - Json
/**
 字典转json字符串

 @param dict 转的字典
 @return json字符串
 */
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict;

/**
 json字符串转字典

 @param jsonString json字符串
 @return 字典
 */
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;

#pragma mark - Other

/**
 清除缓存
 */
+ (void)clearMovieFromDoucments;


/**
 毫秒转年月日
 */

+ (NSString *)ConvertStrToTimeNoday:(NSString *)timeStr;

+ (NSString *)ConvertStrToTime:(NSString *)timeStr;


+ (NSString *)ConvertStrToTime_receicve:(NSString *)timeStr;

+ (NSDate *)ConvertStrToTimeDate:(NSString *)timeStr;

/**
 
 获取当前时间
 */

+(NSString *)getNowTimeTimestamp;
+(NSString *)getNowTimeTimestamp_HaoMiao;

/**
 某个时间和当前时间差值
 */


+ (NSInteger)dateRemaining:(NSString *)Date;

/**
   时间转时间戳
 */
+(NSInteger )nsstringConversionNSDate:(NSString *)dateStr;


+(NSInteger )nsstringConversionNSDatehhmmss:(NSString *)dateStr;

/**
 
 * @method
 
 *
 
 * @brief 获取两个日期之间的天数
 
 * @param fromStr(时间戳)      起始日期
 
 * @param toStr (时间戳)       终止日期
 
 * @return    总天数
 
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSString *)fromStr toDate:(NSString *)toStr;
/**
 图片压缩  maxLength图片最大容量
 */
+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
@end
