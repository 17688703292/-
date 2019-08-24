//
//  XZXMineOrderGoodDetailModel.h
//  Slumbers
//
//  Created by RedSky on 2019/2/20.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineOrderGoodDetailModel : NSObject

@property (nonatomic,copy)   NSString *gcId;
@property (nonatomic,copy)   NSString *goodsId;//商品ID
@property (nonatomic,copy)   NSString *recId;//订单商品ID
@property (nonatomic,copy)   NSString *goodsImage;
@property (nonatomic,copy)   NSString *goodsName;
@property (nonatomic,assign) NSInteger  goodsNum;
@property (nonatomic,copy)   NSString *orderGoodsRefundMoney;//订单价格  针对售后列表有用
@property (nonatomic,copy)   NSString *goodsPayPrice;//支付价格
@property (nonatomic,copy)   NSString *goodsPrice;//商品价格
@property (nonatomic,copy)   NSString *orderId;//订单ID
@property (nonatomic,copy)   NSString *storeId;
@property (nonatomic,copy)   NSString *goodsSpec;//商品规格
@property (nonatomic,copy)   NSString *goodsScore;//商品积分
@property (nonatomic,assign)  NSInteger orderGoodsRefundStatus;//0未申请售后。1仅退款。2退货退款。3换货
@property (nonatomic,copy)   NSString *orderGoodsRefundSellerStratus;//0审核中 1、同意 2、拒绝
@property (nonatomic,assign)   NSInteger evaluationState;//是否已经评价

@property (nonatomic,copy) NSString *crowdType;//1、一元众筹 2、全款众筹 0、非众筹活动商品
@end

NS_ASSUME_NONNULL_END
