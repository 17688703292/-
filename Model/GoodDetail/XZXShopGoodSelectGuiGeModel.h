//
//  XZXShopGoodSelectGuiGeModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/24.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXShopGoodSelectGuiGeModel : NSObject
@property (nonatomic,assign) NSInteger gcId;
@property (nonatomic,copy) NSString  *storeId;
@property (nonatomic,copy) NSString *spValueName;
@property (nonatomic,copy) NSString *spValueId;
@property (nonatomic,assign) NSInteger status;//1、选择 0未选择
@end

NS_ASSUME_NONNULL_END
