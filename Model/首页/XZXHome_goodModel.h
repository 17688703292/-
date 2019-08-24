//
//  XZXHome_goodModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_goodModel : NSObject

@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *goodsPrice;
@property (nonatomic,copy) NSString *goodsPromotionType;//活动类型
@property (nonatomic,copy) NSString *goodsJingle;//描述
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,copy) NSString *goodsPromotionPrice;

//众筹
@property (nonatomic,copy) NSString *goodsCommonid;
@property (nonatomic,copy) NSString *fullPaymentPeople;//设定人数
@property (nonatomic,copy) NSString *currentOnePeople;//一元支持
@property (nonatomic,copy) NSString *currentFullPeople;//全款支持

@end

NS_ASSUME_NONNULL_END
