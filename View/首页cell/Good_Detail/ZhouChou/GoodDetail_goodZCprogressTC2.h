//
//  GoodDetail_goodZCprogressTC2.h
//  BigMarket
//
//  Created by RedSky on 2019/7/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZX_GoodDetail_CommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodDetail_goodZCprogressTC2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *JoinPeople_lab;
@property (weak, nonatomic) IBOutlet UILabel *AllpayPeople_lab;
@property (weak, nonatomic) IBOutlet UILabel *AllMoney_lab;
@property (weak, nonatomic) IBOutlet UILabel *LastDay_lab;

@property (nonatomic,strong)XZX_GoodDetail_CommonModel *MyModel;
@end

NS_ASSUME_NONNULL_END
