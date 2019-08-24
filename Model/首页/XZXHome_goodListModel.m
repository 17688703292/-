//
//  XZXHome_goodListModel.m
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_goodListModel.h"

@implementation XZXHome_goodListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list": [XZXHome_goodModel class]

             };
}
@end
