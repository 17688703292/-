//
//  ZC_GoodList_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZX_GoodList_ZCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZC_GoodList_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UIImageView *GoodImage_SuperBig;
@property (weak, nonatomic) IBOutlet UIImageView *GoodImage_Big;
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName_lab;
@property (weak, nonatomic) IBOutlet UIProgressView *progress_pro;
@property (weak, nonatomic) IBOutlet UILabel *progress_lab;
@property (weak, nonatomic) IBOutlet UILabel *support_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodprice_lab;

@property (nonatomic,strong)XZX_GoodList_ZCModel *MyModel;
@end

NS_ASSUME_NONNULL_END
