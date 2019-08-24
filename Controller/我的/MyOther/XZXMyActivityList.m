//
//  XZXMyActivityList.m
//  BigMarket
//
//  Created by RedSky on 2019/5/22.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyActivityList.h"
#import "XZXMyActivity_MSListCell.h"

@interface XZXMyActivityList ()

@property (nonatomic,strong)NSTimer *time;

@end

@implementation XZXMyActivity_MS_Model


@end

@implementation XZXMyActivityList
{
    
    dispatch_queue_t _ActivityList_Queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的秒杀";
    _ActivityList_Queue = dispatch_queue_create("ActivityList_Queue", DISPATCH_QUEUE_CONCURRENT);
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMyActivity_MSListCell" bundle:nil] forCellReuseIdentifier:@"XZXMyActivity_MSListCellID"];
    [self SetManualRefresh];
    self.tableView.backgroundColor = kBackgroundColor;
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(LastTime) userInfo:nil repeats:YES];
}

-(void)LastTime{
    
    dispatch_async(self->_ActivityList_Queue, ^{
        
        
        for (XZXMyActivity_MS_Model *Model in self.dataArray) {
            Model.LastTime = Model.LastTime > 0 ? --Model.LastTime : 0;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.time invalidate];
    self.time = nil;
    
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

                if (self.total > self.dataArray.count) {
                    self.page = self.dataArray.count/10 +1;
                    [self GetInformation];
                }else{
        
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
        }];
    });
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"yunshop/getMySpikeDetail" parameters:@{@"page":@(self.page),@"buyerId":@(kUser.member_id),@"userId":@(kUser.member_id),@"token":kUser.token}    success:^(XHResponse *responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       
        dispatch_async(self->_ActivityList_Queue, ^{
            
            if (responseObject.code == 200) {
                
                self.total = [[responseObject.data valueForKey:@"count"] integerValue];
                
                if (self.page == 1) {
                    
                    [self.dataArray removeAllObjects];
                }
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"order"]) {
                    
                    XZXMyActivity_MS_Model *Model = [XZXMyActivity_MS_Model yy_modelWithJSON:dic];
                    //计算剩余时间
                    if ([XHTools dateRemaining:Model.spikeTime] > 0) {
                        
                        Model.LastTime = 0;
                        
                    }else{
                        
                        
                        if (-[XHTools dateRemaining:Model.spikeTime] < [Model.spikeLasttime integerValue]*60) {
                            
                            
                            Model.LastTime =  [Model.spikeLasttime integerValue]*60 + [XHTools dateRemaining:Model.spikeTime];
                        }else{
                            
                            Model.LastTime = 0;
                        }
                    }
                    [self.dataArray addObject:Model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
            }
        });
    }];
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    XZXMyActivity_MSListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyActivity_MSListCellID" forIndexPath:indexPath];
    XZXMyActivity_MS_Model *Model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.headImage sd_setImageWithURL:kImageUrl(Model.storeId, Model.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    cell.name.text = Model.goodsName;
    cell.name.font = [UIFont systemFontOfSize:15.0];
    cell.content.attributedText =  [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:Model.goodsPrice]],[NSString stringWithFormat:@"  积分：%@",[Model.goodsScore isKindOfClass:[NSString class]] ? Model.goodsScore : @"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"17.0",@"14.0"]];
    cell.selected = UITableViewCellSelectionStyleNone;
    if (Model.LastTime > 0) {
        
        cell.endLabel.hidden = true;
        cell.hour.hidden  =  false;
        cell.mine.hidden  = false;
        cell.second.hidden = false;
        cell.hour.text = Model.LastTime/60/60%24 > 9 ? [NSString stringWithFormat:@"%ld",Model.LastTime/60/60%24] :[NSString stringWithFormat:@"0%ld",Model.LastTime/60/60%24];
        cell.mine.text  = Model.LastTime%3600/60 > 9 ? [NSString stringWithFormat:@"%ld",Model.LastTime%3600/60] : [NSString stringWithFormat:@"0%ld",Model.LastTime%3600/60];
        cell.second.text = Model.LastTime%60 > 9 ? [NSString stringWithFormat:@"%ld",Model.LastTime%60] : [NSString stringWithFormat:@"0%ld",Model.LastTime%60];
    }else{
       
        cell.hour.hidden  =  YES;
        cell.mine.hidden  = YES;
        cell.second.hidden = YES;
        cell.endLabel.hidden = false;
        cell.endLabel.text = @"已结束";
    }
    return cell;
}


@end
