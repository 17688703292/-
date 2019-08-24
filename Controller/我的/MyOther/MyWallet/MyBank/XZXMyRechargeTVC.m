//
//  XZXMyRechargeTVC.m
//  DoorLock
//
//  Created by RedSky on 2019/3/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyRechargeTVC.h"
#import "XZXMyRechargeSuccessVC.h"

@interface XZXMyRechargeTVC ()
@property (weak, nonatomic) IBOutlet UILabel *CarType;
@property (weak, nonatomic) IBOutlet UIButton *bankNum;
@property (weak, nonatomic) IBOutlet UITextField *InputMoney;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
- (IBAction)Next_Action:(id)sender;

@end

@implementation XZXMyRechargeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"余额充值";
    self.NextBtn.backgroundColor = kThemeColor;
    [self.NextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.NextBtn.cornerRadius = 5.0f;

}

- (IBAction)Next_Action:(id)sender {
    XZXMyRechargeSuccessVC *RechargeSuccess = kStoryboradController(@"Mine", @"XZXMyRechargeSuccessVCID");
    [self.navigationController pushViewController:RechargeSuccess animated:YES];
    
}
@end
