//
//  XZX_GoodList_ZYTV.h
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXHome_activityModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,GoodList_ZYTV_type) {
    ZYTV_ZY_t,//自营
    ZYTV_TG_t,//团购
    ZYTV_RM_t//热卖
    
};


@interface  XZX_GoodList_ZY_Model : NSObject

@end

@interface  XZX_GoodList_TG_Model : NSObject

@end


@interface XZX_GoodList_ZYTV : XHBaseTableViewController

@property (nonatomic,assign) NSInteger ZYTV_t;
@property (nonatomic,strong) XZXHome_activityModel *activityModel;
@property (nonatomic,strong) NSString *gcid;
@end

NS_ASSUME_NONNULL_END
