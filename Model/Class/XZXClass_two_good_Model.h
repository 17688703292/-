//
//  XZXClass_two_good_Model.h
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_two_good_Model : NSObject

@property (nonatomic,copy) NSString *storeName;
@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *goodsCommonid;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsPrice;
@property (nonatomic,copy) NSString *goodsPromotionPrice;//活动价格
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *goodsPromotionType;//0普通
@property (nonatomic,assign) NSInteger goodsSalenum;//销量
@property (nonatomic,assign) NSInteger activitySellCount;//活动销量
@property (nonatomic,assign) NSInteger isOwnShop;//1、自营店铺商品
@end

NS_ASSUME_NONNULL_END
