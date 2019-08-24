//
//  XZXStoreInformationTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZXStoreInformationDetailModel : NSObject

@property (nonatomic,copy)NSString *storeAddress;
@property (nonatomic,copy)NSString *storePhone;
@property (nonatomic,copy)NSString *sellerName;
@property (nonatomic,copy)NSString *storeName;
@property (nonatomic,copy)NSString *storePictureBusinessLicense;
@end

@interface XZXStoreInformationTVC : XHBaseTableViewController

@property (nonatomic,copy)NSString *storeId;
@end

NS_ASSUME_NONNULL_END
