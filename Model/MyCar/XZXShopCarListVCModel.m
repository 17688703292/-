//
//  XZXShopCarListVCModel.m
//  Slumbers
//
//  Created by RedSky on 2019/1/25.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXShopCarListVCModel.h"


@implementation XZXShopCarListVCModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"data": [XZXShopCarList_GoodVCModel class]};
}
@end
