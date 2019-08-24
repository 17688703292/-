//
//  XZXClass_two_Model.h
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXClass_two_good_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_two_Model : NSObject


@property (nonatomic,copy) NSString *gcName;
@property (nonatomic,copy) NSString *gcId;
@property (nonatomic,strong) NSMutableArray <XZXClass_two_good_Model *>*goodsWithBLOBsPc;//商品列表


@end

NS_ASSUME_NONNULL_END
