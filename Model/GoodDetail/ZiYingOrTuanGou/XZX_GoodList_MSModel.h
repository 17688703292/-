//
//  XZX_GoodList_MSModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZX_Good_MSModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZX_GoodList_MSModel : NSObject

@property (nonatomic,copy) NSString *count;//总数
@property (nonatomic,strong)NSMutableArray <XZX_Good_MSModel *>*goods;
@property (nonatomic,copy) NSString *spikeTime;//秒杀时间点
@property (nonatomic,copy) NSString *spikeLasttime;//持续时间
@property (nonatomic,copy) NSString *spikeId;
@end

NS_ASSUME_NONNULL_END
