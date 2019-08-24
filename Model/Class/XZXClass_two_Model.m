//
//  XZXClass_two_Model.m
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXClass_two_Model.h"

@implementation XZXClass_two_Model

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goodsWithBLOBsPc": [XZXClass_two_good_Model class]};
}
@end
