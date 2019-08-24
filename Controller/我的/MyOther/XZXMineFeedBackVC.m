//
//  XZXMineFeedBackVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineFeedBackVC.h"

@implementation XZXMineFeedBackVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.textField.placeholder = @"请输入内容";
}

- (IBAction)upload_Action:(id)sender {
    
    if ([self.textField.text length] != 0) {
     
  
        [XHNetworking xh_postWithoutSuccess:@"complain/addComplain" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"accuserId":@(kUser.member_id),@"appealMessage":self.textField.text} success:^(XHResponse *responseObject) {
            
            if (responseObject.code == 200) {
                [MBProgressHUD xh_showHudWithMessage:@"您的投诉/建议我们已成功接收" toView:self.view completion:^{
                   
                       [self.navigationController popViewControllerAnimated:YES];
                }];
            
            }
        }];
    }
}
@end
