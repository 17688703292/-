//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHTools.h"

#import <AVKit/AVKit.h>

@implementation XHTools
#pragma mark - Validate 验证
//表情符号的判断
+ (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

/*
 * 判断用户输入的密码是否符合规范，符合规范的密码要求：
*/
+(BOOL)judgePassWordLegal:(NSString *)pass {
    BOOL result = false;
    if ([pass length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"[A-Za-z]";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex =@"^1[3|4|5|6|7|8|9][0-9]{1}[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//当前时间的时间戳
+ (NSString *)cNowTimestamp{
    NSDate *newDate = [NSDate date];
    long int timeSp = (long)[newDate timeIntervalSince1970];
    NSString *tempTime = [NSString stringWithFormat:@"%ld",timeSp];
    return tempTime;
}

+ (int)checkIsHaveNumAndLetter:(NSString*)password {
    /*
     NSRegularExpressionCaseInsensitive          = 1 << 0,   // 不区分大小写的
     NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1,   // 忽略空格和# -
     NSRegularExpressionIgnoreMetacharacters      = 1 << 2,   // 整体化
     NSRegularExpressionDotMatchesLineSeparators      = 1 << 3,   // 匹配任何字符，包括行分隔符
     NSRegularExpressionAnchorsMatchLines          = 1 << 4,   // 允许^和$在匹配的开始和结束行
     NSRegularExpressionUseUnixLineSeparators      = 1 << 5,   // (查找范围为整个的话无效)
     NSRegularExpressionUseUnicodeWordBoundaries      = 1 << 6    // (查找范围为整个的话无效)
     */
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *sLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger sLetterMatchCount = [sLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    //空格条件
    NSRegularExpression *spaceRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\s" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    
    //符合空格条件的有几个字节
    NSUInteger spaceMatchCount = [spaceRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (password.length < 6) {
        return 0; // 密码长度不正确
    } else {
        if (tLetterMatchCount == 0 || sLetterMatchCount == 0) {
            return 1; // 没有大写或小写
        } else {
            if (tNumMatchCount == 0) {
                return 2; // 不包含数字
            } else {
                if (spaceMatchCount > 0) {
                    return 3; // 包含空格
                }
                else {
                    return 4; // 包含大写小写数字，不包含空格
                }
            }
        }
    }
}

//获取Window当前显示的ViewController
+ (UIViewController *)currentViewController {
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+ (UIEdgeInsets)safeAreaInsetsInView:(UIView *)view {
    if (@available(iOS 11, *)) {
        return view.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (void)clearMovieFromDoucments {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        if ([filename isEqualToString:@"tmp.PNG"]) {
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
            continue;
        }
        if ([[[filename pathExtension] lowercaseString] isEqualToString:@"mp4"]||
            [[[filename pathExtension] lowercaseString] isEqualToString:@"mov"]||
            [[[filename pathExtension] lowercaseString] isEqualToString:@"png"]||
            [[[filename pathExtension] lowercaseString] isEqualToString:@"jpeg"]||
            [[[filename pathExtension] lowercaseString] isEqualToString:@"jpg"]) {
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}


+ (NSString *)ConvertStrToTimeNoday:(NSString *)timeStr

{
    if (![timeStr isKindOfClass:[NSString class]] ||
        [timeStr isEqualToString:@"0"]) {
        return @"";
    }
    double unixTimeStamp = [timeStr doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *_date=[_formatter stringFromDate:date];
    return _date;
}

+ (NSString *)ConvertStrToTime:(NSString *)timeStr

{
    if (![timeStr isKindOfClass:[NSString class]]) {
        return @"";
    }
    double unixTimeStamp = [timeStr doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    return _date;
}


+ (NSDate *)ConvertStrToTimeDate:(NSString *)timeStr

{
    if (![timeStr isKindOfClass:[NSString class]]) {
        return @"";
    }
    double unixTimeStamp = [timeStr doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return date;
}

+ (NSString *)ConvertStrToTime_receicve:(NSString *)timeStr

{
    if (![timeStr isKindOfClass:[NSString class]]) {
        return @"";
    }
    long msec = [timeStr longLongValue];
    
    if (msec <= 0)
    {
        return @"";
    }
    
    NSInteger d = msec/60/60/24;
    NSInteger h = msec/60/60%24;
    NSInteger m = msec%3600/60;
    NSInteger s = msec%60;
    
    NSString *_tStr = @"";
    NSString *_dStr = @"";
    NSString *_hStr = @"";
    NSString *_mStr = @"";
    NSString *_sStr = @"";
    NSString *_hTimeType = @"defaultColor";
    
    if (d > 0)
    {
        _dStr = [NSString stringWithFormat:@"%ld天",d];
    }
    
    if (h > 0)
    {
        _hStr = [NSString stringWithFormat:@"%ld小时",h];
    }
    
    if (m > 0)
    {
        _mStr = [NSString stringWithFormat:@"%ld分",m];
    }
    
    if (s > 0)
    {
        _sStr = [NSString stringWithFormat:@"%ld秒",s];
    }
    
    //小于2小时 高亮显示
    if (h > 0 && h < 2)
    {
        _hTimeType = @"hightColor";
    }
    
    _tStr = [NSString stringWithFormat:@"剩下%@%@%@%@",_dStr,_hStr,_mStr,_sStr];
    
    return _tStr;
}





//计算日期
+(NSInteger)dateRemaining:(NSString *)Date_str{
    
    NSDateFormatter *dateFormatter_temp =[[NSDateFormatter alloc] init];
    [dateFormatter_temp setDateFormat:@"yyyy-MM-dd"];
    //传入日期设置日期格式
    NSString *yourDate_temp = [dateFormatter_temp stringFromDate:[NSDate date]];
    
    NSString *Date = [NSString stringWithFormat:@"%@ %@",yourDate_temp,Date_str];
    
    //日期格式设置,可以根据想要的数据进行修改 添加小时和分甚至秒
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //传入日期设置日期格式
    NSDate *yourDate = [dateFormatter dateFromString:Date];
    
    
    //得到时区，根据手机系统时区设置（systemTimeZone）
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    
    //获取当前日期
    NSDate *nowDate=[NSDate date];
    
    /*GMT：格林威治标准时间*/
    //格林威治标准时间与系统时区之间的偏移量（秒）
    NSInteger nowInterval=[zone secondsFromGMTForDate:nowDate];
    
    //将偏移量加到当前日期
    NSDate *nowTime=[nowDate dateByAddingTimeInterval:nowInterval];
    
    //格林威治标准时间与传入日期之间的偏移量
    NSInteger yourInterval = [zone secondsFromGMTForDate:yourDate];
    
    //将偏移量加到传入日期
    NSDate *yourTime = [yourDate dateByAddingTimeInterval:yourInterval];
    
    //time为两个日期的相差秒数

    
    NSDateComponents *delta = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:nowTime toDate:yourTime options:0];
    return delta.second;
}


+ (NSInteger)numberOfDaysWithFromDate:(NSString *)fromStr toDate:(NSString *)toStr{
    
    if ([fromStr length] == 0 ||
        [toStr length] == 0) {
        
        return 0;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay
                                         fromDate:[self ConvertStrToTimeDate:fromStr]
                                           toDate:[self ConvertStrToTimeDate:toStr]
                                          options:NSCalendarWrapComponents];
    
    NSLog(@" -- >>  comp : %@  << --",comp);
    if (comp.day == 0 && comp.second > 0) {
        
        
        return 1;
    }else{
    
        return comp.day;
    }
}



//图片压缩
+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}

+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    
    return timeSp;
}

+(NSString *)getNowTimeTimestamp_HaoMiao{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    
    return timeSp;
}

+(NSInteger )nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:dateStr]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}


+(NSInteger )nsstringConversionNSDatehhmmss:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:dateStr]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}
@end
