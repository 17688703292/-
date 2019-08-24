//
//  Activity2Model.h
//  BigMarket
//
//  Created by RedSky on 2019/5/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXHome_AdvModel.h"
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Activity2Model : NSObject

@property (nonatomic,strong) NSMutableArray <XZXHome_AdvModel *>*imageList;
@property (nonatomic,copy) NSString *activityName;
@property (nonatomic,copy) NSString *activityType;
@property (nonatomic,strong) NSMutableArray <XZXHome_goodModel*>*goods;

@end

NS_ASSUME_NONNULL_END
