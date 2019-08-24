//
//  XZXAp_Store_UploadMessageVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Store_UploadMessageModel : NSObject

@property (nonatomic,copy) NSString *classId;//产品分类ID
@property (nonatomic,copy) NSString *manuQualName;//上传图片的字段
@property (nonatomic,copy) NSString *remark;//标题
@property (nonatomic,copy) NSString *url;//图片链接
@property (nonatomic,strong) UIImage *image;

@end

@interface XZXAp_Store_UploadMessageVC : XHBaseViewController

@property (nonatomic,copy)NSString *storeJoinin1Id;//上传资料id
@property (nonatomic,copy)NSString *classId;//食品分类ID

@end

NS_ASSUME_NONNULL_END
