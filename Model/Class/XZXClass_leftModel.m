//
//  XZXClass_leftModel.m
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXClass_leftModel.h"

@implementation XZXClass_leftModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goodsClass": [XZXClass_rightModel class]};
}
@end
