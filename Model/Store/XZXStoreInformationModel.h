//
//  XZXStoreInformationModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXClass_two_good_Model.h"
NS_ASSUME_NONNULL_BEGIN


@interface XZXStoreInformationModel : NSObject

@property (nonatomic,copy) NSString *favoriteFlag;//是否收藏
@property (nonatomic,copy) NSString *storeAvatar;//商店图片
@property (nonatomic,copy) NSString *storeName;//
@property (nonatomic,copy) NSString *storeId;//
@property (nonatomic,copy) NSString *favoriteCount;//收藏总人数
@property (nonatomic,copy) NSString *count;//
@property (nonatomic,strong) NSMutableArray *goods;
@property (nonatomic,strong) NSMutableArray *storeImages;

@end

NS_ASSUME_NONNULL_END
