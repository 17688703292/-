//
//  ZC_GoodList2_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZX_GoodList_ZCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZC_GoodList2_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ZC_statu;
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName_lab;
@property (weak, nonatomic) IBOutlet UIProgressView *progress_pro;
@property (weak, nonatomic) IBOutlet UILabel *rate_lab;
@property (weak, nonatomic) IBOutlet UILabel *supportPeople_lab;
@property (weak, nonatomic) IBOutlet UILabel *price_lab;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (nonatomic,strong)XZX_GoodList_ZCModel *MyModel;
@end

NS_ASSUME_NONNULL_END
