//
//  XZXMinePersonMessageModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMinePersonMessageModel : NSObject

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *idCard;
@property (nonatomic,copy) NSString *memberImage;
@property (nonatomic,copy) NSString *memberName;
@property (nonatomic,copy) NSString *memberMobile;
@property (nonatomic,copy) NSString *memberScore;
@property (nonatomic,copy) NSString *messageFlag;//是否有消息
@property (nonatomic,assign) NSInteger isSignToDay;//是否签到
@end

NS_ASSUME_NONNULL_END
