//
//  XZXOrderDetailModel.m
//  Slumbers
//
//  Created by RedSky on 2019/3/9.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXOrderDetailModel.h"

@implementation XZXOrderDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goodsList": [XZXMineOrderGoodDetailModel class]};
}
@end
