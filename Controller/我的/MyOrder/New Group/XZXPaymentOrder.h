//
//  XZXPaymentOrder.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//  订单付款

#import "XHBaseTableViewController.h"


typedef NS_ENUM(NSInteger,XZXPaymentOrder_type) {
    
    HaveRecordPay = 1,
};

@interface XZXPaymentOrder : XHBaseViewController
@property (nonatomic,copy) void (^PayFairBlock)(void);
@property (nonatomic,copy) void (^PaySuccessBlock)(NSDictionary *order_data);
@property (nonatomic,copy) void (^PayRedScoredBlock)(NSDictionary *order_data,NSString *url,NSMutableDictionary *parameters);
@property (nonatomic,strong) NSMutableDictionary  *order_data;//订单数据
@property (nonatomic,assign) NSInteger VC_type;//VC_type == HaveRecordPay 积分商品增加红积分支付

@end
