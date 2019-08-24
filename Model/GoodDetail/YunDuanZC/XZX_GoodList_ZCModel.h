//
//  XZX_GoodList_ZCModel.h
//  BigMarket
//
//  Created by RedSky on 2019/7/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZX_GoodList_ZCModel : NSObject

@property (nonatomic,copy) NSString *fullPaymentPeople;//成设置功支持人数
@property (nonatomic,copy) NSString *currentFullPeople;//全款人数
@property (nonatomic,copy) NSString *currentOnePeople;//一元支持人数
@property (nonatomic,copy) NSString *gcId;//
@property (nonatomic,copy) NSString *goodsCommonid;
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsJingle;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsPrice;
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,strong) NSMutableArray *goodsImagesList;

@end

NS_ASSUME_NONNULL_END
