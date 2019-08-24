//
//  XZXHome_Activity_GoodListModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXHome_Activity_GoodModel.h"
#import "XZXHome_AdvModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_Activity_GoodListModel : NSObject

@property (nonatomic,strong) NSMutableArray <XZXHome_Activity_GoodModel *>*goods;
@property (nonatomic,copy) NSString *activityId;
@property (nonatomic,copy) NSString *activityType;
@property (nonatomic,strong) NSMutableArray <XZXHome_AdvModel *>*imageList;
@property (nonatomic,strong) NSMutableArray *storeImages;
@end

NS_ASSUME_NONNULL_END
