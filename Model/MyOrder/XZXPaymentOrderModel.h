//
//  XZXPaymentOrderModel.h
//  Slumbers
//
//  Created by RedSky on 2019/2/21.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXPaymentOrder_AdressModel.h"
#import "XZXMineOrderGoodDetailModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface XZXPaymentOrderModel : NSObject
@property (nonatomic,copy)   NSString *all_money;
@property (nonatomic,strong) XZXPaymentOrder_AdressModel *area;
@property (nonatomic,copy)   NSString *freight;
@property (nonatomic,copy) NSString *order_sn;
@property (nonatomic,copy)   NSString *pay_sn;


@property (nonatomic,strong)NSArray <XZXMineOrderGoodDetailModel *>*order_goods;//商品

@end

NS_ASSUME_NONNULL_END
