//
//  XZX_GoodHistoryList_ZCTV.m
//  BigMarket
//
//  Created by RedSky on 2019/7/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodHistoryList_ZCTV.h"
#import "XZX_GoodDetail_CommonTV.h"

#import "ZC_GoodList1_TC.h"
#import "ZC_GoodList2_TC.h"


@interface XZX_GoodHistoryList_ZCTV ()

@end

@implementation XZX_GoodHistoryList_ZCTV

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
      self.title = @"往期众筹";
      [self.tableView registerNib:[UINib nibWithNibName:@"ZC_GoodList1_TC" bundle:nil] forCellReuseIdentifier:@"ZC_GoodList1_TCID"];
      [self.tableView registerNib:[UINib nibWithNibName:@"ZC_GoodList2_TC" bundle:nil] forCellReuseIdentifier:@"ZC_GoodList2_TCID"];

    [self SetManualRefresh];
}
-(void)SetManualRefresh{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            //先判断数据库是否有第一页的数据，取出来做临时显示。
            [self GetInformation];
        }];
        [self.tableView.mj_header beginRefreshing];
        
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
            //調用此塊時自動進入刷新狀態
            ++self.page;
            [self GetInformation];
        }];
    });
}


-(void)GetInformation{
    
    
    [XHNetworking xh_postWithoutSuccess:@"activitys/getGroupBuySuccess" parameters:@{@"page":@(self.page),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        
        if ([[responseObject.data valueForKey:@"list"] count] == 0) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            [self.tableView.mj_footer endRefreshing];
        }
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        
        for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
            
            [self.dataArray addObject:[XZX_GoodList_ZCModel yy_modelWithJSON:dic]];
        }
        [self.tableView reloadData];
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        
        return 1;
    }
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return kScreenWidth/2.0;
    }
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
      
        ZC_GoodList1_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"ZC_GoodList1_TCID" forIndexPath:indexPath];
        return cell;
    }else{
     
        ZC_GoodList2_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"ZC_GoodList2_TCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.MyModel = [self.dataArray objectAtIndex:indexPath.row];
        [cell.buyBtn setTitle:@"立即查看" forState:UIControlStateNormal];
        [cell.buyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [cell.buyBtn setBackgroundColor:[UIColor whiteColor]];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section != 1) {
        return;
    }
    
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.VC_type = GoodDetail_ZC;
      TV.goodsId = ((XZX_GoodList_ZCModel *)[self.dataArray objectAtIndex:indexPath.row]).goodsCommonid;
    TV.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:TV animated:YES];
}



@end
