//
//  Activity2Model.m
//  BigMarket
//
//  Created by RedSky on 2019/5/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "Activity2Model.h"

@implementation Activity2Model


+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goods": [XZXHome_goodModel class],
             @"imageList":[XZXHome_AdvModel class]
             };
}
@end
