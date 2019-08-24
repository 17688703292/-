//
//  CSScanVC.h
//  VBElectronicCigarettes
//
//  Created by zhu on 2018/5/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseViewController.h"

@interface CSScanVC : XHBaseViewController


@property (nonatomic,copy)void (^ScanResult)(NSString *ResultCode);
@end
