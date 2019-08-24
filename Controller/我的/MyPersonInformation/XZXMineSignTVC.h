//
//  XZXMineSignTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXMineSign_dayModel.h"
NS_ASSUME_NONNULL_BEGIN


@class XZXMineSign_GoodListModel;
@interface XZXMineSignModel : NSObject

@property (nonatomic,copy)NSString *score;//总积分
@property (nonatomic,copy)NSString *signLastDay;//积分累计天数
@property (nonatomic,strong)NSMutableArray <XZXMineSign_GoodListModel *>*scoreGetDetail;
@property (nonatomic,strong)NSMutableArray <XZXMineSign_dayModel *>*day;
@end


@interface XZXMineSign_GoodListModel : NSObject

@property (nonatomic,copy)NSString *id;

@property (nonatomic,copy)NSString *scoreDesc;
@property (nonatomic,copy)NSString *score;//积分
@property (nonatomic,copy)NSString *scoreType;//1签到 2消费 3分享
@property (nonatomic,copy)NSString *type;//1增加 2减少
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *createDateStr;

@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *price;

@end


@interface XZXMineSignTVC ()
@property (nonatomic,assign)NSInteger IsSign;


@end
NS_ASSUME_NONNULL_END
