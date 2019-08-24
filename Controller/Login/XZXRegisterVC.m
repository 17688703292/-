//
//  XZXRegisterVC.m
//  Slumbers
//
//  Created by zhu on 2018/11/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XZXRegisterVC.h"
#import "XZXTextField.h"
#import "XHBaseNavigationController.h"
#import "CSScanVC.h"
#import "XZXfrogetVC.h"

@interface XZXRegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet XZXTextField *accountTF;
@property (weak, nonatomic) IBOutlet XZXTextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet XZXTextField *passwordTF;
@property (weak, nonatomic) IBOutlet XZXTextField *Invitation;//邀请码/确认密码
@property (weak, nonatomic) IBOutlet UIImageView *InvitationImage;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *Password_bottom;
@property (weak, nonatomic) IBOutlet UILabel *Invitation_bottom;


@end

@implementation XZXRegisterVC

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.accountTF creatLeftTitle: @"手机号码"];
    [self.verifyCodeTF creatLeftTitle:@"验证码"];
    [self.passwordTF creatLeftTitle:@"密码"];
   
    self.Invitation.delegate = self;
    
    if (self.type == XZXCommonVCTypeRegister) {
         [self.Invitation creatLeftTitle:@"邀请码"];
        self.Invitation.placeholder = @"可扫描用户二维码（选填）";
        self.title = @"注册";
    }else if (self.type == XZXCommomVCTypeEditPassword){
        
        self.accountTF.text = self.memberPhone;
        [self.Invitation creatLeftTitle:@"输入密码"];
        self.Invitation.placeholder = @"请再次输入密码";
        self.InvitationImage.hidden = YES;
        self.accountTF.userInteractionEnabled = false;
        self.title = @"修改密码";
        self.Invitation.secureTextEntry = YES;
    }else if (self.type == XZXCommomVCTypeEditPayPassword){
        
     
        self.accountTF.text = self.memberPhone;
        [self.Invitation creatLeftTitle:@"输入密码"];
        self.Invitation.placeholder = @"请再次输入密码（必须满足6位）";
        self.InvitationImage.hidden = YES;
        self.accountTF.userInteractionEnabled = false;
        self.title = @"红积分支付密码";
        self.Invitation.secureTextEntry = YES;
        
    }else{
       
        self.Invitation.hidden = YES;
        self.InvitationImage.hidden = YES;
        self.Invitation_bottom.hidden = YES;
        self.passwordTF.hidden = YES;
        self.Password_bottom.hidden = YES;
        
        self.title = @"忘记密码";
    }
   
}

- (void)setupSubViews {
    
    self.doneButton.cornerRadius = 4;
    UIButton *verifyButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 120, 35) title:@"获取验证码" font:kFont_Medium titleColor:kWhite inView:nil];
    verifyButton.cornerRadius = 3.0f;
    verifyButton.backgroundColor = kThemeColor;
    [verifyButton xh_touchUpInside:^(UIControl *sender) {
        if ([XHTools validateMobile:self.accountTF.text]) {
            
            [XHNetworking xh_postWithSuccess:@"yunshop/identifyingCode" parameters:@{@"memberMobile":self.accountTF.text} success:^(XHResponse *responseObject) {
            
                [verifyButton xh_startTime:60 title:@"获取验证码" waitTittle:@"后重新发送"];
            }];
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                
            }];
        }
    }];
    self.verifyCodeTF.rightView = verifyButton;
    self.verifyCodeTF.rightViewMode = UITextFieldViewModeAlways;
}


- (IBAction)clickedDoneButton:(id)sender {

    
    if (self.type == XZXCommonVCTypeFroget) {
        
        //忘记密码
        if ([self.accountTF.text length] > 0 &&
            [self.verifyCodeTF.text length] > 0) {
            
            if ([XHTools validateMobile:self.accountTF.text] == YES) {
               
                XZXfrogetVC *VC = kStoryboradController(@"Login", @"XZXfrogetVCID");
                VC.phoneStr = self.accountTF.text;
                VC.smsCode  = self.verifyCodeTF.text;
                [self.navigationController pushViewController:VC animated:YES];
            }else{
             
                [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                    
                }];
            }
         
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"请完善账户" toView:self.view completion:^{
                
            }];
        }
    
    }else if (self.type == XZXCommomVCTypeEditPayPassword){
       //支付密码设定
        
        if ([self.accountTF.text length] > 0 &&
            [self.verifyCodeTF.text length] > 0 &&
            [self.passwordTF.text length] > 0) {
 
            
            
                if ([self.passwordTF.text isEqualToString:self.Invitation.text] &&
                    [self.passwordTF.text length] != 0) {
                    if ([XHTools validateMobile:self.accountTF.text] == YES) {
                        
                        if ([self.passwordTF.text length] !=6) {
                            
                            [MBProgressHUD xh_showHudWithMessage:@"支付密码长度必须为6位" toView:self.view completion:^{
                                
                            }];
                        }else{
                            
                            [XHNetworking xh_postWithSuccess:@"yunshop/updatePaySecret" parameters:@{@"memberMobile":self.accountTF.text,@"code":self.verifyCodeTF.text,@"memberPaypwd":self.passwordTF.text,@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
                                if (responseObject.code == 200) {
                                    
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }];
                        }
                    }else{
                        
                        [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                            
                        }];
                    }
                }else{
                    
                    [MBProgressHUD xh_showHudWithMessage:@"密码不一致" toView:self.view completion:^{
                        
                    }];
                }
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"请完善账户" toView:self.view completion:^{
                
            }];
        }
        
    }else{
        //注册、修改密码
        
        if ([self.accountTF.text length] > 0 &&
            [self.verifyCodeTF.text length] > 0 &&
            [self.passwordTF.text length] > 0) {
            
            
            if (self.type == XZXCommonVCTypeRegister) {
            
                if ([XHTools validateMobile:self.accountTF.text] == YES) {
                    
                    [XHNetworking xh_postWithSuccess:@"yunshop/sign" parameters:@{@"memberName":@"Customer",@"memberEmail":@"qq@qq.com",@"memberPasswd":self.passwordTF.text,@"memberMobile":self.accountTF.text,@"inviterId":self.Invitation.text,@"code":self.verifyCodeTF.text,@"memberTruename":@"冰火",@"memberIdCard":@"432522199209091977"} success:^(XHResponse *responseObject) {
                        
                        if (responseObject.code == 200) {
                            
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }else{
                    
                    [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                        
                    }];
                }
            }else{
                
                //修改密码
                if ([self.passwordTF.text isEqualToString:self.Invitation.text] &&
                    [self.passwordTF.text length] != 0) {
                if ([XHTools validateMobile:self.accountTF.text] == YES) {
                        
                    [XHNetworking xh_postWithSuccess:@"yunshop/updateSecret" parameters:@{@"memberMobile":self.accountTF.text,@"code":self.verifyCodeTF.text,@"memberPasswd":self.passwordTF.text} success:^(XHResponse *responseObject) {
                        if (responseObject.code == 200) {
                            
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }else{
                    
                    [MBProgressHUD xh_showHudWithMessage:@"手机格式不正确" toView:self.view completion:^{
                        
                    }];
                }
                }else{
                    
                    [MBProgressHUD xh_showHudWithMessage:@"密码不一致" toView:self.view completion:^{
                        
                    }];
                }
            }
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"请完善账户" toView:self.view completion:^{
                
            }];
        }
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.Invitation] && self.type == XZXCommonVCTypeRegister) {
        
        [self.view endEditing:YES];
        [self ScanCode];
        return false;
    
    }
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(void)ScanCode{
    
    CSScanVC *scanVC = [CSScanVC new];
    scanVC.hidesBottomBarWhenPushed = YES;
    scanVC.ScanResult = ^(NSString *ResultCode) {
        
        self.Invitation.text = ResultCode;
        
    };
    [self.navigationController pushViewController:scanVC animated:YES];
}

@end
