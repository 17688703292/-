//
//  XZXMyBindBankVC.m
//  DoorLock
//
//  Created by RedSky on 2019/3/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyBindBankVC.h"

@interface XZXMyBindBankVC ()

@end

@implementation XZXMyBindBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.FinishBtn.cornerRadius = 2.0f;
    self.title = @"添加银行卡";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Finish_Action:(id)sender {
    
    if ([self.Input_name.text length] == 0 &&
        [self.Input_BankNum.text length] == 0) {
     
        
        [XHNetworking xh_postWithSuccess:@"wallet/newCard" parameters:@{@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"cardNum":self.Input_BankNum.text,@"cardName":self.Input_name.text} success:^(XHResponse *responseObject) {
        
            if (self.AddBankCarkSuccess) {
                self.AddBankCarkSuccess();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
}
@end
