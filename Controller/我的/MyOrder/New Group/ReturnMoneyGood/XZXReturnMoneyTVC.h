//
//  XZXReturnMoneyTVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXOrderDetailModel.h"

#import "XZXMineOrderGoodDetailModel.h"

typedef NS_ENUM(NSInteger,tag) {
    ReturnMoney = 1,
    ReturnMoneyAndGood,
    FixAfterSale//售后修改再次提交，只可以修改原因和说明，
};

typedef NS_ENUM(NSInteger,RMVC_Type) {
    
    Add_RMAfterSale,//新增加售后
    Edit_RMAfterSale//编辑售后
};




@interface XZXReturnMoneyTVC : XHBaseViewController

@property (nonatomic,strong)XZXOrderDetailModel *DetailModel;//订单详情(需要orderId/money/shippingFee)
@property (nonatomic,strong)XZXMineOrderGoodDetailModel *goodmodel;//订单中的商品详情
@property (nonatomic,copy)void (^Finish)(void);
@property (nonatomic,assign)NSInteger tag;//售后类型
@property (nonatomic,assign)NSInteger RMVC_Type;//编辑or新增加
@property (nonatomic,strong)NSMutableDictionary *RMVC_Model;
@property (nonatomic,copy)NSString *refund_id;//修改售后需要售后订单ID

@end
