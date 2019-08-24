//
//  XZXAp_Store_SelectStoreTypeVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Store_SelectStoreTypeVC : XHBaseTableViewController

@property (nonatomic,copy)void(^DidSeletType)(NSDictionary *dic);

@end

NS_ASSUME_NONNULL_END
