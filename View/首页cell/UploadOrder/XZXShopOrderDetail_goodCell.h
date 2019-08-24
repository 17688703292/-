//
//  XZXShopOrderDetail_goodCell.h
//  DoorLock
//
//  Created by RedSky on 2019/3/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopGood_UploadOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@class XZXShopGood_UploadOrder_GoodModel;
@interface XZXShopOrderDetail_goodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;

@property (nonatomic,strong)XZXShopGood_UploadOrder_GoodModel *MyModel;
@end

NS_ASSUME_NONNULL_END
