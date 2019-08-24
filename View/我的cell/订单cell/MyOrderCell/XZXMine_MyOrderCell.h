//
//  XZXMine_MyOrderCell.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//  我的-订单列表cell

#import <UIKit/UIKit.h>

#import "XZXMineOrderModel.h"
@interface XZXMine_MyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodname;
@property (weak, nonatomic) IBOutlet UILabel *good_content;

@property (weak, nonatomic) IBOutlet UILabel *good_num;
@property (weak, nonatomic) IBOutlet UIImageView *AftersaleImage;
@property (weak, nonatomic) IBOutlet UILabel *good_sumPrice;


-(void)LoadDataRefreshUI:(XZXMineOrderModel *)model GoodDetailModel:(XZXMineOrderGoodDetailModel *)OrderGoodDetailModel;
@end
