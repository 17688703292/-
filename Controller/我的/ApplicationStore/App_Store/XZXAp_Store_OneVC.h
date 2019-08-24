//
//  XZXAp_Store_OneVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Store_OneModel : NSObject

@property (nonatomic,copy)NSString *storeJoininName;//商家姓名
@property (nonatomic,copy)NSString *storeJoininMobile;//商家手机号码
@property (nonatomic,copy)NSString *storeJoininWx;//商家微信
@property (nonatomic,copy)NSString *storeJoininAddress;//商家地址
@property (nonatomic,copy)NSString *businessLicense;//营业执照
@property (nonatomic,copy)NSString *accountOpeningPermit;//开户许可证
@property (nonatomic,copy)NSString *operatingLicense;//经营许可证
@property (nonatomic,copy)NSString *idCard;//身份证
@property (nonatomic,copy)NSString *memberId;//
@property (nonatomic,copy)NSString *reverseIdCard;//
@property (nonatomic,copy)NSString *handIdCard;//

@end

@interface XZXAp_Store_OneVC : XHBaseViewController

@end

NS_ASSUME_NONNULL_END
