//
//  XZXAp_Store_TwoVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN



@interface XZXAp_Store_TwoModel : NSObject

@property (nonatomic,copy)NSString *storeJoinin1Id;//上传资料id
@property (nonatomic,copy)NSString *scId;//类型id
@property (nonatomic,copy)NSString *companyName;//公司名称
@property (nonatomic,copy)NSString *productName;//产品名称
@property (nonatomic,copy)NSString *companyPhone;//公司电话
@property (nonatomic,copy)NSString *companyBusinessLicense;//公司营业执照
@property (nonatomic,copy)NSString *companyRegistrationCertificate;//公司商标注册证
@property (nonatomic,copy)NSString *companyInspectionReport;//公司检验报告
@property (nonatomic,copy)NSString *companyAccountPermit;//公司开户许可证
@property (nonatomic,copy)NSString *companyProductionLicense;//公司生产许可证
@property (nonatomic,copy)NSString *companyPriceTable;//公司含税/含物流价格表
@property (nonatomic,copy)NSString *generationCompanyBusinessLicense;//代加工公司营业执照
@property (nonatomic,copy)NSString *generationCompanyProductionLicense;//代加工公司生产许可证
@property (nonatomic,copy)NSString *mallAuthorization;//云端商城授权书


@end

@interface XZXAp_Store_TwoVC : XHBaseViewController

@property (nonatomic,copy)NSString *storeId;//商店ID

@end

NS_ASSUME_NONNULL_END
