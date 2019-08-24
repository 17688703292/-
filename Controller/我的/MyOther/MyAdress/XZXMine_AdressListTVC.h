//
//  XZXMine_AdressListTVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXMine_AreaListModel.h"

typedef NS_ENUM(NSInteger,tag_type) {
    UploadOrder_selectAdress
};

@interface XZXMine_AdressListTVC : XHBaseTableViewController

@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,copy) void(^ChangeAddressInOrder)(XZXMine_AreaListModel *model);
@end
