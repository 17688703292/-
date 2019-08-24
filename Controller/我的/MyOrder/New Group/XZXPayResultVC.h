//
//  XZXPayResultVC.h
//  DoorLock
//
//  Created by RedSky on 2019/4/1.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXPayResultVC : XHBaseViewController

@property (nonatomic,strong) NSMutableDictionary  *order_data;//订单数据
@property (nonatomic,copy) NSString *allMoney;

@end

NS_ASSUME_NONNULL_END
