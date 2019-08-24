//
//  XZXPaymentOrderModel.m
//  Slumbers
//
//  Created by RedSky on 2019/2/21.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXPaymentOrderModel.h"

@implementation XZXPaymentOrderModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"area": [XZXPaymentOrder_AdressModel class],@"order_goods":[XZXMineOrderGoodDetailModel class]};
}

@end
