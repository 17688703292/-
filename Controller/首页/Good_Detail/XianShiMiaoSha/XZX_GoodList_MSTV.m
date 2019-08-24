//
//  XZX_GoodList_MSTV.m
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_MSTV.h"
#import "XZX_GoodList_MSHeadViewTVC.h"
#import "XZX_GoodList_MSTVC.h"
#import "XZX_GoodList_ContentTVC.h"
#import "XZX_GoodDetail_CommonTV.h"


#import "XZX_GoodList_MSModel.h"

@interface XZX_GoodList_MSTV ()<XZX_GoodList_MSTVCDelegate,XZX_GoodList_MSHeadViewTVCDelegate>


@property (nonatomic,strong) NSMutableArray *dataArray_time;//保存时间节点
@property (nonatomic,assign) NSInteger CurrentClass;//当前选择的时间点

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger ServiceReturn_total;

@property (nonatomic,strong) NSTimer *MS_timer;
@property (nonatomic,assign) NSInteger  LastTime;//返回当前商品的秒杀的剩余时间
@end

@implementation XZX_GoodList_MSTV

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"限时秒杀";
    [self.tableView registerNib:[UINib nibWithNibName:@"XZX_GoodList_MSHeadViewTVC" bundle:nil] forCellReuseIdentifier:@"XZX_GoodList_MSHeadViewTVCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZX_GoodList_MSTVC" bundle:nil] forCellReuseIdentifier:@"XZX_GoodList_MSTVCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZX_GoodList_ContentTVC" bundle:nil] forCellReuseIdentifier:@"XZX_GoodList_ContentTVCID"];
    
    self.CurrentClass = 0;
    [self ManualRefresh];
}

-(void)ManualRefresh{
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [self GetInformation];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.dataArray.count == 0) {
            return ;
        }
        XZX_GoodList_MSModel *MyModel = [self.dataArray objectAtIndex:self.CurrentClass];
        self.ServiceReturn_total = [MyModel.count integerValue];
    
        self.page = self.ServiceReturn_total%5 == 0 ? self.ServiceReturn_total/10: self.ServiceReturn_total/10+1;
        if (self.ServiceReturn_total > MyModel.goods.count) {
            
            [self GetInformation];
        }else{
            
            [self.tableView.mj_footer endRefreshing];
           // [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

        
    }];
    
}

-(NSMutableArray *)dataArray_time{
   
    if (!_dataArray_time) {
        _dataArray_time = [NSMutableArray array];
    }
    return _dataArray_time;
}

-(void)dealloc{
    
    [self.MS_timer invalidate];
    self.MS_timer = nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//
    [self.MS_timer invalidate];
    self.MS_timer = nil;
}

-(void)MS_LastTime_ReloadUI{
    
    --self.LastTime;
    [UIView performWithoutAnimation:^{
       
        //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    if (self.LastTime <= 0) {
        
        [self.MS_timer invalidate];
        self.MS_timer = nil;
    }
}

-(void)GetInformation{
    
    NSString *spikeId = [NSString string];
    
    if (self.dataArray.count > 0) {
         XZX_GoodList_MSModel *MyModel = [self.dataArray objectAtIndex:self.CurrentClass];
        spikeId = MyModel.spikeId;
    }
    
    [XHNetworking xh_postWithoutSuccess:@"homePage/getSelfSupport" parameters:@{@"activityType":self.activityModel.activityType,@"activityId":self.activityModel.activityId,@"page":@(self.page),@"gcId1":self.gcid,@"spikeId":spikeId} success:^(XHResponse *responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
           
            if (self.dataArray.count == 0) {
             
                [self.dataArray_time removeAllObjects];
                
                for (NSDictionary *dic in responseObject.data) {
                    [self.dataArray addObject:[XZX_GoodList_MSModel yy_modelWithJSON:dic]];
                   [self.dataArray_time addObject:@{@"spikeTime":[dic valueForKey:@"spikeTime"],@"spikeLasttime":[NSString stringWithFormat:@"%@",[dic valueForKey:@"spikeLasttime"]]}];
                    
                }
            }else{
                
                XZX_GoodList_MSModel *Model = [self.dataArray objectAtIndex:self.CurrentClass];
                if (self.page == 1) {
                    
                    [Model.goods removeAllObjects];
                }
                for (NSDictionary *dic_temp in responseObject.data) {
                    for (NSDictionary *dic in [dic_temp valueForKey:@"goods"]) {
                        
                        [Model.goods addObject:[XZX_Good_MSModel yy_modelWithJSON:dic]];
                    }
                }
            }
           
            //开启倒计时
            for (NSInteger i = 0; i < self.dataArray_time.count; i++) {
                NSDictionary *time_Dic = [self.dataArray_time objectAtIndex:i];
                 if ([XHTools dateRemaining:[time_Dic valueForKey:@"spikeTime"]] <= 0) {
                     if (-[XHTools dateRemaining:[time_Dic valueForKey:@"spikeTime"]] < [[time_Dic valueForKey:@"spikeLasttime"] integerValue]*60) {
                         
                         self.LastTime =  [[time_Dic valueForKey:@"spikeLasttime"] integerValue]*60 + [XHTools dateRemaining:[time_Dic valueForKey:@"spikeTime"]];
                        
                         if (self.MS_timer != nil) {
                             
                             [self.MS_timer invalidate];
                             self.MS_timer = nil;
                             self.MS_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(MS_LastTime_ReloadUI) userInfo:nil repeats:YES];
                             
                         }else{
                             
                             self.MS_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(MS_LastTime_ReloadUI) userInfo:nil repeats:YES];
                         }
                         self.CurrentClass = i;
                     }
                }
            }

              [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            return kScreenWidth/4.5*0.78;
        }
        return 50;
    }else{
        
        return 120;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if (self.dataArray.count > 0) {
     
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        
        return 2;
    }else{
         XZX_GoodList_MSModel *MyModel = [self.dataArray objectAtIndex:self.CurrentClass];
       return MyModel.goods.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    XZX_GoodList_MSModel *MyModel = [self.dataArray objectAtIndex:self.CurrentClass];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            XZX_GoodList_MSHeadViewTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZX_GoodList_MSHeadViewTVCID" forIndexPath:indexPath];
            cell.dataArray = self.dataArray_time;
            cell.currentTime_t = self.CurrentClass;
            cell.delegate = self;
            [cell.CustomerCollectionView reloadData];
            if (self.CurrentClass < self.dataArray_time.count) {
             
                [cell.CustomerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.CurrentClass inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            
            XZX_GoodList_ContentTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZX_GoodList_ContentTVCID" forIndexPath:indexPath];
          
            if ([XHTools dateRemaining:[[self.dataArray_time objectAtIndex:self.CurrentClass] valueForKey:@"spikeTime"]] > 0) {
                
                cell.Content.text = @"即将开启，不容错过";

            }else{
                
             
                if (-[XHTools dateRemaining:[[self.dataArray_time objectAtIndex:self.CurrentClass] valueForKey:@"spikeTime"]] < [[[self.dataArray_time objectAtIndex:self.CurrentClass] valueForKey:@"spikeLasttime"] integerValue]*60) {
                    
                    
                    NSInteger lastSecond = self.LastTime;
            
                   
                    NSString *hour = lastSecond/60/60%24 > 9 ?[NSString stringWithFormat:@"%ld",lastSecond/60/60%24]:[NSString stringWithFormat:@"0%ld",lastSecond/60/60%24];
                    NSString *mine = lastSecond%3600/60 > 9 ?[NSString stringWithFormat:@"%ld",lastSecond%3600/60]:[NSString stringWithFormat:@"0%ld",lastSecond%3600/60];
                    NSString *second = lastSecond%60 > 9 ?[NSString stringWithFormat:@"%ld",lastSecond%60]:[NSString stringWithFormat:@"0%ld",lastSecond%60];
                    cell.Content.text = [NSString stringWithFormat:@"本场还剩 %@:%@:%@",hour,mine,second];

                }else{
                    
                    cell.Content.text = @"限时抢购，手慢即无";
                }
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
     
        XZX_GoodList_MSTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZX_GoodList_MSTVCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.MyModel = [MyModel.goods objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([XHTools dateRemaining:[[self.dataArray_time objectAtIndex:self.CurrentClass] valueForKey:@"spikeTime"]] > 0) {
            
            [cell.SureBtn setTitle:@"等待开抢" forState:UIControlStateNormal];
            cell.SureBtn.backgroundColor = kThemeColor;
            
        }else{
            
            
            if (-[XHTools dateRemaining:[[self.dataArray_time objectAtIndex:self.CurrentClass] valueForKey:@"spikeTime"]] < [[[self.dataArray_time objectAtIndex:self.CurrentClass] valueForKey:@"spikeLasttime"] integerValue]*60) {
                
                
                [cell.SureBtn setTitle:@"抢购" forState:UIControlStateNormal];
                cell.SureBtn.backgroundColor = kThemeColor;
                
            }else{
                
                [cell.SureBtn setTitle:@"已结束" forState:UIControlStateNormal];
                cell.SureBtn.backgroundColor = [UIColor hexStringToColor:@"a6a6a6"];
            }
            
        }
        return cell;
    }
}



#pragma mark 切换秒杀时间
-(void)DidselectMSTime:(NSInteger)item{
    
    self.CurrentClass = item;
   
    [self.tableView reloadData];
    
}
#pragma mark 抢购

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
     
        XZX_GoodList_MSModel *MyModel = [self.dataArray objectAtIndex:self.CurrentClass];
        XZX_Good_MSModel *Model = [MyModel.goods objectAtIndex:indexPath.row];
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        
        TV.goodsId = Model.goodsId;
        TV.VC_type = GoodDetail_MS;
        [self.navigationController pushViewController:TV animated:YES];
    }
}

-(void)DidSelectGood:(XZX_GoodList_MSTVC *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XZX_GoodList_MSModel *MyModel = [self.dataArray objectAtIndex:self.CurrentClass];
    XZX_Good_MSModel *Model = [MyModel.goods objectAtIndex:indexPath.row];
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
  
    TV.goodsId = Model.goodsId;
    TV.VC_type = GoodDetail_MS;

    [self.navigationController pushViewController:TV animated:YES];
}

@end
