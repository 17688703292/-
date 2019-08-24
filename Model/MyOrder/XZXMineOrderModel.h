//
//  XZXMineOrderModel.h
//  Slumbers
//
//  Created by RedSky on 2019/2/20.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXMineOrderGoodDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXMineOrderModel : NSObject


@property (nonatomic,strong)NSArray <XZXMineOrderGoodDetailModel *>*orderGoodsList;

@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,copy)NSString *orderSn;
@property (nonatomic,assign)NSInteger orderState;
@property (nonatomic,assign)NSInteger orderType;
@property (nonatomic,copy) NSString *paySn;
@property (nonatomic,copy) NSString *paymentTime;
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,copy) NSString *storeName;
@property (nonatomic,copy) NSString *goodsAmount;//商品总价格
@property (nonatomic,copy) NSString *orderAmount;//商品总价格
@property (nonatomic,copy) NSString *money;//订单实际支付价格
@property (nonatomic,assign) NSInteger evaluationState;//订单状态和商品中的evaluationState组合判断，订单中的商品是否已经评价过

@property (nonatomic,assign)NSInteger last_page;
@property (nonatomic,assign)NSInteger current_page;
@property (nonatomic,assign)NSInteger total;
@property (nonatomic,copy) NSString *crowdType;// 1、一元众筹 2、全款支持 3、积分购 4、积分兑

//积分商品
@property (nonatomic,copy) NSString *blueScore;
@property (nonatomic,copy) NSString *redScore;
@end

NS_ASSUME_NONNULL_END
