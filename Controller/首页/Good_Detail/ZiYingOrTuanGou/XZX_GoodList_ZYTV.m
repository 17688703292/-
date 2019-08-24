//
//  XZX_GoodList_ZYTV.m
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_ZYTV.h"
#import "XZXHome_ProduceListTC.h"
#import "ZYorTg_GoodList_TVC.h"
#import "XZX_GoodDetail_CommonTV.h"

#import "XZXHome_Activity_GoodListModel.h"

@interface XZX_GoodList_ZYTV()<XZXHome_ProduceListTCDelegate,ZYorTg_GoodList_TVCDelegate>

@property (nonatomic,strong)XZXHome_Activity_GoodListModel *MyModel;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger ServiceReturn_total;
@end


@implementation XZX_GoodList_ZY_Model

@end

@implementation XZX_GoodList_TG_Model


@end

@implementation XZX_GoodList_ZYTV


-(void)viewDidLoad{
    [super viewDidLoad];
    if (self.ZYTV_t == ZYTV_TG_t) {
        self.title = @"品牌团购";
    }else if (self.ZYTV_t == ZYTV_ZY_t){
        self.title = @"自营专区";
    }else if (self.ZYTV_t == ZYTV_RM_t){
        self.title = @"热卖专区";
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHome_ProduceListTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_ProduceListTCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZYorTg_GoodList_TVC" bundle:nil] forCellReuseIdentifier:@"ZYorTg_GoodList_TVCID"];
    
  
    [self ManualRefresh];
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
    
    if (self.ZYTV_t == ZYTV_RM_t) {
       
        [XHNetworking xh_postWithoutSuccess:@"homePage/getSelfSupport" parameters:@{@"activityType":self.activityModel.activityType,@"activityId":self.activityModel.activityId,@"page":@(self.page),@"gcId1":self.gcid} success:^(XHResponse *responseObject) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.ServiceReturn_total = [[responseObject.data valueForKey:@"count"] integerValue];
            if (self.page == 1) {
                
                self.MyModel = [XZXHome_Activity_GoodListModel yy_modelWithJSON:responseObject.data];
            }else{
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {
                    [self.MyModel.goods addObject:[XZXHome_Activity_GoodModel yy_modelWithJSON:dic]];
                }
            }
            
            [self.tableView reloadData];
        }];
    }else{
    

        [XHNetworking xh_postWithoutSuccess:@"store/getStore" parameters:@{@"storeId":@"1",@"type":@"1",@"gcId":@"",@"startPrice":@"",@"endPrice":@"",@"page":@(self.page),@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            
            if (responseObject.code == 200 &&
                [responseObject.data isKindOfClass:[NSDictionary class]]) {
                
                
                self.ServiceReturn_total = [[responseObject.data valueForKey:@"count"] integerValue];
                if (self.page == 1) {
                    
                    self.MyModel = [XZXHome_Activity_GoodListModel yy_modelWithJSON:responseObject.data];
                }else{
                    
                    for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {
                        [self.MyModel.goods addObject:[XZXHome_Activity_GoodModel yy_modelWithJSON:dic]];
                    }
                }
                
                [self.tableView reloadData];
                
            }
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return  kScreenWidth/3;
    }else{
        
        return kScreenHeight/6.0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
     
      
        return self.MyModel.goods.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XZXHome_ProduceListTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_ProduceListTCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
       
        [cell.dataSourceUrl removeAllObjects];
        [cell.dataSourceLink removeAllObjects];
        [cell.dataSourceTitle removeAllObjects];
        
        if (self.ZYTV_t == ZYTV_RM_t) {
            
            for (XZXHome_AdvModel *AdvModel in self.MyModel.imageList) {
                
                [cell.dataSourceUrl addObject:AdvModel.activityImage];
                // [cell.dataSourceLink addObject:AdvModel.navigationId];
            }
        }else if (self.ZYTV_t == ZYTV_ZY_t){
            
    
            for (NSDictionary *dic in self.MyModel.storeImages) {
                
                [cell.dataSourceUrl addObject:[dic valueForKey:@"storeImages"]];
                // [cell.dataSourceLink addObject:AdvModel.navigationId];
            }
        }
    
        cell.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        cell.cycleScrollview.clipsToBounds = true;
        cell.cycleScrollview.imageURLStringsGroup = cell.dataSourceUrl;
        cell.cycleScrollview.titlesGroup = cell.dataSourceTitle;
        
        return cell;
    }else{
        ZYorTg_GoodList_TVC *cell = [tableView dequeueReusableCellWithIdentifier:@"ZYorTg_GoodList_TVCID" forIndexPath:indexPath];
        if (self.ZYTV_t == ZYTV_ZY_t || self.ZYTV_t == ZYTV_RM_t) {
            
            [cell.SureBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        }else{
            
            [cell.SureBtn setTitle:@"立即拼团" forState:UIControlStateNormal];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.MyModel = [self.MyModel.goods objectAtIndex:indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXHome_Activity_GoodModel *Model = [self.MyModel.goods objectAtIndex:indexPath.row];
    
    if (self.ZYTV_t == ZYTV_TG_t) {
        self.title = @"品牌团购";
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
        
        TV.VC_type = GoodDetail_TG;
        [self.navigationController pushViewController:TV animated:YES];
    }else if (self.ZYTV_t == ZYTV_ZY_t || self.ZYTV_t == ZYTV_RM_t){
       // self.title = @"自营专区";
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
      
        TV.VC_type = GoodDetail_ZY;
        [self.navigationController pushViewController:TV animated:YES];
    }
    
}

-(void)DidSelectSureBtn:(ZYorTg_GoodList_TVC *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XZXHome_Activity_GoodModel *Model = [self.MyModel.goods objectAtIndex:indexPath.row];
    
    if (self.ZYTV_t == ZYTV_TG_t) {
        self.title = @"品牌团购";
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
        
        TV.VC_type = GoodDetail_TG;
        [self.navigationController pushViewController:TV animated:YES];
    }else if (self.ZYTV_t == ZYTV_ZY_t || self.ZYTV_t == ZYTV_RM_t){
        // self.title = @"自营专区";
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
        
        TV.VC_type = GoodDetail_ZY;
        [self.navigationController pushViewController:TV animated:YES];
    }
}
@end
