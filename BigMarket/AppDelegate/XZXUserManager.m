//
//  XZXUserManager.m
//  Slumbers
//
//  Created by zhu on 2018/11/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XZXUserManager.h"

@implementation XZXUserManager

+ (instancetype)defaultManager {
    static XZXUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[XZXUserManager alloc] init];
        }
    });
    return manager;
}

-(void)GetInfo:(NSDictionary *)info{
    
    self.token = [info valueForKey:@"token"];
    self.member_id = [[info valueForKey:@"userId"] integerValue];
    self.discount  = [[info valueForKey:@"discount"] floatValue];
    self.account   = [info valueForKey:@"memberMobile"];
}

-(void)cleanInfo{
    
    self.token = @"";
    self.member_id = 0;
    self.discount  = 1.0;
}


@end
