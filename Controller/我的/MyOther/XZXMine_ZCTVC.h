//
//  XZXMine_ZCTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_ZCModel : NSObject

@property (nonatomic,copy) NSString *activityEndDate;
@property (nonatomic,copy) NSString *activityStartDate;
@property (nonatomic,copy) NSString *buyerId;
@property (nonatomic,copy) NSString *fullPaymentPeople;
@property (nonatomic,copy) NSString *crowdTotalMoney;
@property (nonatomic,copy) NSString *crowdType;
@property (nonatomic,copy) NSString *currentFullPeople;
@property (nonatomic,copy) NSString *currentOnePeople;
@property (nonatomic,copy) NSString *goodsCommonid;
@property (nonatomic,copy) NSString *goodsId;

@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsPrice;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,copy) NSString *orderState;//11、进行中 12、失败 20、成功
@end

@interface XZXMine_ZCTVC : XHBaseTableViewController

@end

NS_ASSUME_NONNULL_END
