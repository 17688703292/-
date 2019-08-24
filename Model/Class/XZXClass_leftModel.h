//
//  XZXClass_leftModel.h
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXClass_rightModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_leftModel : NSObject

@property (nonatomic,assign) NSInteger gcId;//行业分类ID
@property (nonatomic,copy) NSString *gcName;//行业分类名称
@property (nonatomic,copy) NSString *cnPic;//行业分类图片
@property (nonatomic,copy) NSString *gcThumb;//行业分类广告
@property (nonatomic,strong) NSMutableArray <XZXClass_rightModel *>*goodsClass;
@end

NS_ASSUME_NONNULL_END
