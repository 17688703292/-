//
//  XZXMine_MessageDetailTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/4.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_MessageDetailTVC.h"
#import "XZXMessageHeadView.h"
#import "XZXMessageContentTC.h"

@interface XZXMine_MessageDetailTVC ()

@property (nonatomic,strong)XZXMessageHeadView *headView;

@end

@implementation XZXMine_MessageDetailModel


@end

@implementation XZXMine_MessageDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"消息";
    
    if (self.Message_type == Message_system) {
        
        self.title = @"系统消息";
    }else if (self.Message_type == Message_Order){
        
        self.title = @"订单消息";
    }else if (self.Message_type == Message_Check){
        
        
        self.title = @"掌柜收米";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMessageContentTC" bundle:nil] forCellReuseIdentifier:@"XZXMessageContentTCID"];
    self.tableView.backgroundColor = kBackgroundColor;
    [self GetInformation];
}
-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"message/selectMessageDetailByMemberId" parameters:@{@"messageType":@(self.Message_type),@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            

            
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
                
                if ([responseObject.data count] == 0) {
                    
                    [MBProgressHUD xh_showHudWithMessage:@"暂无数据" toView:self.view completion:^{
                        
                    }];
                }else{
                
                    for (NSDictionary *dic in responseObject.data) {
                        
                        [self.dataArray addObject:[XZXMine_MessageDetailModel yy_modelWithJSON:dic]];
                    }
                    [self.tableView reloadData];
                }
            }
        }
    }];
    
    [XHNetworking xh_postWithoutSuccess:@"message/updateMessageToRead" parameters:@{@"toMemberId":@(kUser.member_id),@"messageType":@(self.Message_type),@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {

    }];
}
#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"XZXMessageHeadView" owner:nil options:nil]firstObject];
    self.headView.backgroundColor = kBackgroundColor;
    self.headView.BackVIEW.cornerRadius = 10.0;
    XZXMine_MessageDetailModel *model = [self.dataArray objectAtIndex:section];
    NSString *timeStr  = [model.time isKindOfClass:[NSString class]] ?model.time:@"0";
    self.headView.TIME.text = [XHTools ConvertStrToTimeNoday:timeStr];
    return self.headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    XZXMessageContentTC *Cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMessageContentTCID" forIndexPath:indexPath];
    XZXMine_MessageDetailModel *model = [self.dataArray objectAtIndex:indexPath.section];
    Cell.Content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"\n%@\n",[model.content isKindOfClass:[NSString class]] ?model.content:@""]] colorArray:@[[UIColor blackColor]] fontArray:@[@"15.0"]];
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return Cell;
}


@end
