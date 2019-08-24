//
//  XZXHome_activityModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_activityModel : NSObject

@property (nonatomic,copy) NSString *activityImage;

@property (nonatomic,copy) NSString *activitySelectImage;
@property (nonatomic,copy) NSString *activityIntroduce;
@property (nonatomic,copy) NSString *activityType;
@property (nonatomic,copy) NSString *activityId;
@property (nonatomic,copy) NSString *activityName;


//自定义
@property (nonatomic,copy) NSString *priceRange;//筛选的价格区间
@end

NS_ASSUME_NONNULL_END
