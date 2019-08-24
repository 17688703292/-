//
//  XZX_Good_MSModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZX_Good_MSModel : NSObject

@property (nonatomic,copy)NSString *activitySellCount;//销售量
@property (nonatomic,copy)NSString *count;//总量
@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *goodsImage;
@property (nonatomic,copy)NSString *goodsJingle;
@property (nonatomic,copy)NSString *goodsName;
@property (nonatomic,copy)NSString *goodsPrice;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *storeId;
@property (nonatomic,copy)NSString *goodsPromotionPrice;//活动价

@end

NS_ASSUME_NONNULL_END
