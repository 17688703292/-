//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "NSString+XHSandbox.h"

@implementation NSString (XHExtension)

// 生成沙盒Ducument文件夹下文件路径
+ (NSString *)xh_pathInSandboxDucuments:(NSString *)name withType:(NSString *)type {
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *basePath = [NSString stringWithFormat:@"%@/%@",docDir, name];
    long long time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *path = [[self getSavePathWithBasePath:basePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld.%@",time, type]];
    return path;
}

// 生成沙盒Temp文件夹下文件路径
+ (NSString *)xh_pathInSandboxTempWithType:(NSString *)type {
    NSString *tmpDir =  NSTemporaryDirectory();
    long long time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *path = [tmpDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld.%@",time, type]];
    return path;
}

//获取保存目录
+ (NSString *)getSavePathWithBasePath:(NSString *)basePath
{
    NSString *document = basePath;
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:document isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return document;
}

@end
