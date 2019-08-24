//
//  XZXMyCollectionVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyCollectionVC.h"
#import "XZX_GoodDetail_CommonTV.h"
#import "XZXStoreVC.h"

#import "XZXMyCollectionTC.h"
#import "XZXMineOrder_TC.h"

@interface XZXMyCollectionVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) NSInteger selectIndex;//选择商品、商店
@property (nonatomic,strong) NSMutableArray *dataArray_good;
@property (nonatomic,strong) NSMutableArray *dataArray_store;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger total_good;
@property (nonatomic,assign) NSInteger total_store;
@end

@implementation XZXMyCollectionModel

@end


@implementation XZXMyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"收藏";
    
    self.BabyBtn.cornerRadius =  22;
    self.StoreBtn.cornerRadius = 22.0f;
    
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMyCollectionTC" bundle:nil] forCellReuseIdentifier:@"XZXMyCollectionTCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMineOrder_TC" bundle:nil] forCellReuseIdentifier:@"XZXMineOrder_TCID"];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.tableFooterView = [UIView new];
    self.selectIndex = 0;
    self.page = 1;
     [self SetManualRefresh];
    [self ReloadUI];
}

-(void)SetManualRefresh{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.CustomerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            //先判断数据库是否有第一页的数据，取出来做临时显示。
            [self GetInformation];
        }];
        [self.CustomerTableView.mj_header beginRefreshing];
        
        
        self.CustomerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
            //調用此塊時自動進入刷新狀態
            if (self.selectIndex == 0) {
              
                if (self.total_good > self.dataArray_good.count) {
                     self.page = self.dataArray_good.count/10 +1;
                  
                   [self GetInformation];
                }else{
                    [MBProgressHUD xh_showHudWithMessage:@"没有更多的数据了" toView:self.view completion:^{
                        
                    }];
                    [self.CustomerTableView.mj_footer endRefreshing];
                }
            }else{
                
               
                 self.page = self.dataArray_store.count/10 +1;
                if (self.total_store > self.dataArray_store.count) {
                    
                   [self GetInformation];
                }else{
                    [MBProgressHUD xh_showHudWithMessage:@"没有更多的数据了" toView:self.view completion:^{
                        
                    }];
                     [self.CustomerTableView.mj_footer endRefreshing];
                }
            }
        }];
    });
}

-(void)GetInformation{
   
    [XHNetworking xh_postWithoutSuccess:@"favorites/allList" parameters:@{@"page":@(self.page),@"userId":@(kUser.member_id),@"token":kUser.token,@"memberId":@(kUser.member_id),@"favType":self.selectIndex == 0 ? @"goods":@"store"} success:^(XHResponse *responseObject) {
       
        [self.CustomerTableView.mj_header endRefreshing];
        [self.CustomerTableView.mj_footer endRefreshing];
        
        if (responseObject.code == 200 &&
            [responseObject.data isKindOfClass:[NSDictionary class]]) {
        
         
            if (self.page == 1) {
                if (self.selectIndex == 0) {
                    
                    [self.dataArray_good removeAllObjects];
                    if ([[responseObject.data allKeys] containsObject:@"count"]) {
                        
                        self.total_good =  [[responseObject.data valueForKey:@"count"] integerValue];
                    }
                }else{
                    
                    [self.dataArray_store removeAllObjects];
                    if ([[responseObject.data allKeys] containsObject:@"count"]) {
                        
                        self.total_store =  [[responseObject.data valueForKey:@"count"] integerValue];
                    }
                }
            }
            
            for (NSDictionary *dic in [responseObject.data valueForKey:@"favorites"]) {
                XZXMyCollectionModel *model = [XZXMyCollectionModel yy_modelWithJSON:dic];
                if (self.selectIndex == 1) {
                    
                    [self.dataArray_store addObject:@{@"HeadImage":@"dianpu_shoucang",@"HeadTitle":model.storeName,@"storeID":model.storeId}];
                    
                }else{
                 
                    [self.dataArray_good addObject:model];
                }
            }
            
            [self.CustomerTableView reloadData];
        }
    }];
}

-(NSMutableArray *)dataArray_good{
    if (!_dataArray_good) {
        _dataArray_good = [NSMutableArray array];
    }
    return _dataArray_good;
}

-(NSMutableArray *)dataArray_store{
    if (!_dataArray_store) {
        _dataArray_store = [NSMutableArray array];
    }
    return _dataArray_store;
}



-(void)ReloadUI{
    
    self.BabyBtn.selected = NO;
    self.StoreBtn.selected = NO;
    self.BabyBtn.backgroundColor = [UIColor clearColor];
    self.StoreBtn.backgroundColor = [UIColor clearColor];
    if (self.selectIndex == 0) {
        
        self.BabyBtn.selected = YES;
        self.BabyBtn.backgroundColor = kThemeColor;
    }else{
        
        self.StoreBtn.selected = YES;
        self.StoreBtn.backgroundColor = kThemeColor;
    }
    
    if (self.selectIndex == 0 && self.dataArray_good.count != 0) {
     
        [self.CustomerTableView reloadData];
    }else if (self.selectIndex == 1 && self.dataArray_store.count != 0){
        
        [self.CustomerTableView reloadData];
    }else{
        
        [self GetInformation];
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectIndex == 0) {
        
        return 110;
    }else{
        
        NSInteger num = self.dataArray_store.count%4 == 0 ? self.dataArray_store.count/4 : self.dataArray_store.count/4 +1 ;
        
        return kScreenWidth/4.0*4.0*0.38*0.7 * num ;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.selectIndex == 0) {
        
        return self.dataArray_good.count;
    }else{
        
        if (self.dataArray_store.count == 0) {
            return 0;
        }
        return 1;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectIndex == 0) {
        
        
        XZXMyCollectionTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyCollectionTCID" forIndexPath:indexPath];
        cell.selected = UITableViewCellSelectionStyleNone;
        XZXMyCollectionModel *model = [self.dataArray_good objectAtIndex:indexPath.row];
        [cell.goodImage sd_setImageWithURL:kImageUrl(model.storeId,model.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.goodName.text =model.goodsName;
        
        if ([model.goodsPromotionType integerValue] == ZhongChou_t) {
         
                    cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@  ",[NSString reviseString:model.goodsPrice]]] colorArray:@[kThemeColor] fontArray:@[@"19.0"]];
        }else if ([model.goodsPromotionType integerValue] == JiFen_t){
            
                cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"积分：%@  +  ",[model.score isKindOfClass:[NSString class]] ? model.score :@"0"],[NSString stringWithFormat:@"¥ %@  ",[NSString reviseString:model.goodsPromotionPrice]]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"19.0",@"15.0"]];
            
        }else{
            
                    cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@  ",[NSString reviseString:model.goodsPrice]],[NSString stringWithFormat:@"   积分：%@",[model.score isKindOfClass:[NSString class]] ? model.score :@"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"19.0",@"15.0"]];
        }
        cell.Time.text = [[model.addTime componentsSeparatedByString:@" "] objectAtIndex:0];
        cell.Time.textColor = [UIColor lightGrayColor];
        return cell;
    }else{
        
        
        XZXMineOrder_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMineOrder_TCID" forIndexPath:indexPath];
        
        cell.model.dataSource = self.dataArray_store;
        cell.Signal_num = 4;
        cell.CustomerCollView.scrollEnabled = false;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.CustomerCollView reloadData];
        cell.didSelectItemAtIndexPathBlock = ^(NSIndexPath * _Nonnull indexPathBlock) {
            
            NSDictionary *dic = [self.dataArray_store objectAtIndex:indexPathBlock.row];
            XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
            VC.hidesBottomBarWhenPushed = YES;
            VC.storeId = [dic valueForKey:@"storeID"];
            [self.navigationController pushViewController:VC animated:YES];
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.selectIndex == 0) {
      XZXMyCollectionModel *Model = [self.dataArray_good objectAtIndex:indexPath.row];
        //根据不同商品类型进入不同商品页面

        if ([Model.goodsPromotionType integerValue] == ZhongChou_t) {
            
            [XHNetworking xh_postWithoutSuccess:@"activitys/getGoodsCommonId" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"goodsId":Model.goodsId} success:^(XHResponse *responseObject) {
                
                
                
                XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
                TV.goodsId = [responseObject.data valueForKey:@"goodsCommonid"];
                TV.VC_type = GoodDetail_ZC;

                [self.navigationController pushViewController:TV animated:YES];
            }];
            
        }else{
            
         
            
            XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
            TV.goodsId = Model.goodsId;
    
       
            
            if ([Model.goodsPromotionType integerValue] == MiaoSha_t) {
                TV.VC_type = GoodDetail_MS;
            }else if ([Model.goodsPromotionType integerValue] == TuanGou_t){
                TV.VC_type = GoodDetail_TG;
            }
            else if ([Model.goodsPromotionType integerValue] == ZhongChou_t){
                
                TV.VC_type = GoodDetail_ZC;
            }else if ([Model.goodsPromotionType integerValue] == ReMai_t){
                
                TV.VC_type = GoodDetail_CommonTV;
            }else if ([Model.goodsPromotionType integerValue] == JiFen_t){
                
                TV.VC_type = GoodDetail_JF;
                TV.VC_type = GoodDetail_JF;
                TV.JF_type = [Model.goodsPromotionType floatValue] ==0 ? 3 : 4;
            }
            else if ([Model.goodsPromotionType integerValue] == ZiYing_t || [Model.storeId integerValue] == 1 ||
                     Model.isOwnShop == 1){
                TV.VC_type = GoodDetail_ZY;
            }
            [self.navigationController pushViewController:TV animated:YES];
        }
    }
}


- (IBAction)Baby_Action:(id)sender {

    self.selectIndex = 0;
    [self ReloadUI];
}

- (IBAction)Store_Action:(id)sender {
    
    self.selectIndex = 1;
    [self ReloadUI];
}
@end
