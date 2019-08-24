//
//  XZXShopGoodSelectVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZX_GoodDetail_CommonModel.h"
#import "XZXShopGoodSelectGuiGeModel.h"


typedef NS_ENUM(NSInteger,type) {
    AddCar,
    Buy
};


@class XZXShopGoodSelectGuiGeModel;
@interface XZXShopGoodSelectModel:NSObject

@property (nonatomic,copy)NSString *spName;
@property (nonatomic,copy)NSMutableArray <XZXShopGoodSelectGuiGeModel *>*specValueList;
@end




@interface XZXShopGoodSelectVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *BottomView;
@property (weak, nonatomic) IBOutlet UIButton *AddCarBtn;
- (IBAction)AddCar_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BuyBtn;
- (IBAction)Buy_Action:(id)sender;

@property (nonatomic,copy) void(^BuyGoods)(XZX_GoodDetail_CommonModel *GoodModel,NSMutableArray *Select_DataArray_GuiGe);


//商品信息
@property (nonatomic,strong)XZX_GoodDetail_CommonModel *GoodModel;

//如果是秒杀产品，传入剩余时间
@property (nonatomic,assign) NSInteger  LastTime;//返回当前商品的秒杀的剩余时间
@property (nonatomic,assign)NSInteger JF_type;//3积分购物 4积分兑换

@end
