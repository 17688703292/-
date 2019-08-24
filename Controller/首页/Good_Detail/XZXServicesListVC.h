//
//  XZXServicesListVC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXServicesListVC : XHBaseViewController
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)Delect_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;

@property (nonatomic,strong)NSArray *dataSource;
@end

NS_ASSUME_NONNULL_END
