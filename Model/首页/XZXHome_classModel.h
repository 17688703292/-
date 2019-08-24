//
//  XZXHome_classModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZXClass_rightModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_classModel : NSObject

@property (nonatomic,copy) NSString *gcId;
@property (nonatomic,copy) NSString *gcName;
@property (nonatomic,copy) NSString *gcThumb;

@property (nonatomic,strong)NSMutableArray <XZXClass_rightModel*>*goodsClassPc;
@end

NS_ASSUME_NONNULL_END
