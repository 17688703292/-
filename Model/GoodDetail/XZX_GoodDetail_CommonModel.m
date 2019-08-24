//
//  XZX_GoodDetail_CommonModel.m
//  BigMarket
//
//  Created by RedSky on 2019/4/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodDetail_CommonModel.h"

@implementation XZX_GoodDetail_CommonModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goodsImagesList": [goodsImagesListModel class]};
}
@end
