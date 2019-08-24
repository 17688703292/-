//
//  XZXEvalutionTVCModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZXMineOrderGoodDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXEvalutionTVCModel : NSObject

@property (nonatomic,copy)  NSString *orderID;

@property (nonatomic,assign) NSInteger EvalutionLevel;//评价等级
@property (nonatomic,copy)  NSString *EvalutionContent;//描述
@property (nonatomic,strong) NSMutableArray *dataArray_Pic;//图片
@property (nonatomic,assign) NSInteger anonymous;//匿名
@property (nonatomic,assign) NSInteger evaluationState;//评价
@property (nonatomic,strong)XZXMineOrderGoodDetailModel *GoodModel;//商品信息

@end

NS_ASSUME_NONNULL_END
