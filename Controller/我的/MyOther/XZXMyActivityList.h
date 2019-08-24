//
//  XZXMyActivityList.h
//  BigMarket
//
//  Created by RedSky on 2019/5/22.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMyActivity_MS_Model : NSObject


@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsPrice;
@property (nonatomic,copy) NSString *goodsScore;
@property (nonatomic,copy) NSString *spikeTime;
@property (nonatomic,copy) NSString *spikeLasttime;
@property (nonatomic,copy) NSString *storeId;

@property (nonatomic,assign) NSInteger LastTime;//自定义剩余时间
@end


@interface XZXMyActivityList : XHBaseTableViewController

@end

NS_ASSUME_NONNULL_END
