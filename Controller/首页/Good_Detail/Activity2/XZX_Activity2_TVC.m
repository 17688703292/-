//
//  XZX_Activity2_TVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_Activity2_TVC.h"

#import "XZXHom_AdvertisementCell.h"
#import "XZXHome_Activity2List_TC.h"

#import "Activity2Model.h"
#import "XZXHome_AdvModel.h"
#import "XZX_GoodDetail_CommonTV.h"

@interface XZX_Activity2_TVC ()<XZXHom_AdvertisementCellDelegate>
@property (nonatomic,strong)Activity2Model *MyModel;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger ServiceReturn_total;

@end

@implementation XZX_Activity2_TVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = self.toptitle;
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHom_AdvertisementCell" bundle:nil] forCellReuseIdentifier:@"XZXHom_AdvertisementCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHome_Activity2List_TC" bundle:nil] forCellReuseIdentifier:@"XZXHome_Activity2List_TCID"];
    self.tableView.bounces = false;
    self.tableView.tableFooterView = [UIView new];
    
    
    [self AddReturnTopBtnIconImageName:@"zhiding" frame:CGRectMake(kScreenWidth*0.8, kScreenHeight*0.8, 50, 50) blcok:^{
        
        
    }];
    __weak typeof(self) weakSelf = self;
    self.Begain = ^{
        if(weakSelf.MyModel.goods.count > 0){
            
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    };
    
    [self ManualRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.ReturnTopBtn.hidden = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.ReturnTopBtn.hidden = true;
}

-(void)ManualRefresh{
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [self GetInformation];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.ServiceReturn_total > self.MyModel.goods.count) {
            
            ++ self.page;
            [self GetInformation];
        }else{
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    }];
    
}

-(void)GetInformation{
    
    
    [XHNetworking xh_postWithoutSuccess:@"homePage/getPlatFormActivity" parameters:@{@"activityType":self.activityType,@"page":@(self.page)} success:^(XHResponse *responseObject) {
       
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.ServiceReturn_total = [[responseObject.data valueForKey:@"count"] integerValue];
        if (self.page == 1) {
            
            self.MyModel = [Activity2Model yy_modelWithJSON:responseObject.data];
           
        }else{
            
            for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {
                [self.MyModel.goods addObject:[XZXHome_goodModel yy_modelWithJSON:dic]];
            }
        }
        if (self.MyModel.goods.count >= self.ServiceReturn_total) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
       
    }];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return  kScreenWidth*0.4;
    }else{
        
        return 120;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 1;
    }
    return self.MyModel.goods.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        XZXHom_AdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHom_AdvertisementCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.Adv_height = kScreenWidth*0.4;
        [cell.dataSourceUrl removeAllObjects];
        [cell.dataSourceLink removeAllObjects];
        [cell.dataSourceTitle removeAllObjects];
        
        for (XZXHome_AdvModel *AdvModel in self.MyModel.imageList) {

            [cell.dataSourceUrl addObject:kImageUrl(@"",AdvModel.activityImage)];
           // [cell.dataSourceLink addObject:AdvModel.activityId];

        }
        cell.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        cell.cycleScrollview.clipsToBounds = true;
        cell.cycleScrollview.imageURLStringsGroup = cell.dataSourceUrl;
        cell.cycleScrollview.titlesGroup = cell.dataSourceTitle;
        
        return cell;
    }else{
        
        XZXHome_Activity2List_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity2List_TCID" forIndexPath:indexPath];
        cell.MyModel = [self.MyModel.goods objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    XZXHome_goodModel *Model = [self.MyModel.goods objectAtIndex:indexPath.row];
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = Model.goodsId;
    TV.VC_type = GoodDetail_CommonTV;
    [self.navigationController pushViewController:TV animated:YES];
}
@end
