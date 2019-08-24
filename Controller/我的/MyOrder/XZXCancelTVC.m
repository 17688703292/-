//
//  XZXCancelTVC.m
//  DoorLock
//
//  Created by RedSky on 2019/3/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXCancelTVC.h"

@interface XZXCancelTVC ()

@end

@implementation XZXCancelTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.navigationItem.title = @"已取消";
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    self.index = CancelBase;
    self.page = 1;
    [self Orderlist_GetInformation:CancelBase];
}
@end
