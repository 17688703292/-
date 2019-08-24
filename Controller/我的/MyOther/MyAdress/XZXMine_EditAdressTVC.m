//
//  XZXMine_EditAdressTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMine_EditAdressTVC.h"
#import "XZX_GoodDetail_CommonTV.h"

#import "XZXMine_EditAdress_SelectArea.h"
#import "XZXShopCarListVC.h"
#import "XZXMine_AdressListTVC.h"


//cell
#import "XZX_SignalTextField_TC.h"
#import "XZX_SetDefaultAdress_TC.h"

#import "XZXMine_EditAdress_SelectAreaModel.h"

@interface XZXMine_EditAdressTVC ()<UITextFieldDelegate,XZX_SetDefaultAdressDelegate,XZX_SignalTextField_Delegate>

@property (nonatomic,strong)NSMutableArray *dataSource_SelectArea;//选中的省市区
@end

@implementation XZXMine_EditAdressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XZX_SignalTextField_TC" bundle:nil] forCellReuseIdentifier:@"XZX_SignalTextField_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZX_SetDefaultAdress_TC" bundle:nil] forCellReuseIdentifier:@"XZX_SetDefaultAdress_TCID"];
    
    if (self.type == EditAdress) {
        
        self.navigationItem.title = @"编辑地址";

        [self.tableView reloadData];
    }else{
     
        self.navigationItem.title = @"新增地址";
        self.Areamodel = [XZXMine_AreaListModel new];
        self.Areamodel.trueName = @"";
        self.Areamodel.telPhone = @"";
        self.Areamodel.address = @"";
        self.Areamodel.areaInfo = @"";
        self.Areamodel.status  = 0;
    }
    
    [self addRightItemWithTitle:@"保存" titleColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataSource_SelectArea{
    
    if (!_dataSource_SelectArea) {
        _dataSource_SelectArea = [NSMutableArray array];
    }
    return _dataSource_SelectArea;
}

-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    if (self.type == AddAdressForOrder) {
        
        for (UIViewController *VC in self.navigationController.viewControllers) {
            if ([VC isKindOfClass:[XZX_GoodDetail_CommonTV class]]) {
                
                [self.navigationController popToViewController:VC animated:YES];
            }else if([VC isKindOfClass:[XZXShopCarListVC class]]){
                
                [self.navigationController popToViewController:VC animated:YES];
            }
        }
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 4;
    }else{
        if (self.type == EditAdress) {
            return 1;
        }
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ||
            indexPath.row == 1 ||
            indexPath.row == 3) {
            
            XZX_SignalTextField_TC *TC = [tableView dequeueReusableCellWithIdentifier:@"XZX_SignalTextField_TCID" forIndexPath:indexPath];
            TC.Input_Message.tag = indexPath.row;
             TC.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.type == EditAdress) {
                
                if (indexPath.row == 0) {
                    TC.Input_Message.placeholder = self.Areamodel.trueName;
                }else if (indexPath.row == 1){
                    
                    TC.Input_Message.placeholder = self.Areamodel.mobPhone;
                }else if (indexPath.row == 3){
                    
                    TC.Input_Message.placeholder = self.Areamodel.address;
                }
            }else{
                
                if (indexPath.row == 0) {
                    TC.Input_Message.placeholder = @"请输入收货人姓名";
                }else if (indexPath.row == 1){
                    
                    TC.Input_Message.placeholder = @"请输入收货人联系电话";
                }else if (indexPath.row == 3){
                    
                    TC.Input_Message.placeholder = @"请输入详细收货地址";
                }
            }
            TC.delegate = self;
            return TC;
        }else{
         
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [self.Areamodel.areaInfo length] != 0 ? self.Areamodel.areaInfo : @"所在地区（请选择）";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        
        XZX_SetDefaultAdress_TC *TC = [tableView dequeueReusableCellWithIdentifier:@"XZX_SetDefaultAdress_TCID" forIndexPath:indexPath];
        TC.delegate = self;
        TC.DefaultAddress_IsOn.on = self.Areamodel.status == 1?YES:NO;
        TC.DefaultAddress_IsOn.userInteractionEnabled = true;
        TC.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.type == AddAdress) {
            TC.DefaultAddress_IsOn.userInteractionEnabled = false;
        }
        return TC;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
         [self SelectAdress];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [UIView new];
    view.backgroundColor = kBackgroundColor;
    return view;
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
 
    

    
    if ([self.Areamodel.trueName length] == 0 ||
        [self.Areamodel.mobPhone length] == 0 ||
        [self.Areamodel.areaInfo length] == 0 ||
        [self.Areamodel.address length] == 0 ||
        [self.Areamodel.address isEqualToString:@"所在地区"]) {
    
        
        [MBProgressHUD xh_showHudWithMessage:@"请将地址信息填写完整" toView:self.view completion:^{
            
        }];
        return;
    }
    
    if ([XHTools validateMobile:self.Areamodel.mobPhone] == false) {
        
        [MBProgressHUD xh_showHudWithMessage:@"电话不正确" toView:self.view completion:^{
            
        }];
        return;
    }

    NSInteger proviceID = 0;


    if (self.dataSource_SelectArea.count > 0) {
        proviceID = ((XZXMine_EditAdress_SelectAreaModel *)self.dataSource_SelectArea[0]).areaId;
    }
    
    if (self.dataSource_SelectArea.count > 1){
        
        self.Areamodel.cityId = ((XZXMine_EditAdress_SelectAreaModel *)self.dataSource_SelectArea[1]).areaId;
    }
    
    if (self.dataSource_SelectArea.count >2){
        
        self.Areamodel.areaId = ((XZXMine_EditAdress_SelectAreaModel *)self.dataSource_SelectArea[2]).areaId;
    }
    
    
    if (self.type == EditAdress) {

        
        [XHNetworking xh_postWithSuccess:@"address/updateAddress" parameters:@{@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"token":kUser.token,@"addressId":@(self.Areamodel.addressId),@"trueName":self.Areamodel.trueName,@"cityId":@( self.Areamodel.cityId ),@"areaId":@(self.Areamodel.areaId),@"areaInfo":self.Areamodel.areaInfo,@"address":self.Areamodel.address,@"telPhone":self.Areamodel.mobPhone,@"mobPhone":self.Areamodel.mobPhone,@"isDefault":@(self.Areamodel.status)} success:^(XHResponse *responseObject) {
            
            if (responseObject.code == 200) {
                
                
                //回到地址列表
                for (UIViewController *VC in self.navigationController.viewControllers) {
                    if ([VC isKindOfClass:[XZXMine_AdressListTVC class]]) {
                        [self.navigationController popToViewController:VC animated:YES];
                    }
                }
            }
        }];
    }else{
        
     
    
        [XHNetworking xh_postWithSuccess:@"address/insertAddress" parameters:@{@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"token":kUser.token,@"trueName":self.Areamodel.trueName,@"cityId":@( self.Areamodel.cityId ),@"areaId":@(self.Areamodel.areaId ),@"areaInfo":self.Areamodel.areaInfo,@"address":self.Areamodel.address,@"telPhone":self.Areamodel.mobPhone,@"mobPhone":self.Areamodel.mobPhone,@"isDefault":@(self.Areamodel.status)} success:^(XHResponse *responseObject) {
            
            if (responseObject.code == 200) {
                
   
                    
                 
                    if (self.type == AddAdressForOrder) {
                        [self.navigationController popViewControllerAnimated:YES];
                        if (self.AddAdressForOrderBlock) {
                            self.AddAdressForOrderBlock();
                        }
                    }else{
                        
                        //回到地址列表
                        for (UIViewController *VC in self.navigationController.viewControllers) {
                            if ([VC isKindOfClass:[XZXMine_AdressListTVC class]]) {
                                [self.navigationController popToViewController:VC animated:YES];
                            }
                        }
                    }
                }
        }];
    }

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
 
    return YES;
}



-(void)SelectAdress{
    
    XZXMine_EditAdress_SelectArea *VC = [XZXMine_EditAdress_SelectArea new];

    [VC  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    VC.SelectArea = ^(NSString * _Nonnull adress, NSMutableArray * _Nonnull adress_array) {
        
        self.dataSource_SelectArea = adress_array;
        self.Areamodel.areaInfo = adress;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };

    
    [self presentViewController:VC animated:YES completion:^{
        
    }];
}

-(void)SwitchAction_XZX_SetDefaultAdress_TC:(BOOL)IsDefault{
    
    self.Areamodel.status = IsDefault == YES ? 1 : 0;
}

-(void)Input_Message_SignalTextField_Delegate:(NSInteger)tag TextField:(nonnull NSString *)Str{
    
    switch (tag) {
        case 0:
            {
                self.Areamodel.trueName = Str;
            }
            break;
        case 1:
        {
            self.Areamodel.mobPhone = Str;
        }
            break;
        case 3:
        {
            self.Areamodel.address = Str;
        }
            break;
        default:
            break;
    }
}

@end
