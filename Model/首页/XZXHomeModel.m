//
//  XZXHomeModel.m
//  BigMarket
//
//  Created by RedSky on 2019/5/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeModel.h"

@implementation XZXHomeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"activity": [XZXHome_activityModel class],
             @"activity2": [XZXHome_activityModel class],
             @"navigationImage":[XZXHome_AdvModel class],
             @"class":[XZXHome_classModel class],
             @"goods":[XZXClass_two_good_Model class]
             };
}
@end
