//
//  XZXMine_personInformationTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_personInformationTVC.h"
#import "CSImagePickerManager.h"
#import "CSTools.h"
#import "XZXRegisterVC.h"
#import "XZXBindPhoneVC.h"


@interface XZXMine_personInformationTVC ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *NickName;
@property (weak, nonatomic) IBOutlet UILabel *Account;
@property (weak, nonatomic) IBOutlet UIImageView *Code;
@property (weak, nonatomic) IBOutlet UIButton *LogOutBtn;
- (IBAction)LogOut_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bindTelephone;


@property (nonatomic, strong) CSImagePickerManager *imageManager;
@property (nonatomic,strong)NSMutableDictionary *Information_person;
@end

@implementation XZXMine_personInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.LogOutBtn.cornerRadius = 20.0f;
    self.headImage.cornerRadius = self.headImage.frame.size.height/2.0;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.MyModel.memberImage] placeholderImage:[UIImage imageNamed:LoadPic]];
    self.Account.text = self.MyModel.idCard;
    self.NickName.text = self.MyModel.memberName;
    self.Code.image = [CSTools creatQRcodeWithInfo:[NSString stringWithFormat:@"%ld",kUser.member_id] withSize:CGSizeMake(kScreenWidth/3.0*2.0, kScreenWidth/3.0*2.0)];
    self.bindTelephone.text = self.MyModel.memberMobile;
    self.Information_person = [NSMutableDictionary dictionary];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        [self TakePhoto];
    }else if (indexPath.row == 2){
        
        [self changeNickName];
    }else if (indexPath.row == 4){
        
        if ([self.MyModel.memberMobile length] > 0) {
      
            XZXRegisterVC *vc = kStoryboradController(@"Login", @"XZXRegisterVCID");
            vc.type = XZXCommomVCTypeEditPassword;
            vc.memberPhone = self.MyModel.memberMobile;
            [self.navigationController pushViewController:vc animated:true];
        
        }else{
            
            [MBProgressHUD xh_showHudWithMessage:@"请先绑定手机号" toView:self.view completion:^{
                
            }];
        }
      
    }else if (indexPath.row == 5){
        
        if ([self.bindTelephone.text length] > 10) {
            
            [MBProgressHUD xh_showHudWithMessage:@"已经绑定手机号" toView:self.view completion:^{
                
            }];
        }else{
            XZXBindPhoneVC *vc = kStoryboradController(@"Login", @"XZXBindPhoneVCID");
      
            [self.navigationController pushViewController:vc animated:true];
            
        }
    }else if (indexPath.row == 6){
        XZXRegisterVC *vc = kStoryboradController(@"Login", @"XZXRegisterVCID");
        vc.type = XZXCommomVCTypeEditPayPassword;
        vc.memberPhone = self.MyModel.memberMobile;
        [self.navigationController pushViewController:vc animated:true];
        
    }
}

-(void)TakePhoto{
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *data1 = [XHTools compressImage:photos[0] toByte:102400];
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject != nil){
                
        
                [self.Information_person setObject:[responseObject.data valueForKey:@"url"] forKey:@"memberAvatar"];
                self.headImage.image = photos[0];
                [self EditMeaasge];
            }
        
        }];
    }];
}

-(void)changeNickName{
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入昵称";
    }];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textfield = ac.textFields[0];
        
        if ([textfield.text length] == 0) {
            
            [MBProgressHUD xh_showHudWithMessage:@"昵称不能为空" toView:self.view completion:^{
                
            }];
            return ;
        }
        [self changenicknameToService:textfield.text];
    }]];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:ac animated:YES completion:^{
        
    }];
}

-(void)changenicknameToService:(NSString *)nickname{
    [self.Information_person setObject:nickname forKey:@"memberName"];
    
    [self EditMeaasge];
}


-(void)EditMeaasge{
    
    [self.Information_person setObject:[NSString stringWithFormat:@"%ld",kUser.member_id] forKey:@"memberId"];
    [self.Information_person setObject:@(kUser.member_id) forKey:@"userId"];
    [self.Information_person setObject:kUser.token forKey:@"token"];
    
    [XHNetworking xh_postWithSuccess:@"yunshop/modifyInformation" parameters:self.Information_person success:^(XHResponse *responseObject) {
        
        self.NickName.text = [self.Information_person valueForKey:@"memberName"];
        [self.tableView reloadData];
    }];
}

- (IBAction)LogOut_Action:(id)sender {
    
    

    [XHNetworking xh_postAlwaysWithResponse:@"yunshop/logout" parameters:@{@"memberId":@(kUser.member_id),@"token":kUser.token,@"userId":@(kUser.member_id)} showIndicator:YES response:^(XHResponse *responseObject) {
       
        [kAppDelegate RemoveUserInformation];
    }];
}
@end
