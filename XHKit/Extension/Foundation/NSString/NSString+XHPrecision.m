//
//  NSString+XHPrecision.m
//  BigMarket
//
//  Created by RedSky on 2019/6/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "NSString+XHPrecision.h"

@implementation NSString (XHPrecision)


+(NSString *)reviseString:(NSString *)string{
    /* 直接传入精度丢失有问题的Double类型*/
    double conversionValue        = (double)[string floatValue];
    NSString *doubleString        = [NSString stringWithFormat:@"%0.3f", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

@end
