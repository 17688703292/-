//
//  XZXMine_ManagerAdressVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMine_ManagerAdressVC.h"
#import "XZXMine_EditAdressTVC.h"

#import "XZXMine_AdressListCell.h"
#import "XZXMine_ManagerAdressFootView.h"

#import "XZXMine_AreaListModel.h"
@interface XZXMine_ManagerAdressVC ()<UITableViewDelegate,UITableViewDataSource,XZXMine_ManagerAdressFootViewDelegate>

@end

@implementation XZXMine_ManagerAdressVC
{
    UITableView *CustomerTableView;
    UIButton *SureBtn;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理收货地址";
    
    
    SureBtn = [[UIButton alloc]init];
    [self.view addSubview:SureBtn];
    [SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(kScreenWidth/5.0*3.0);
    }];
    [SureBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SureBtn setBackgroundColor:kThemeColor];
    SureBtn.layer.masksToBounds = YES;
    SureBtn.layer.cornerRadius  = 25.0f;
    [SureBtn addTarget:self action:@selector(AddNewAdress) forControlEvents:UIControlEventTouchDown];
    
    
    
    
    CustomerTableView = [[UITableView alloc]init];
    [self.view addSubview:CustomerTableView];
    [CustomerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(self->SureBtn.mas_top).offset(-20);
        make.top.mas_equalTo(self.view);
    }];
    CustomerTableView.dataSource = self;
    CustomerTableView.delegate   = self;
    CustomerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    CustomerTableView.backgroundColor = kBackgroundColor;
    [CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_AdressListCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_AdressListCellID"];
    
    

}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AddNewAdress{
    
    XZXMine_EditAdressTVC * TVC = [XZXMine_EditAdressTVC new];
    TVC.type = AddAdress;
    [self.navigationController pushViewController:TVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXMine_AdressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_AdressListCellID" forIndexPath:indexPath];
    XZXMine_AreaListModel *model = self.dataSource[indexPath.section];
    cell.Name.text = model.trueName;
    cell.Telephone.text = model.mobPhone;
    
    cell.AddressTitle.text = [NSString stringWithFormat:@"%@ %@",model.areaInfo,model.address];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *View = [UIView new];
    View.backgroundColor = kBackgroundColor;
    return View;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XZXMine_ManagerAdressFootView *View = [[[NSBundle mainBundle] loadNibNamed:@"XZXMine_ManagerAdressFootView" owner:nil options:nil]firstObject];
    View.delegate = self;
       XZXMine_AreaListModel *model = self.dataSource[section];
    View.tag = section;
    if (model.status == 1) {
        
        View.SelctAddress_Btn.selected = true;
    }else{
        
        View.SelctAddress_Btn.selected = false;
    }
    
    return View;
}


#pragma mark XZXMine_ManagerAdressFootViewDelegate

//设置默认地址
-(void)SelectAddress_Action:(XZXMine_ManagerAdressFootView *)View{
  

    XZXMine_AreaListModel *Areamodel = self.dataSource[View.tag];
   
    if (Areamodel.status == 1) {
        return;
    }
   
    
    [XHNetworking xh_postWithSuccess:@"address/updateAddress" parameters:@{@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"token":kUser.token,@"addressId":@(Areamodel.addressId),@"trueName":Areamodel.trueName,@"cityId":@(Areamodel.cityId ),@"areaId":@(Areamodel.areaId ),@"adress":Areamodel.address,@"areaInfo":Areamodel.areaInfo,@"telPhone":Areamodel.mobPhone,@"mobPhone":Areamodel.mobPhone,@"isDefault":@(Areamodel.status == 0 ? 1 : 0)} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            
            for (XZXMine_AreaListModel *Tempmodel in self.dataSource) {
                if (Tempmodel.addressId == Areamodel.addressId) {
                    
                    Tempmodel.status = 1;
                }else{
                    
                    Tempmodel.status = 0;
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->CustomerTableView reloadData];
            });
        }
    }];
    

}

-(void)EditAddress_Action:(XZXMine_ManagerAdressFootView *)View{
   
    XZXMine_EditAdressTVC * TVC = [XZXMine_EditAdressTVC new];
    TVC.type = EditAdress;
    TVC.Areamodel = self.dataSource[View.tag];
    
    TVC.EditAdressBlock = ^(XZXMine_AreaListModel *model, NSInteger tag) {
      
        //1、更新本条地址 2、本条地主选为默认，其余默认取消
        [self.dataSource replaceObjectAtIndex:tag withObject:model];
        if (model.status == 1) {
            
            for (XZXMine_AreaListModel *Tempmodel in self.dataSource) {
                if (Tempmodel.addressId == model.addressId) {
                    
                    Tempmodel.status = 1;
                }else{
                    
                    Tempmodel.status = 0;
                }
            }
        }
        
        [self->CustomerTableView reloadData];
    };
    [self.navigationController pushViewController:TVC animated:YES];
}

-(void)DelectAdress_Action:(XZXMine_ManagerAdressFootView *)View{
    UIAlertController *alertAC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除此条地址" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
           XZXMine_AreaListModel *model = self.dataSource[View.tag];
        
        
        [XHNetworking xh_postWithSuccess:@"address/deleteAddress" parameters:@{@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"token":kUser.token,@"addressId":@(model.addressId)} success:^(XHResponse *responseObject) {
            
            if (responseObject.code == 200) {
             
                [self.dataSource removeObject:model];
                [self->CustomerTableView reloadData];
            }
        }];
    }];
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertAC addAction:Sure];
    [alertAC addAction:Cancel];
    
    [self presentViewController:alertAC animated:YES completion:^{
        
    }];
}


@end
