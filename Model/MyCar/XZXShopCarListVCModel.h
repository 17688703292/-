//
//  XZXShopCarListVCModel.h
//  Slumbers
//
//  Created by RedSky on 2019/1/25.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXShopCarList_GoodVCModel.h"

NS_ASSUME_NONNULL_BEGIN


@class XZXShopCarList_GoodVCModel;

@interface XZXShopCarListVCModel : NSObject

@property (nonatomic,strong)NSMutableArray <XZXShopCarList_GoodVCModel *>*data;
@property (nonatomic,copy) NSString *name;
@property(nonatomic,assign) NSInteger selectStore;//收否选中店铺
@end



NS_ASSUME_NONNULL_END
