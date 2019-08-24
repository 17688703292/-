//
//  XZXReturnAfterSale.h
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXReturnAfterSale : XHBaseTableViewController


@property (nonatomic,strong)XZXOrderDetailModel *DetailModel;//订单详情
@property (nonatomic,strong)XZXMineOrderGoodDetailModel *goodmodel;//订单中的商品详情
@property (nonatomic,copy)void (^Finish)(void);

@end

NS_ASSUME_NONNULL_END
