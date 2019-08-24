//
//  XZXTransportTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXTransportTVC.h"
#import "XZXTransportCell.h"
#import "XZXTransportlistCell.h"
@interface XZXTransportTVC ()

@property (nonatomic,strong) XZXTransport_AboutMessagModel *AboutMessagModel;

@end

@implementation XZXTransport_AboutMessagModel


@end

@implementation XZXTransportModel


@end

@implementation XZXTransportTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXTransportCell" bundle:nil] forCellReuseIdentifier:@"XZXTransportCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXTransportlistCell" bundle:nil] forCellReuseIdentifier:@"XZXTransportlistCellID"];
    [self GetInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"orders/selectOrderExpress" parameters:@{@"orderId":self.order_num,@"member_id":@(kUser.member_id),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        self.AboutMessagModel = [XZXTransport_AboutMessagModel yy_modelWithJSON:responseObject.data];
    
        if ([[responseObject.data valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in [responseObject.data valueForKey:@"data"]) {
                
                [self.dataArray addObject:[XZXTransportModel yy_modelWithJSON:dic]];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.dataArray.count == 0) {
            return 0;
        }
        return 1;
    }
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        XZXTransportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXTransportCellID" forIndexPath:indexPath];
        if (self.order_statu != 40) {
            
            cell.statu.attributedText = [NSString changestringArray:@[@"物流状态：",@"运输中"] colorArray:@[[UIColor blackColor],kThemeColor] fontArray:@[@"17.0",@"20.0"]];
        }else{
            cell.statu.attributedText = [NSString changestringArray:@[@"物流状态：",@"已签收"] colorArray:@[[UIColor blackColor],kThemeColor] fontArray:@[@"17.0",@"20.0"]];
        }
       
        cell.companyName.text    =  [NSString stringWithFormat:@"物流公司：%@",self.AboutMessagModel.expressName];
        cell.companyid.text      =  [NSString stringWithFormat:@"运单编号：%@",self.AboutMessagModel.expressNum];
        cell.companyPhone.hidden = YES;
        return cell;
    }else{
        
        XZXTransportlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXTransportlistCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Image.highlighted = false;
        XZXTransportModel *Model = self.dataArray[indexPath.row];
        cell.Adress.text = Model.context;
        cell.time.text = Model.time;
        
        if (indexPath.row == 0) {
            cell.Adress.textColor = kThemeColor;
            cell.time.textColor =  kThemeColor;
            cell.Image.backgroundColor = kThemeColor;
           
            
        }else{
            cell.Adress.textColor = [UIColor blackColor];
            cell.time.textColor   = [UIColor blackColor];
            cell.Image.backgroundColor = [UIColor grayColor];
            
           
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 100;
    }else{
        
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
@end
