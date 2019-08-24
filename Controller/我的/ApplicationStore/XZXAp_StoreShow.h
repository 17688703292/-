//
//  XZXAp_StoreShow.h
//  BigMarket
//
//  Created by RedSky on 2019/6/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,tag) {
    
    upload_message,//厂家信息
    upload_contract,//合同
    Finally//开店成功，可重复上传厂家资质
};

@interface XZXAp_StoreShow : XHBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *store_name;

@property (nonatomic,copy)NSString *productNum;
@property (nonatomic,copy)NSString *storeNameStr;
@property (nonatomic,copy)NSString *storeImageStr;
@property (nonatomic,copy)NSString *storeId;
@property (nonatomic,assign)NSInteger VC_type;

@end


NS_ASSUME_NONNULL_END
