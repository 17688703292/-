//
//  XZXShopGood_UploadOrderModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/24.
//  Copyright © 2019 RedSky. All rights reserved.
//  确认订单

#import <Foundation/Foundation.h>
#import "XZXMine_AreaListModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZXShopGood_UploadOrder_GoodModel : NSObject


@property (nonatomic,assign)NSInteger score;//积分
@property (nonatomic,copy) NSString *goodsId;//商品ID
@property (nonatomic,copy) NSString *cartId;//购物车ID
@property (nonatomic,copy) NSString *goodsPrice;
@property (nonatomic,copy) NSString *storeName;
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsNum;
@property (nonatomic,copy) NSString *buyerMessage;//买家留言
@property (nonatomic,strong)NSMutableArray *GuiGe_array;//zdy-选中规格
@property (nonatomic,strong)NSMutableString *GuiGe_str;//zdy-选中规格文字显示
@property (nonatomic,copy) NSString *goodsPromotionPrice;
@property (nonatomic,assign) NSInteger goodsPromotionType;
@property (nonatomic,assign)NSString *shippingFee;//购物车进入返回的邮费
@end

@interface XZXShopGood_UploadOrderModel : NSObject

@property (nonatomic,strong)XZXMine_AreaListModel *address;
@property (nonatomic,strong)NSMutableArray <XZXShopGood_UploadOrder_GoodModel *>*cart;
@property (nonatomic,assign)CGFloat payMoney_f;//zdy-支付价格
@property (nonatomic,copy)NSString *goodsFreight;//直接购买商品返回的邮费

@end

NS_ASSUME_NONNULL_END
