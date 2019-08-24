//
//  XZXUserManager.h
//  Slumbers
//
//  Created by zhu on 2018/11/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZXUserManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic,copy) NSString *account;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSInteger member_id;
@property (nonatomic, assign) CGFloat discount;
-(void)GetInfo:(NSDictionary *)info;
-(void)cleanInfo;
@end
