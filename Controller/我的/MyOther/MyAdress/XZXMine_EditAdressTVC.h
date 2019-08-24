//
//  XZXMine_EditAdressTVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXMine_AreaListModel.h"
typedef NS_ENUM(NSInteger,EditAdress_Type) {

    EditAdress,//编辑地址
    AddAdress,//添加地址
    AddAdressForOrder//添加地址后下单购买商品
};




@interface XZXMine_EditAdressTVC : XHBaseTableViewController

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) XZXMine_AreaListModel *Areamodel;//选中模型

@property (nonatomic,copy) void(^EditAdressBlock)(XZXMine_AreaListModel *model,NSInteger tag);
@property (nonatomic,copy) void(^AddAdressForOrderBlock)(void);
@end
