//
//  XZXMyAgentGoodListModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMyAgentGoodListModel : NSObject

@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *goodsImage;
@property (nonatomic,copy)NSString *goodsName;
@property (nonatomic,copy)NSString *goodsPrice;
@property (nonatomic,assign)NSInteger goodsPromotionType;//代理类型 70省 80 市 90 县
@property (nonatomic,copy)NSString *score;//积分
@property (nonatomic,copy)NSString *storeId;
@end

NS_ASSUME_NONNULL_END
