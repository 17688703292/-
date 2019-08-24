//
//  XZXMine_AdressListTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMine_AdressListTVC.h"
#import "XZXMine_ManagerAdressVC.h"

#import "XZXMine_AdressListCell.h"


@interface XZXMine_AdressListTVC ()

@end

@implementation XZXMine_AdressListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMine_AdressListCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_AdressListCellID"];
    [self addRightItemWithTitle:@"管理" titleColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self GetInformation];
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"address/selectByAll" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
    
        if (responseObject.code == 200) {
            [self.dataArray removeAllObjects];
         
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
       
            for (NSDictionary *AdressDic in responseObject.data) {
        
                XZXMine_AreaListModel *model = [XZXMine_AreaListModel yy_modelWithJSON:AdressDic];
                 model.status = model.isDefault;
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXMine_AdressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_AdressListCellID" forIndexPath:indexPath];
    XZXMine_AreaListModel *model = self.dataArray[indexPath.section];
    cell.Name.text = model.trueName;
    cell.Telephone.text = model.mobPhone;
    
    if (model.status == 1) {
        
       
        NSString *changeText = @"【默认地址】";
        
        NSString *string = [NSString stringWithFormat:@" %@ %@ %@",changeText,model.areaInfo,model.address];
      
        NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:string];
        [AttributedString addAttribute:NSForegroundColorAttributeName value:kThemeColor range:NSMakeRange(0, [changeText length])];
        [AttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange([changeText length],[model.address length])];
        
        cell.AddressTitle.attributedText = AttributedString;
    
    }else{
        
        cell.AddressTitle.text = [NSString stringWithFormat:@" %@ %@",model.areaInfo,model.address];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.ChangeAddressInOrder) {
        
        [self.navigationController popViewControllerAnimated:YES];
        self.ChangeAddressInOrder(self.dataArray[indexPath.section]);
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *View = [UIView new];
    View.backgroundColor = kBackgroundColor;
    return View;
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    XZXMine_ManagerAdressVC *VC = [XZXMine_ManagerAdressVC new];
    VC.hidesBottomBarWhenPushed = YES;
    VC.dataSource = self.dataArray;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
