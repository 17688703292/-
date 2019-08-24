//
//  XZXPaymentOrder_AdressCell.h
//  Slumbers
//
//  Created by RedSky on 2019/2/22.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXMine_AreaListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXPaymentOrder_AdressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Adress_image;
@property (weak, nonatomic) IBOutlet UILabel *Adress_name;
@property (weak, nonatomic) IBOutlet UILabel *Adress_Tetelphone;
@property (weak, nonatomic) IBOutlet UILabel *Adress_info;


@property (nonatomic,strong)XZXMine_AreaListModel *MyModel;
@end

NS_ASSUME_NONNULL_END
