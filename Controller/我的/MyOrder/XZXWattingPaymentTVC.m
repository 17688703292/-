//
//  XZXWattingPaymentTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXWattingPaymentTVC.h"
#import "XZXMine_MyOrderCell.h"

@interface XZXWattingPaymentTVC ()

@end

@implementation XZXWattingPaymentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewWillAppear:(BOOL)animated{
    

    self.index = WattingPaymentBase;
     self.page = 1;
    [self Orderlist_GetInformation:WattingPaymentBase];  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
