//
//  XZXShopGood_UploadOrderVC.h
//  DoorLock
//
//  Created by RedSky on 2019/3/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"
#import "XZX_GoodDetail_CommonModel.h"
#import "XZXShopGoodSelectGuiGeModel.h"
#import "XZXHome_activityModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,UploadOrder_type) {
    CarList,
    Good_Order,
    Actity_ZY,
    Actity_MS,
    Actity_TG,
    Actity_ZC,
    Actity_JF,
    Actity_Agent//代理
};


@interface XZXShopGood_UploadOrderVC : XHBaseViewController


@property (nonatomic,copy) NSString *paramete_id;//购物车传递
@property (nonatomic,copy) NSMutableArray *tables;//购物车需要切换收货地址，重新计算邮费

@property (nonatomic,assign) NSInteger activitytype;
@property (nonatomic,strong) NSMutableArray *GuiGe_Array;//选择的商品规格
@property (nonatomic,strong) XZX_GoodDetail_CommonModel *CommonModel;//订单详情传递
@property (nonatomic,assign) NSInteger UploadOrder_type;
@property (nonatomic,copy) void(^GetFirstPageInformation)(void);

//众筹
@property (nonatomic,assign) NSInteger ZC_type;// 1、一元众筹 2、全款支持
@property (nonatomic,assign)NSInteger JF_type;//3积分购物 4积分兑换

@end

NS_ASSUME_NONNULL_END
