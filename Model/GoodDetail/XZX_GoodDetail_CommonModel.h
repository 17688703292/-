//
//  XZX_GoodDetail_CommonModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "goodsImagesListModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface XZX_GoodDetail_CommonModel : NSObject


@property (nonatomic,copy) NSString *goodsCommonid;//查询规格ID
@property (nonatomic,copy) NSString *expressFee;//邮费
@property (nonatomic,copy) NSString *goodsName;//名称
@property (nonatomic,copy) NSString *price;//价格
@property (nonatomic,copy) NSString *score;//积分
@property (nonatomic,copy) NSString *goodsClick;//浏览量
@property (nonatomic,copy) NSString *sellAddress;//送货地址
@property (nonatomic,copy) NSString *titlePicture;//图片
@property (nonatomic,copy) NSArray  *type;//规格
@property (nonatomic,copy) NSArray  *youhui;//优惠
@property (nonatomic,copy) NSArray  *Evalustion;//评价
@property (nonatomic,copy) NSArray <goodsImagesListModel *>*goodsImagesList;//商品介绍
@property (nonatomic,copy) NSArray *mobileBody;//商品下部分详情介绍图
@property (nonatomic,copy) NSString *goodsSalenum;//普通商品的销量
@property (nonatomic,copy) NSString *goodsStorage;//商品库存
@property (nonatomic,assign) NSInteger favoritesFlag;//0 未收藏 1已收藏
@property (nonatomic,copy)   NSString *storeName;//商店名称
@property (nonatomic,copy) NSString *storeId;//商店ID
@property (nonatomic,copy)   NSString *goodsId;//商品ID
@property (nonatomic,assign) NSInteger gcId;//获取商品规格ID
@property (nonatomic,assign) NSInteger goodnum;//商品个数
@property (nonatomic,assign) NSInteger isOwnShop;//1为商城自营 

//活动商品
@property (nonatomic,assign)NSInteger  goodsPromotionType;//活动类型
@property (nonatomic,assign) NSInteger activityCount;//活动总量
@property (nonatomic,assign) NSInteger activitySellCount;//活动呢商品的销量
@property (nonatomic,copy) NSString *goodsPromotionPrice;//活动价

//秒杀商品
@property (nonatomic,assign)NSUInteger spikeLasttime;
@property (nonatomic,copy)NSString *spikeTime;



//众筹商品
@property (nonatomic,copy) NSString *type2;//规格-众筹 1、为有规格 0、无规格
@property (nonatomic,copy) NSString *crowdTotalMoney;//已筹金额
@property (nonatomic,copy) NSString *currentFullPeople;//全款支持人数
@property (nonatomic,copy) NSString *currentOnePeople;//一元支持人数
@property (nonatomic,copy) NSString *fullPaymentPeople;//商品设定总人数
@property (nonatomic,copy) NSString *pregoodsDeliverDate;//预计发货时间
@property (nonatomic,copy) NSString *explainDesc;//一元众筹说明
@property (nonatomic,strong) NSArray *content;//服务
@property (nonatomic,copy) NSString *goodsJingle;//商品描述
@property (nonatomic,assign) BOOL IsOver;//自定义活动是否已经结束

@property (nonatomic,copy) NSString *activityStartDate;
@property (nonatomic,copy) NSString *activityEndDate;

@end

NS_ASSUME_NONNULL_END
