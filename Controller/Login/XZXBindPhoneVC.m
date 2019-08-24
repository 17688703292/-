//
//  XZXBindPhoneVC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXBindPhoneVC.h"

@interface XZXBindPhoneVC ()

@end

@implementation XZXBindPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.title = @"绑定手机号";
    [self.telephone creatLeftTitle: @"手机号码"];
    [self.code creatLeftTitle:@"验证码"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setupSubViews {
    
    
    UIButton *verifyButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 120, 35) title:@"获取验证码" font:kFont_Medium titleColor:kWhite inView:nil];
    verifyButton.cornerRadius = 3.0f;
    verifyButton.backgroundColor = kThemeColor;
    [verifyButton xh_touchUpInside:^(UIControl *sender) {
        if ([XHTools validateMobile:self.telephone.text]) {
            
            [XHNetworking xh_postWithSuccess:@"yunshop/identifyingCode" parameters:@{@"memberMobile":self.telephone.text} success:^(XHResponse *responseObject) {
                
                [verifyButton xh_startTime:60 title:@"获取验证码" waitTittle:@"后重新发送"];
            }];
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                
            }];
        }
    }];
    self.code.rightView = verifyButton;
    self.code.rightViewMode = UITextFieldViewModeAlways;
}

- (IBAction)Sure_Action:(id)sender {
    
    if ([self.telephone.text length] > 0 &&
        [self.code.text length] > 0) {
        
        if ([XHTools validateMobile:self.telephone.text] == YES) {
            
            
            [XHNetworking xh_postWithSuccess:@"yunshop/updateMemberPhone" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"memberMobile":self.telephone.text,@"code":self.code.text} success:^(XHResponse *responseObject) {
               
                if (responseObject.code == 200) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                
            }];
        }
        
    }else{
        
        [MBProgressHUD xh_showHudWithMessage:@"请完善账户" toView:self.view completion:^{
            
        }];
    }
}
@end
