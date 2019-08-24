//
//  XZX_GoodList_MSModel.m
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_MSModel.h"

@implementation XZX_GoodList_MSModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goods": [XZX_Good_MSModel class]};
}
@end
