//
//  XZXMine_MessageListTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_MessageListTVC.h"

#import "XZXMine_MessageDetailTVC.h"
#import "XZXMessageClassTC.h"
@interface XZXMine_MessageListTVC ()


@end

@implementation XZXMine_MessageListModel


@end

@implementation XZXMine_MessageListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMessageClassTC" bundle:nil] forCellReuseIdentifier:@"XZXMessageClassTCID"];
    self.title = @"消息";
    self.tableView.tableFooterView = [UIView new];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
     [self GetInformation];
}

-(void)GetInformation{
 
    [XHNetworking xh_postWithoutSuccess:@"message/selectMessageByMemberId" parameters:@{@"memberId":@(kUser.member_id),@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {
        
        
        if (responseObject.code == 200 &&
            [responseObject.data isKindOfClass:[NSArray class]]) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in responseObject.data) {
               
                
                [self.dataArray addObject:[XZXMine_MessageListModel yy_modelWithJSON:dic]];
            }
            [self.tableView reloadData];
        }
    }];
}
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XZXMessageClassTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMessageClassTCID" forIndexPath:indexPath];
    XZXMine_MessageListModel *model = [self.dataArray objectAtIndex:indexPath.row];
 
    cell.PointImage.hidden = true;
    if (model.flag == 0) {
        
        cell.PointImage.hidden = false;
    }

    cell.content.numberOfLines = 2;
    NSString *contentStr = [model.content length] > 0 ? [NSString stringWithFormat:@"\n%@",model.content]:@"";
    if ([model.name isEqualToString:@"system"]) {
     
        cell.time.text  = [XHTools ConvertStrToTimeNoday:model.systemTime];
        cell.headImage.image = [UIImage imageNamed:@"xitongxiaoxi"];
        cell.content.attributedText = [NSString changestringArray:@[@"系统消息",contentStr] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"14.0"]];
       
    }else if ([model.name isEqualToString:@"order"]){
      
        
        cell.time.text  = [XHTools ConvertStrToTimeNoday:model.Time];
        cell.headImage.image = [UIImage imageNamed:@"dingdanxiaoxi"];
          cell.content.attributedText = [NSString changestringArray:@[@"订单消息",contentStr] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"14.0"]];

    }else if ([model.name isEqualToString:@"checked"]){
        
        
        cell.time.text  = [XHTools ConvertStrToTimeNoday:model.Time];
        cell.headImage.image = [UIImage imageNamed:@"fenhong"];
          cell.content.attributedText = [NSString changestringArray:@[@"掌柜收米",contentStr] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"14.0"]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXMine_MessageDetailTVC *TVC = [[XZXMine_MessageDetailTVC alloc]initWithNibName:@"XZXMine_MessageDetailTVC" bundle:nil];
     XZXMine_MessageListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.name isEqualToString:@"system"]) {
        
        TVC.Message_type = Message_system;
    }else if ([model.name isEqualToString:@"order"]){
        
        TVC.Message_type = Message_Order;
    }else if ([model.name isEqualToString:@"checked"]){
        
        
        TVC.Message_type = Message_Check;
    }
    [self.navigationController pushViewController:TVC animated:YES];
}

@end
