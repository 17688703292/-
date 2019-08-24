//
//  NSArray+Category.m
//  Box
//
//  Created by ZhaoYong on 16/12/28.
//  Copyright © 2016年 pro. All rights reserved.
//

#import "NSArray+Category.h"
#import <objc/runtime.h>
@implementation NSArray (Category)
+(void)load{
    static dispatch_once_t One;
    dispatch_once(&One, ^{
        
        Method systemMethod =class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method MyMethod =class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(My_objectAtIndex:));
        method_exchangeImplementations(systemMethod,MyMethod);
        
    });

}
-(id)My_objectAtIndex:(NSInteger )index{
    if (self.count >index && index >= 0) {
        return [self My_objectAtIndex:index];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NSarrayOVer" object:nil];
        return nil;
    }

}
@end
