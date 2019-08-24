//
//  XZXMineFootCVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/24.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseCollectionViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,VC_type) {
    
    VC_foot,
    VC_agentGoodList
};


@class XZXMineFootModel;


//足迹 Model
@interface XZXMineFootBaseModel : NSObject

@property (nonatomic,strong)NSMutableArray <XZXMineFootModel*>*goods;
@property (nonatomic,copy) NSString *time;

@end


@interface XZXMineFootModel : NSObject

@property (nonatomic,copy) NSString *goodsImage;

@property (nonatomic,copy) NSString *goodsName;


@property (nonatomic,copy) NSString *goodsId;


@property (nonatomic,copy) NSString *goodsPrice;


@property (nonatomic,copy) NSString *score;

@property (nonatomic,copy) NSString *storeId;

@property (nonatomic,copy) NSString *goodsPromotionType;//商品类型普通、自营、活动
@property (nonatomic,copy) NSString *goodsCommonid;
@property (nonatomic,copy) NSString *goodsPromotionPrice;
@property (nonatomic,assign) NSInteger isOwnShop;//1为商城自营店铺

@end



//代理礼包中的商品列表Model

@class XZXMineAgent_GoodListBaseModel;
@interface XZXMineAgentListBaseModel : NSObject

@property (nonatomic,copy) NSString *acCode;//礼包编码
@property (nonatomic,copy) NSString *acDescription;//礼包说明
@property (nonatomic,assign) NSInteger count;//礼包商品数目
@property (nonatomic,strong) NSMutableArray  <XZXMineAgent_GoodListBaseModel *>*goods;

@end

@interface XZXMineAgent_GoodListBaseModel : NSObject

@property (nonatomic,copy) NSString *goodsImage;

@property (nonatomic,copy) NSString *goodsName;


@property (nonatomic,copy) NSString *goodsId;


@property (nonatomic,copy) NSString *goodsPrice;


@property (nonatomic,copy) NSString *score;

@property (nonatomic,copy) NSString *storeId;
@end
@interface XZXMineFootCVC : XHBaseCollectionViewController



@property (nonatomic,assign)NSInteger VC_type;

//如果是代理那么需要代理ID
@property (nonatomic,assign)NSInteger agId;//代理ID
@end

NS_ASSUME_NONNULL_END
