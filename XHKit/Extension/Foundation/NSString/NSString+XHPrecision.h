//
//  NSString+XHPrecision.h
//  BigMarket
//
//  Created by RedSky on 2019/6/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XHPrecision)

/**

   网络数据解析小数位精度丢失
 
 **/
+(NSString *)reviseString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
