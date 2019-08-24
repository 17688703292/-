//
//  XZXMine_AreaListModel.h
//  Slumbers
//
//  Created by RedSky on 2019/2/14.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_AreaListModel : NSObject

@property (nonatomic,copy)   NSString *address;//省市县地址
@property (nonatomic,copy)   NSString *areaInfo;//详细地址
@property (nonatomic,assign) NSInteger addressId;

//收货人
@property (nonatomic,copy)   NSString *receiver;
@property (nonatomic,copy)   NSString *trueName;
@property (nonatomic,copy)   NSString *receiverName;

//联系电话
@property (nonatomic,copy)   NSString  *phone;
@property (nonatomic,copy)   NSString  *mobPhone;
@property (nonatomic,copy)   NSString  *telPhone;

//1、默认地址
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger isDefault;

@property (nonatomic,copy)   NSString  *province;
@property (nonatomic,copy)   NSString  *city;
@property (nonatomic,assign) NSInteger cityId;
@property (nonatomic,copy)   NSString  *area;
@property (nonatomic,assign) NSInteger areaId;
@property (nonatomic,copy)   NSString  *village;


@end

NS_ASSUME_NONNULL_END
