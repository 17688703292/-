//
//  XZXReturnAfterSaleDetail.h
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXOrderDetailModel.h"

#import "XZXMineOrderGoodDetailModel.h"

@interface XZXReturnAfterSaleDetail : XHBaseViewController

@property (nonatomic,strong)XZXOrderDetailModel *GoodDetailModel;//售后状态 3为商家拒绝可编辑后再次申请
@property (nonatomic,strong)XZXMineOrderGoodDetailModel *goodmodel;//订单中的商品详情
@property (nonatomic,copy)void (^Finish)(void);



@end
