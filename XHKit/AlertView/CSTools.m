//
//  CSTools.m
//  GuTangFinance
//
//  Created by 朱学鸿 on 2018/3/24.
//  Copyright © 2018年 com.carson. All rights reserved.
//

#import "CSTools.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation CSTools

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

+ (void)showHudToView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.bezelView.backgroundColor = kBlack;
    //    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
}

+ (void)hideHudToView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:true];
}

+ (void)showHudWithMessage:(NSString *)message toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.bezelView.backgroundColor = kBlack;
    hud.mode = MBProgressHUDModeText;
    //    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    //    hud.label.textColor = [UIColor whiteColor];
    if (message) {
        //        hud.label.text = [NSString stringWithFormat:@"%@",message];
        hud.labelText = [NSString stringWithFormat:@"%@",message];
    }
}

+ (void)showhudAutoHideWithMessage:(NSString *)message toView:(UIView *)view completion:(void (^)(void))completion {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    
    //    [self showHudWithMessage:message toView:view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [MBProgressHUD hideHUDForView:view animated:true];
        [HUD hide:YES];
        if (completion) {
            completion();
        }
    });
}

+ (void)showScucessAutoHideWithMessage:(NSString *)message toView:(UIView *)view completion:(void (^)(void))completion {
    [self showHudAutoHideWithImageName:@"loggingsuccess" message:message toView:view completion:completion];
}

+ (void)showErrorAutoHideWithMessage:(NSString *)message toView:(UIView *)view completion:(void (^)(void))completion {
    [self showHudAutoHideWithImageName:@"ICON-tips" message:message toView:view completion:completion];
}

+ (void)showHudAutoHideWithImageName:(NSString *)imgName message:(NSString *)message toView:(UIView *)view completion:(void (^)(void))completion {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.bezelView.backgroundColor = kBlack;
    hud.mode = MBProgressHUDModeCustomView;
    //    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:[NSString stringWithFormat:@"   %@", message] forState:UIControlStateNormal];
    hud.customView = btn;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        //        [hud hideAnimated:YES];
        if (completion) {
            completion();
        }
    });
}

+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message doneCompletion:(void (^)(void))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [cancelAction setValue:kGraywhite forKey:@"_titleTextColor"];
    return alertController;
}

+ (UIAlertController *)showAlertOneButtonWithTitle:(NSString *)title message:(NSString *)message doneCompletion:(void(^)(void))completion{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }]];
    return alertController;
}

//当前时间的时间戳
+ (NSString *)cNowTimestamp{
    NSDate *newDate = [NSDate date];
    long int timeSp = (long)[newDate timeIntervalSince1970];
    NSString *tempTime = [NSString stringWithFormat:@"%ld",timeSp];
    return tempTime;
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

// 生成二维码
+ (UIImage *)creatQRcodeWithInfo:(NSString *)path withSize:(CGSize)imageSize {
    
//    NSString *message = [NSString stringWithFormat:@"yunduan/%@",path];
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [filter setDefaults];
//    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
//    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
//    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
//    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
//
//
//    return [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:imageSize.width];
    
    
    
    //NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
   // NSLog(@"http://118.31.120.17:8089/xmall-manager-web/%@",filters);
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    //    字符串可以随意换成网址等
    NSData *qrImageData = [[NSString stringWithFormat:@"http://www.ydmall.xyz/mobile/register?code=%@",path] dataUsingEncoding:NSUTF8StringEncoding];
    
    //我们可以打印,看过滤器的 输入属性.这样我们才知道给谁赋值
   // NSLog(@"%@",qrImageFilter.inputKeys);
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    
    //再把小图片画上去
    UIImage *sImage = [UIImage imageNamed:@"Logo"];
    
    CGFloat sImageW = 100;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //设置图片
    return  finalyImage;
}

// 生成高清图片
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    //设置比例
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap（位图）;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

+ (void)validateResponse:(id)response error:(NSError *)error toView:(UIView *)view sucess:(void (^)(void))completion{
    if (error) {
        [self showhudAutoHideWithMessage:@"网络请求错误" toView:view completion:nil];
    }
    else if (response) {
        if ([[response objectForKey:@"code"] integerValue] == 200) {
            if (((NSString *)[response objectForKey:@"msg"]).length > 0) {
                [self showhudAutoHideWithMessage:[response objectForKey:@"msg"] toView:view completion:^{
                    if (completion) {
                        completion();
                    }
                }];
            }
            else {
                if (completion) {
                    completion();
                }
            }
        }
        else if ([[response objectForKey:@"code"] integerValue] == 300) {
//            CSAlertView *alertView = [CSAlertView new];
//            [alertView showAlertOneButtonWithTitle:@"提示" message:@"登录已过期" callback:^{
//                
//            }];
        }
        else {
            if (((NSString *)[response objectForKey:@"msg"]).length > 0) {
                [self showhudAutoHideWithMessage:[response objectForKey:@"msg"] toView:view completion:nil];
            }
            else {
                [self showhudAutoHideWithMessage:[response objectForKey:@"data"] toView:view completion:nil];
            }
        }
    }
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

+ (void)validateDict:(NSDictionary *)dict toView:(UIView *)view sucess:(void (^)(void))completion {
    NSLog(@"----------------请求数据----------------\n%@", dict);
    if ([dict[@"errcode"] integerValue] == 0) {
        [CSTools showhudAutoHideWithMessage:dict[@"errmsg"] toView:view completion:^{
            if (completion) {
                completion();
            }
        }];
    }
    else {
        [CSTools showhudAutoHideWithMessage:dict[@"errmsg"] toView:view completion:nil];
    }
}

+ (void)showRequestErrorToView:(UIView *)view {
    [CSTools showhudAutoHideWithMessage:@"网络请求失败，请检查网络" toView:view completion:nil];
}

+ (NSString *)showBackCardNumer:(NSString *)number {
    NSMutableString *newNumber = [NSMutableString string];
    for (int i = 1; i <= number.length; i ++) {
        if (i < number.length-3) {
            [newNumber appendFormat:@"X"];
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

+ (NSString *)showPhone:(NSString *)phone {
    NSString *newPhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
    return newPhone;
}
+(NSString *)convertToJsonData:(NSMutableDictionary *)dict{
    
    NSError *error = nil;
    NSData *jsonData = nil;
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyString = nil;
        NSString *valueString = nil;
        if ([key isKindOfClass:[NSString class]]) {
            keyString = key;
        }else{
            keyString = [NSString stringWithFormat:@"%@",key];
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            valueString = obj;
        }else{
            valueString = [NSString stringWithFormat:@"%@",obj];
        }
        
        [dict setObject:valueString forKey:keyString];
    }];
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}
@end
