//
//  XZXStoreInformationModel.m
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXStoreInformationModel.h"

@implementation XZXStoreInformationModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goods": [XZXClass_two_good_Model class]};
}
@end
