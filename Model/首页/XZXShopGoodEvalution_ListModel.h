//
//  XZXShopGoodEvalution_ListModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXShopGoodEvalution_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXShopGoodEvalution_ListModel : NSObject
@property (nonatomic,copy)NSString *countAll;//评价总个数
@property (nonatomic,strong)NSMutableArray <XZXShopGoodEvalution_Model *>*data;//评价集合
@property (nonatomic,copy)NSString *score5;//好评个数
@property (nonatomic,copy)NSString *score3;//中评个数
@property (nonatomic,copy)NSString *score1;//差评个数

@end

NS_ASSUME_NONNULL_END
