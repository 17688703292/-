//
//  XZXMine_ScoreList.h
//  BigMarket
//
//  Created by RedSky on 2019/4/25.
//  Copyright © 2019 RedSky. All rights reserved.
//   积分明细

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZXMine_ScoreModel : NSOrderedSet

@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *shareGoods;
@property (nonatomic,copy) NSString *signScore;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *buyGoodsScore;
@property (nonatomic,strong) NSMutableArray *list;
@end

@interface XZXMine_ScoreListModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *scoreDesc;//描
@property (nonatomic,copy) NSString *score;//积分
@property (nonatomic,copy) NSString *price;//商品价格
@property (nonatomic,copy) NSString *goodsId;//商品ID
@property (nonatomic,copy) NSString *scoreType;//积分收入来源类型：1签到，2商品购买，3分享商品
@property (nonatomic,copy) NSString *type;//积分类型：1收入，2支出
@property (nonatomic,copy) NSString *createDateStr;


@end

@interface XZXMine_ScoreList : XHBaseViewController

@end

NS_ASSUME_NONNULL_END
