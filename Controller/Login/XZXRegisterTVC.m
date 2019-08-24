//
//  XZXRegisterTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXRegisterTVC.h"
#import "XZXTextField.h"
#import "XHBaseNavigationController.h"
#import "CSScanVC.h"
#import "XZXfrogetVC.h"
#import "XZXWebViewController.h"

@interface XZXRegisterTVC ()<UITextFieldDelegate>

@end

@implementation XZXRegisterTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.accountTF creatLeftTitle: @"手机号码"];
    [self.verifyCodeTF creatLeftTitle:@"验证码"];
    [self.userName creatLeftTitle:@"姓名"];
    [self.userIDCard creatLeftTitle:@"账号"];
    [self.passwordTF creatLeftTitle:@"密码"];
    [self.Invitation creatLeftTitle:@"邀请码"];
    self.Invitation.delegate = self;
    self.Invitation.placeholder = @"可扫描用户二维码（选填）";
    self.title = @"注册";
    
    UITapGestureRecognizer *tap_scan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ScanCode)];
    [self.InvitationImage addGestureRecognizer:tap_scan];
    self.InvitationImage.userInteractionEnabled = YES;


    self.protocolBtn.selected = false;
    self.protocolStr.attributedText = [NSString changestringArray:@[@"同意云端至上商城的",@"《用户协议》"] colorArray:@[[UIColor blackColor],kThemeColor] fontArray:@[@"15.0",@"14.0"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewProtocol)];
    [self.protocolStr addGestureRecognizer:tap];
    self.protocolStr.userInteractionEnabled = YES;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return 150;
    }
    
    return 70;
}


- (IBAction)Done_Action:(id)sender {
    
    //注册、修改密码
    
    
    if ([self.accountTF.text length] > 0 &&
        [self.verifyCodeTF.text length] > 0 &&
        [self.passwordTF.text length] > 0 &&
        [self.userName.text length] > 0 &&
        [self.userIDCard.text length] > 0) {
        
        if (self.protocolBtn.isSelected == false) {
            [MBProgressHUD xh_showHudWithMessage:@"使用功能需要您先同意用户协议" toView:self.view completion:^{
                
            }];
            return;
        }

            if ([XHTools validateMobile:self.accountTF.text] == YES) {
                
                [XHNetworking xh_postWithSuccess:@"yunshop/sign" parameters:@{@"memberName":@"",@"memberEmail":@"qq@qq.com",@"memberPasswd":self.passwordTF.text,@"memberMobile":self.accountTF.text,@"inviterId":self.Invitation.text,@"code":self.verifyCodeTF.text,@"memberTruename":self.userName.text,@"memberIdCard":self.userIDCard.text} success:^(XHResponse *responseObject) {
                    
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.Invitation]) {
        
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

-(void)ViewProtocol{
    
    XZXWebViewController *webView = [XZXWebViewController new];
    webView.url = @"http://www.ydmall.xyz/home/user_service_protocol";
    webView.TopTitle = @"协议说明";
    webView.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:webView animated:YES];
    
    
    //    XZXProtocolVC *vc = kStoryboradController(@"Login", @"XZXProtocolVCID");
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)protocol_Action:(id)sender {
      self.protocolBtn.selected = !self.protocolBtn.isSelected;
}
@end
