//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XHOther)
/**
 生成二维码
 @param size 大小
 @param messge 内容
 @return 图片
 */
+ (UIImage *)xh_QRCodeWithSize:(CGFloat)size withMessage:(NSString *)messge;

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+ (UIImage *)xh_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 视屏获取帧图片
 @param videoURL 视频url
 @param time 第几帧
 @return 图片
 */
+ (UIImage *)xh_thumbImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
