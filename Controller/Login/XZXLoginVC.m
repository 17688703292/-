//
//  XZXLoginVC.m
//  Slumbers
//
//  Created by zhu on 2018/11/29.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XZXLoginVC.h"
#import "XZXRegisterTVC.h"
#import "XZXRegisterVC.h"
#import "XZXTextField.h"

#import "XZXWebViewController.h"

@interface XZXLoginVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTop;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet XZXTextField *accountTF;
@property (weak, nonatomic) IBOutlet XZXTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *ProtocolBtn;
- (IBAction)Protocol_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ProtocolStr;

@end

@implementation XZXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupSubViews {
    
    self.logoTop.constant = kSafeAreaTop(self.view);
    self.loginButton.cornerRadius = 4;
    self.registerButton.cornerRadius = 4;
    self.title = @"登录";
    self.accountTF.iconName = @"zhuanghu";
    self.passwordTF.iconName = @"mima";
    self.accountTF.text = kUser.account;
    
    
    
    
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"];
    
    if (!isFirst) {
        
      
        self.ProtocolBtn.selected = false;
    } else {
        
    
        self.ProtocolBtn.selected = true;
    }
    
    
    self.ProtocolStr.attributedText = [NSString changestringArray:@[@"同意云端至上商城的",@"《用户协议》"] colorArray:@[[UIColor blackColor],kThemeColor] fontArray:@[@"15.0",@"14.0"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewProtocol)];
    [self.ProtocolStr addGestureRecognizer:tap];
    self.ProtocolStr.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (IBAction)clickedLoginButton:(id)sender {
    
    
  
//    
//    [kAppDelegate  saveUserInformation:@{@"token":@"123",@"userId":@"1",@"discount":@"1",@"account":@"1"}];
//    [kAppDelegate GetUserInformation];
//    [kAppDelegate initRootViewController];
//    
//    return;
//
    
   
    if ([self.passwordTF.text length] > 0 &&
        [self.accountTF.text length] > 0) {
     
        if (self.ProtocolBtn.isSelected == false) {
            [MBProgressHUD xh_showHudWithMessage:@"使用功能需要您先同意用户协议" toView:self.view completion:^{
                
            }];
            return;
        }
        NSDictionary *parameters = [NSDictionary dictionary];
        if ([self.accountTF.text length] >= 15) {
            //身份证
            parameters = @{@"userId":@(kUser.member_id),@"memberIdCard":self.accountTF.text,@"memberPasswd":self.passwordTF.text,@"memberMobile":@""};
        }else{
            
            parameters = @{@"memberMobile":self.accountTF.text,@"memberPasswd":self.passwordTF.text,@"memberIdCard":@""};
        }
        
        [XHNetworking xh_postWithSuccess:@"yunshop/login" parameters:parameters success:^(XHResponse *responseObject) {
            
            if (responseObject.code == 200) {
            
                
                [kAppDelegate  saveUserInformation:responseObject.data];
                [kAppDelegate GetUserInformation];
                [kAppDelegate initRootViewController];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadIntroducePic" object:nil];
                //首次登录后记住状态
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isFirst"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
    }
}

- (IBAction)clickedForgetButton:(id)sender {
    
    XZXRegisterVC *vc = kStoryboradController(@"Login", @"XZXRegisterVCID");
    vc.type = XZXCommonVCTypeFroget;
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)clickedRegisterButton:(id)sender {
    
    XZXRegisterTVC *vc = kStoryboradController(@"Login", @"XZXRegisterTVCID");
    //vc.type = XZXCommonVCTypeRegister;
    [self.navigationController pushViewController:vc animated:true];
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

- (IBAction)Protocol_Action:(id)sender {

    self.ProtocolBtn.selected = !self.ProtocolBtn.isSelected;
}
@end
