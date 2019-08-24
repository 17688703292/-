//
//  XZXShopCarListCell.h
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopCarList_GoodVCModel.h"

@class XZXShopCarListCell;
@protocol XZXShopCarListCellDelegate <NSObject>

-(void)SelectSignalGood:(XZXShopCarListCell *)cell;
-(void)ReduceGood:(XZXShopCarListCell *)cell;
-(void)AdGood:(XZXShopCarListCell *)cell;

@end


@interface XZXShopCarListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *GoodsName;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *GoodsNum;
@property (weak, nonatomic) IBOutlet UIButton *SelectSignalGoodBtn;

- (IBAction)SelectSignalGood_Action:(id)sender;

- (IBAction)ReduceGood_Action:(id)sender;
- (IBAction)AdGood_Action:(id)sender;


@property (nonatomic,strong)XZXShopCarList_GoodVCModel *GoodModel;
@property (nonatomic,weak)id <XZXShopCarListCellDelegate>delegate;
@end
