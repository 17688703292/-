//
//  XZXHome_goodListModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_goodListModel : NSObject
@property (nonatomic,copy) NSString *image;//活动背景图
@property (nonatomic,copy) NSString *activityName;//
@property (nonatomic,copy) NSString *activityIntroduce;
@property (nonatomic,copy) NSString *content;//
@property (nonatomic,copy) NSString *activityId;
@property (nonatomic,strong) NSMutableArray <XZXHome_goodModel *>*list;
@end

NS_ASSUME_NONNULL_END
