//
//  XZXHome_Activity_GoodListModel.m
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_GoodListModel.h"

@implementation XZXHome_Activity_GoodListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods": [XZXHome_Activity_GoodModel class],
             @"imageList": [XZXHome_AdvModel class]
             };
}
@end
