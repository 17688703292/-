//
//  XZXTransportTVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseTableViewController.h"



@interface XZXTransport_AboutMessagModel : NSObject

@property (nonatomic,copy) NSString *expressName;
@property (nonatomic,copy) NSString *expressNum;

@end

@interface XZXTransportModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *ftime;
@property (nonatomic,copy) NSString *context;

@end

@interface XZXTransportTVC : XHBaseTableViewController

@property (nonatomic,assign) NSInteger order_statu;
@property (nonatomic,copy) NSString *order_num;
@end
