//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XHSandbox)

/**
 * 生成沙盒Ducument文件夹下文件路径
 * @param name 文件夹名
 * @param type 文件类型
 * @return 文件路径
 */
+ (NSString *)xh_pathInSandboxDucuments:(NSString *)name withType:(NSString *)type;

/**
 * 生成沙盒Temp文件夹下文件路径
 * @param type 文件类型
 * @return 文件路径
 */
+ (NSString *)xh_pathInSandboxTempWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
