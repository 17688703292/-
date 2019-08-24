//
//  XZXAllOrderTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXAllOrderTVC.h"

@interface XZXAllOrderTVC ()

@end

@implementation XZXAllOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
     self.index = AllOrderBase;
    self.page = 1;
    [self Orderlist_GetInformation:AllOrderBase];

}

-(void)viewDidAppear:(BOOL)animated{

    
}

@end
