//
//  XZXMineOrderModel.m
//  Slumbers
//
//  Created by RedSky on 2019/2/20.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMineOrderModel.h"

@implementation XZXMineOrderModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderGoodsList": [XZXMineOrderGoodDetailModel class]};
}


@end
