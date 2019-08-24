//
//  XZXMine_EditAdress_SelectArea.h
//  Slumbers
//
//  Created by RedSky on 2019/1/25.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_EditAdress_SelectArea : XHBaseViewController

@property (nonatomic,copy) void(^SelectArea)(NSString *adress,NSMutableArray *adress_array);

@end

NS_ASSUME_NONNULL_END
