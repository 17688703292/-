//
//  XZXMine_ZCTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_ZCTVC.h"
#import "XZX_GoodDetail_CommonTV.h"


#import "XZXMine_ZCTC.h"
@interface XZXMine_ZCTVC ()



@end


@implementation XZXMine_ZCModel


@end

@implementation XZXMine_ZCTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"我的众筹";
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMine_ZCTC" bundle:nil] forCellReuseIdentifier:@"XZXMine_ZCTCID"];
   
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
   
    [XHNetworking xh_postWithoutSuccess:@"activitys/getMyGroupBuyList" parameters:@{@"page":@(self.page),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
       
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
            
            [self.dataArray addObject:[XZXMine_ZCModel yy_modelWithJSON:dic]];
        }
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = kBackgroundColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
   return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    XZXMine_ZCTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ZCTCID" forIndexPath:indexPath];
    XZXMine_ZCModel *model = [self.dataArray objectAtIndex:indexPath.section];
    [cell.goodImage sd_setImageWithURL:kImageUrl(model.storeId,model.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    cell.goodName_lab.text = model.goodsName;
    switch ([model.orderState integerValue]) {
        case 11:
            {
                cell.ZC_statu.textColor = [UIColor orangeColor];
                cell.ZC_statu.text = @"进行中";
            }
            break;
        case 20:
        {
            cell.ZC_statu.textColor = kThemeColor;
            cell.ZC_statu.text = @"成功";
        }
            break;
        case 12:
        {
            cell.ZC_statu.textColor = [UIColor lightGrayColor];
            if ([model.crowdType integerValue] == 1) {
                
                cell.ZC_statu.text = @"未中奖";
            }else{
            
                cell.ZC_statu.text = @"失败";
            }
            
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodContent_lab.textColor = kThemeColor;
    cell.goodContent_lab.text = [[NSString alloc]initWithFormat:@"¥ %@",model.goodsPrice];
    cell.support_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",[model.currentOnePeople integerValue] + [model.currentFullPeople integerValue]],@"/",[NSString stringWithFormat:@"%@",model.fullPaymentPeople],@"支持"] colorArray:@[kThemeColor,[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor lightGrayColor]] fontArray:@[@"14",@"14",@"14",@"14"]];
    cell.rate_lab.attributedText = [NSString changestringArray:@[@"达成",[NSString stringWithFormat:@"%0.0f%%",([model.currentOnePeople integerValue] + [model.currentFullPeople integerValue])/[model.fullPaymentPeople floatValue]*100]] colorArray:@[[UIColor blackColor],kThemeColor] fontArray:@[@"14",@"13"]];
    cell.progress_pro.progress = ([model.currentOnePeople integerValue] + [model.currentFullPeople integerValue])/[model.fullPaymentPeople floatValue];
    cell.Money_lab.attributedText = [NSString changestringArray:@[model.crowdTotalMoney,@"元已筹"] colorArray:@[kThemeColor,[UIColor blackColor]] fontArray:@[@"14",@"13"]];
  
    BOOL result = [[XHTools getNowTimeTimestamp_HaoMiao] compare:model.activityEndDate]==NSOrderedAscending;
    
    if (result == 1) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp_day = [calendar components:NSCalendarUnitDay
                                                 fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                   toDate:[XHTools ConvertStrToTimeDate:model.activityEndDate]
                                                  options:NSCalendarWrapComponents];
        
        if (comp_day.day != 0) {
            //天
            cell.lastday_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_day.day],@"天"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
            
        }else{
            //时
            NSDateComponents *comp_hour = [calendar components:NSCalendarUnitHour
                                                      fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                        toDate:[XHTools ConvertStrToTimeDate:model.activityEndDate]
                                                       options:NSCalendarWrapComponents];
            //分
            NSDateComponents *comp_minute = [calendar components:NSCalendarUnitMinute
                                                        fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                          toDate:[XHTools ConvertStrToTimeDate:model.activityEndDate]
                                                         options:NSCalendarWrapComponents];
            if (comp_hour.hour != 0) {
                
                cell.lastday_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_hour.hour],@"时",[NSString stringWithFormat:@"%ld",comp_minute.minute%60],@"分"] colorArray:@[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0",@"15.0",@"11.0"]];
            }else{
                
                
                if (comp_minute.minute != 0) {
                    
                    cell.lastday_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_minute.minute],@"分"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                }else{
                    //秒
                    NSDateComponents *comp_second = [calendar components:NSCalendarUnitSecond
                                                                fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                                  toDate:[XHTools ConvertStrToTimeDate:model.activityEndDate]
                                                                 options:NSCalendarWrapComponents];
                    if (comp_second.second != 0) {
                        
                        cell.lastday_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_second.second],@"秒"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                    }else{
                        
                        cell.lastday_lab.attributedText = [NSString changestringArray:@[@"已结束",@""] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                    }
                }
            }
        }
    }else{
         cell.lastday_lab.attributedText = [NSString changestringArray:@[@"已结束",@""] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
        
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXMine_ZCModel *model = [self.dataArray objectAtIndex:indexPath.section];
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = model.goodsCommonid;
    TV.VC_type = GoodDetail_ZC;
    [self.navigationController pushViewController:TV animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionFooterH = 10;
    if (scrollView.contentOffset.y<=sectionFooterH && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, -sectionFooterH, 0);
    } else if (scrollView.contentOffset.y>= sectionFooterH) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, -sectionFooterH, 0);
    }else{
        scrollView.contentInset = UIEdgeInsetsZero;
    }
}

@end
