//
//  XZXAp_Product_updata.h
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXAp_Product_updata : XHBaseTableViewController
@property (weak, nonatomic) IBOutlet XZXTextField *productNum;
@property (weak, nonatomic) IBOutlet XZXTextField *productNmae;
- (IBAction)Upload_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;


@end

NS_ASSUME_NONNULL_END
