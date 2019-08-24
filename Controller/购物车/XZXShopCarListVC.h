//
//  XZXShopCarListVC.h
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XHBaseViewController.h"


@interface XZXShopCarListVC : XHBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;
@property (weak, nonatomic) IBOutlet UIButton *AllSelectBtn;
- (IBAction)AllSelect_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *SumPrice;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
- (IBAction)Sure_Action:(id)sender;

@end
