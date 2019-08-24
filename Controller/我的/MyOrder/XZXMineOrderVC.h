//
//  XZXMineOrderVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "WMPageController.h"
typedef NS_ENUM(NSInteger,MineOrderVCTag) {
    
    //    AllOrder_VC        = 6,
    //    WattingPayment_VC  = 0,
    //    WattingSend_VC     = 1,
    //    WattingReceive_VC  = 2,
    //    Finish_VC          = 3,
    //    Cancel_VC          = 4,
    //    Aftersale          = 5
    AllOrder_VC        ,
    WattingPayment_VC  ,
    WattingSend_VC     ,
    WattingReceive_VC  ,
    Finish_VC          ,
    Aftersale
};
@interface XZXMineOrderVC : WMPageController


@end
