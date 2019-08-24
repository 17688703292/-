//
//  XZXMine_EditAdress_SelectAreaModel.h
//  Slumbers
//
//  Created by RedSky on 2019/1/25.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_EditAdress_SelectAreaModel : NSObject
@property (nonatomic,assign) NSInteger areaId;//城市ID
@property (nonatomic,copy) NSString *areaName;//城市名称
@property (nonatomic,assign) NSInteger areaDeep;//层级

@end

NS_ASSUME_NONNULL_END
