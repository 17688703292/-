//
//  XZXWattingReceiveTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXWattingReceiveTVC.h"

@interface XZXWattingReceiveTVC ()

@end

@implementation XZXWattingReceiveTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    self.index = WattingReceiveBase;
     self.page = 1;
    [self Orderlist_GetInformation:WattingReceiveBase];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
