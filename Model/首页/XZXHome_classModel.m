//
//  XZXHome_classModel.m
//  BigMarket
//
//  Created by RedSky on 2019/5/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_classModel.h"

@implementation XZXHome_classModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsClassPc":[XZXClass_rightModel class]
             };
}
@end
