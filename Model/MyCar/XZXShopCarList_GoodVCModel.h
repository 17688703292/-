//
//  XZXShopCarList_GoodVCModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XZXShopCarList_GoodVCModel : NSObject

@property(nonatomic,copy) NSString *cartId;// 购物车id

@property(nonatomic,assign) NSInteger  buyerId;// 购买者id

@property(nonatomic,copy) NSString *storeId;//  店铺id

@property(nonatomic,copy) NSString  *storeName;// 店铺名称

@property(nonatomic,copy) NSString  *goodsId;// 商品id

@property(nonatomic,copy) NSString  *goodsName;// 商品名称

@property(nonatomic,copy) NSString *goodsPrice;// 商品单价

@property(nonatomic,copy) NSString *score;//  商品积分

@property(nonatomic,assign) NSInteger goodsNum;// 购买数量

@property(nonatomic,copy) NSString *goodsImage;// 商品图片

@property(nonatomic,copy) NSString *cartUnionId;

@property(nonatomic,assign) NSInteger blId;//??

@property(nonatomic,copy) NSString *spValueId;//规格ID
@property(nonatomic,copy) NSString *spValueIdStr;//规格名称

@property(nonatomic,assign) NSInteger selectGood;//收否选中商品
@end

NS_ASSUME_NONNULL_END
