//
//  XZXHome_Class_StoreCVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseCollectionViewController.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,VC_type) {
    
    Store_List,
    GoodClass_List
};

@interface  XZXHome_StoreModel: NSObject

@property (nonatomic,copy)NSString *storeAvatar;
@property (nonatomic,copy)NSString *storeId;
@property (nonatomic,copy)NSString *storeName;
@property (nonatomic,copy)NSString *storeKeywords;

@end

@interface XZXHome_Class_StoreCVC : XHBaseCollectionViewController

@property (nonatomic,copy)void(^DidSelectClassBlock)(NSInteger index);


@property (nonatomic,assign) NSInteger VC_type;
@end

NS_ASSUME_NONNULL_END
