//
//  XZXfrogetVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXfrogetVC.h"
#import "XZXLoginVC.h"
#import "XZXTextField.h"
@interface XZXfrogetVC ()
@property (weak, nonatomic) IBOutlet XZXTextField *phone;
@property (weak, nonatomic) IBOutlet XZXTextField *password;
@property (weak, nonatomic) IBOutlet XZXTextField *againpassword;
- (IBAction)sure:(id)sender;

@end

@implementation XZXfrogetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
   
    self.phone.userInteractionEnabled = false;
    [self.phone creatLeftTitle:@"手机号码"];
    [self.password creatLeftTitle:@"密码"];
    [self.againpassword creatLeftTitle:@"确认密码"];
    self.phone.text = self.phoneStr;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sure:(id)sender {
    
    if ([self.phone.text length] !=0 &&
        [self.password.text length] !=0 &&
        [self.againpassword.text isEqualToString:self.password.text]) {
        
        [XHNetworking xh_postWithSuccess:@"yunshop/updateSecret" parameters:@{@"memberMobile":self.phoneStr,@"code":self.smsCode,@"memberPasswd":self.password.text} success:^(XHResponse *responseObject) {
           
            if (responseObject.code == 200) {
                for (UIViewController *VC in self.navigationController.viewControllers) {
                 
                    if ([VC isKindOfClass:[XZXLoginVC class]]) {
                        [self.navigationController popToViewController:VC animated:YES];
                    }
                }
            }
        }];
        
    }else{
        
        [MBProgressHUD xh_showHudWithMessage:@"密码不一致" toView:self.view completion:^{
            
        }];
    }

}
@end
