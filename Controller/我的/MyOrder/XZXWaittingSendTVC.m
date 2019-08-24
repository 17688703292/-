//
//  XZXWaittingSendTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXWaittingSendTVC.h"

@interface XZXWaittingSendTVC ()

@end

@implementation XZXWaittingSendTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
   
    self.index = WattingSendBase;
     self.page = 1;
  [self Orderlist_GetInformation:WattingSendBase];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
