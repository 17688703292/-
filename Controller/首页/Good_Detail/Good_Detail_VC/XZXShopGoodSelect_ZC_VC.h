//
//  XZXShopGoodSelect_ZC_VC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"
#import "XZX_GoodDetail_CommonModel.h"
#import "XZXShopGoodSelectGuiGeModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZXShopGoodSelect_ZC_Model:NSObject

@property (nonatomic,copy)NSString *spName;
@property (nonatomic,copy)NSMutableArray <XZXShopGoodSelectGuiGeModel *>*specValueList;
@end

@interface XZXShopGoodSelect_ZC_VC : XHBaseViewController
@property (weak, nonatomic) IBOutlet UIView *BottomView;
@property (weak, nonatomic) IBOutlet UIButton *BuyBtn;
- (IBAction)Buy_Action:(id)sender;
@property (nonatomic,copy) void(^BuyGoods)(XZX_GoodDetail_CommonModel *GoodModel,NSMutableArray *Select_DataArray_GuiGe,NSInteger buy_type);


//商品信息
@property (nonatomic,strong)XZX_GoodDetail_CommonModel *GoodModel;
@end

NS_ASSUME_NONNULL_END
