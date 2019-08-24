//
//  XZXMyOrderDetail_goodCell.h
//  Slumbers
//
//  Created by RedSky on 2019/3/9.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZXMineOrderGoodDetailModel.h"
#import "XZXOrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class XZXMyOrderDetail_goodCell;
@protocol XZXMyOrderDetail_goodCellDelegate <NSObject>

-(void)didselectCell:(XZXMyOrderDetail_goodCell *)cell;

@end

@interface XZXMyOrderDetail_goodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;

@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UILabel *good_num;
@property (weak, nonatomic) IBOutlet UIButton *operationBtn;
- (IBAction)Operation_Action:(id)sender;

@property (nonatomic,strong) XZXMineOrderGoodDetailModel *OrderGoodDetailModel;
@property (nonatomic,strong) XZXOrderDetailModel *OrderDetailModel;
@property (nonatomic,weak)id<XZXMyOrderDetail_goodCellDelegate>delegte;
@end

NS_ASSUME_NONNULL_END
