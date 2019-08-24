//
//  XZXMineOrderBaseTVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZXMineOrderModel.h"

/**
 自定义订单状态
 */
typedef NS_ENUM(NSInteger,MineOrderBaseTVCTag) {
    
    AllOrderBase,
    WattingPaymentBase,
    WattingSendBase,
    WattingReceiveBase,
    FinishOrderBase,
    CancelBase,
    AfterSaleBase,
};

/**
 服务器定义订单状态
 */
typedef NS_ENUM(NSInteger,Service_OrderBaseTVCTag) {
    
    AllOrderBase_service        = 8,
    WattingPaymentBase_service  = 10,
    WattingSendBase_service     = 20,
    WattingReceiveBase_service  = 30,
    FinishOrderBase_service     = 40,
    CancelBase_service          = 0,
    AfterSaleBase_service       = 50,
    
    //众筹
    ZC_serviceWait = 11,//众筹付款后，等待活动结束
    ZC_serviceFair = 12//众筹付款后，众筹失败
};

@interface XZXMineOrderBaseTVC : XHBaseTableViewController

@property (nonatomic,assign) NSInteger page;//页数
@property (nonatomic,assign) NSUInteger index;//选择订单列表
-(void)Orderlist_GetInformation:(NSInteger )selectFlag;

@end
