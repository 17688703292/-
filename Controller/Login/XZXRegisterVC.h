//
//  XZXRegisterVC.h
//  Slumbers
//
//  Created by zhu on 2018/11/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XHBaseViewController.h"

typedef NS_ENUM(NSInteger, XZXCommonVCType) {
    XZXCommonVCTypeRegister,
    XZXCommonVCTypeFroget,
    XZXCommomVCTypeEditPassword,//修改密码
    XZXCommomVCTypeEditPayPassword//支付密码
};

@interface XZXRegisterVC : XHBaseViewController


@property (nonatomic, assign) XZXCommonVCType type;
@property (nonatomic, copy) NSString *memberPhone;

@end
