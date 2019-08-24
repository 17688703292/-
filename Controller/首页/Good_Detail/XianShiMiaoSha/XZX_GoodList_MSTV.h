//
//  XZX_GoodList_MSTV.h
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXHome_activityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZX_GoodList_MSTV : XHBaseTableViewController

@property (nonatomic,strong) XZXHome_activityModel *activityModel;
@property (nonatomic,strong) NSString *gcid;

@end

NS_ASSUME_NONNULL_END
