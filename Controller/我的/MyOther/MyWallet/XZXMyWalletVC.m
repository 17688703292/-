//
//  XZXMyWalletVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/18.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyWalletVC.h"

#import "XZXMyRechargeTVC.h"
#import "XZXMyBankListTVC.h"

@interface XZXMyWalletVC ()
@property (weak, nonatomic) IBOutlet UILabel *AllPrice;
@property (weak, nonatomic) IBOutlet UIButton *RechargeBtn;
- (IBAction)Recharge_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Withdrawal;
- (IBAction)Withdrawal_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *AddBankBtn;
- (IBAction)AddBank_Action:(id)sender;
@end

@implementation XZXMyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"钱包";
    self.RechargeBtn.cornerRadius = 15.0f;
    self.Withdrawal.cornerRadius  = 15.0f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Recharge_Action:(id)sender {
    XZXMyRechargeTVC *TVC = kStoryboradController(@"Bank", @"XZXMyRechargeTVCID");
    [self.navigationController pushViewController:TVC animated:YES];
    
}

- (IBAction)Withdrawal_Action:(id)sender {
    XZXMyRechargeTVC *TVC = kStoryboradController(@"Bank", @"XZXMyRechargeTVCID");
    [self.navigationController pushViewController:TVC animated:YES];
    
}


- (IBAction)AddBank_Action:(id)sender {
    XZXMyBankListTVC *TVC = kStoryboradController(@"Bank", @"XZXMyBankListTVCID");
    [self.navigationController pushViewController:TVC animated:YES];
    
}
@end
