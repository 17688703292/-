//
//  XZXAfterSale.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXAfterSale.h"

@interface XZXAfterSale ()

@end

@implementation XZXAfterSale

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款/售后";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)viewWillAppear:(BOOL)animated{
    
 
    self.index = AfterSaleBase;
     self.page = 1;
    [self Orderlist_GetInformation:AfterSaleBase];
}

@end
