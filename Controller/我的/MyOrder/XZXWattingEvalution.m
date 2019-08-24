//
//  XZXWattingEvalution.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXWattingEvalution.h"

@interface XZXWattingEvalution ()

@end

@implementation XZXWattingEvalution

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    self.index = FinishOrderBase;
    self.page = 1;
    [self Orderlist_GetInformation:FinishOrderBase];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
