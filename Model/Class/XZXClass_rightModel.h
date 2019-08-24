//
//  XZXClass_rightModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_rightModel : NSObject

@property (nonatomic,copy) NSString *gcParentId;//属于的行业ID

@property (nonatomic,assign) NSInteger typeId;//商品类别ID
@property (nonatomic,copy) NSString *typeName;//商品类别名称

@property (nonatomic,assign) NSInteger gcId;//商品ID
@property (nonatomic,copy) NSString *gcName;//商品名称
@property (nonatomic,copy) NSString *gcThumb;//商品图片

@end

NS_ASSUME_NONNULL_END
