//
//  XZXShopGoodsDetailImageModel.h
//  DoorLock
//
//  Created by RedSky on 2019/3/4.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXShopGoodsDetailImageModel : NSObject

@property (nonatomic,copy) NSString *pro_id;
@property (nonatomic,copy) NSString *pro_name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *integral;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *sale;//销量
@property (nonatomic,copy) NSString *sales;//销量
@property (nonatomic,copy) NSString *storeId;//
@end

NS_ASSUME_NONNULL_END
