 //
//  XZXOrderDetailModel.h
//  Slumbers
//
//  Created by RedSky on 2019/3/9.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXMineOrderGoodDetailModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZXOrderDetailModel : NSObject

@property (nonatomic,copy) NSString * addressMessage;
@property (nonatomic,copy) NSString * reciverName;
@property (nonatomic,copy) NSString * reciverPhone;
@property (nonatomic,copy) NSString * shippingFee;//邮费
@property (nonatomic,copy) NSString * storeId;
@property (nonatomic,copy) NSString * storeName;
@property (nonatomic,copy) NSString * money;//订单实际支付价格
@property (nonatomic,copy) NSString * orderId;
@property (nonatomic,copy) NSString * orderTime;
@property (nonatomic,copy) NSString * payMethod;
@property (nonatomic,copy) NSString * payTIme;
@property (nonatomic,assign) NSInteger orderState;
@property (nonatomic,assign) NSInteger evaluationState;
@property (nonatomic,copy )NSString *outTradeNo;
@property (nonatomic,copy )NSString *expireMinute;//秒杀支付间隔时间段

@property (nonatomic,strong) NSArray<XZXMineOrderGoodDetailModel *> *goodsList;

//待收货
@property (nonatomic,assign) NSInteger deliveryTime;
@property (nonatomic,assign) NSInteger serverTime;

//积分购物 众筹
@property (nonatomic,copy) NSString *crowdType;//1、一元众筹 2、全款众筹 3、积分购物 4、积分兑换
//积分商品
@property (nonatomic,copy) NSString *blueScore;
@property (nonatomic,copy) NSString *redScore;
@end

NS_ASSUME_NONNULL_END
