//
//  XZXMineAfterSaleDetailModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineAfterSaleDetailModel : NSObject

@property (nonatomic,copy) NSString  *goodsId;
@property (nonatomic,copy) NSString  *goodsImage;
@property (nonatomic,copy) NSString  *goodsName;
@property (nonatomic,copy) NSString  *goodsScore;

@property (nonatomic,copy) NSString  *orderGoodsRefundExplain;
@property (nonatomic,copy) NSString  *orderGoodsRefundMoney;
@property (nonatomic,copy) NSString  *orderGoodsRefundReason;
@property (nonatomic,copy) NSString  *orderGoodsRefundSellerStratus;//售后状态 0审核中 1同意 2拒绝
@property (nonatomic,copy) NSString  *orderGoodsRefundStatus;//1、2、3
@property (nonatomic,copy) NSString  *orderState;//订单状态
@property (nonatomic,copy) NSString  *refundOrder;
@property (nonatomic,copy) NSString  *refundTime;//售后生成时间
@property (nonatomic,copy) NSString *serverTime;//系统时间
@property (nonatomic,copy) NSArray   *img;//售后提交的图片
@property (nonatomic,copy) NSString  *storeId;


@property (nonatomic,copy) NSString *blueScore;
@property (nonatomic,copy) NSString *redScore;
@property (nonatomic,copy) NSString *crowdType;

@end

NS_ASSUME_NONNULL_END
