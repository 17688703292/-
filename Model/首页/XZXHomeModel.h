//
//  XZXHomeModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXHome_AdvModel.h"
#import "XZXHome_activityModel.h"
#import "XZXHome_classModel.h"
#import "XZXClass_rightModel.h"
#import "XZXHome_goodListModel.h"
#import "XZXClass_two_good_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHomeModel : NSObject
@property (nonatomic,strong) NSMutableArray <XZXHome_classModel*>*class;//类别
@property (nonatomic,strong) NSMutableArray <XZXHome_activityModel*>*activity;//活动栏目列表
@property (nonatomic,strong) NSMutableArray <XZXHome_activityModel*>*activity2;//活动栏目列表2
@property (nonatomic,strong) NSMutableArray <XZXHome_AdvModel*>*navigationImage;//广告
@property (nonatomic,strong) XZXHome_goodListModel *selfSupport;//自营专区列表
@property (nonatomic,strong) XZXHome_goodListModel *groupBuy;//团购
@property (nonatomic,strong) XZXHome_goodListModel *spike;//秒杀
@property (nonatomic,strong) XZXHome_goodListModel *zhongchou;//众筹
@property (nonatomic,strong) XZXHome_goodListModel *jifen;//积分专区
@property (nonatomic,strong) XZXHome_goodListModel *remai;//积分专区
@property (nonatomic,strong) NSMutableArray <XZXClass_two_good_Model*>*goods;
@end

NS_ASSUME_NONNULL_END
