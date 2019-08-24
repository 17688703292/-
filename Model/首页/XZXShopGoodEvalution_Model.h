//
//  XZXShopGoodEvalution_Model.h
//  BigMarket
//
//  Created by RedSky on 2019/5/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXShopGoodEvalution_Model : NSObject

@property (nonatomic,copy)NSString *gevalFrommembername;//用户昵称
@property (nonatomic,copy)NSString *gevalFrommemberImage;//用户头像
@property (nonatomic,copy)NSString *gevalAddtime;//时间
@property (nonatomic,copy)NSString *gevalContent;//评价内容
@property (nonatomic,copy)NSString *gevalImage;//评价图片
@property (nonatomic,assign)BOOL gevalIsanonymous;//匿名

@end

NS_ASSUME_NONNULL_END
