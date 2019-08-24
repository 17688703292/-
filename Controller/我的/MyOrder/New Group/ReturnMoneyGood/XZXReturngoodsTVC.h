//
//  XZXReturngoodsTVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXOrderDetailModel.h"

#import "XZXMineOrderGoodDetailModel.h"

typedef NS_ENUM(NSInteger,RGVC_Type) {
    
    Add_RGAfterSale,//新增加售后
    Edit_RGAfterSale//编辑售后
};

@interface XZXReturngoodsTVC : XHBaseViewController

@property (nonatomic,strong)XZXOrderDetailModel *DetailModel;//订单详情(仅需要orderId/money/shippingFee)
@property (nonatomic,strong)XZXMineOrderGoodDetailModel *goodmodel;//订单中的商品详情
@property (nonatomic,copy)void (^Finish)(void);

@property (nonatomic,assign) NSInteger RGVC_Type;//编辑or新增加
@property (nonatomic,strong) NSMutableDictionary *RGVC_Model;
@end
