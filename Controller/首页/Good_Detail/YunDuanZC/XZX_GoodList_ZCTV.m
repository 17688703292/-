//
//  XZX_GoodList_ZCTV.m
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_ZCTV.h"
#import "XZX_GoodHistoryList_ZCTV.h"
#import "XZX_GoodDetail_CommonTV.h"

#import "ZC_GoodList_TC.h"
#import "ZC_GoodList2_TC.h"

#import "XZX_GoodList_ZCModel.h"

@interface XZX_GoodList_ZCTV ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger page;
@end

@implementation XZX_GoodList_ZCTV

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"众筹列表";
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;

    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"ZC_GoodList_TC" bundle:nil] forCellReuseIdentifier:@"ZC_GoodList_TCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"ZC_GoodList2_TC" bundle:nil] forCellReuseIdentifier:@"ZC_GoodList2_TCID"];
    [self SetManualRefresh];
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
                ++self.page;
                [self GetInformation];
        }];
    });
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"activitys/getGroupBuy" parameters:@{@"page":@(self.page),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
       
        
        [self.CustomerTableView.mj_header endRefreshing];
       
        if ([[responseObject.data valueForKey:@"list"] count] == 0) {
            
            [self.CustomerTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            [self.CustomerTableView.mj_footer endRefreshing];
        }
        
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
            
            [self.dataSource addObject:[XZX_GoodList_ZCModel yy_modelWithJSON:dic]];
        }
        [self.CustomerTableView reloadData];
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView *baseview = [[UIView alloc]init];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-10,50)];
        lable.numberOfLines = 0;
        lable.attributedText = [NSString changestringArray:@[@"正在众筹\n",@"寻觅世间好物，只为精致你的生活"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"13.0"]];
        [baseview addSubview:lable];
        return baseview;
    }else{
        
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 70;
    }
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView *baseview = [[UIView alloc]init];
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chakanwangqizhongchou"] forState:UIControlStateNormal];
        [btn setTitle:@"查看往期众筹" forState:UIControlStateNormal];
        [btn setFont:[UIFont systemFontOfSize:14.0]];
        [btn addTarget:self action:@selector(ViewHistory) forControlEvents:UIControlEventTouchDown];
        [baseview addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.mas_equalTo(baseview);
            make.centerY.mas_equalTo(baseview);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
        }];
        btn.cornerRadius = 15.0;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        return baseview;
    }else{
        
        return [UIView new];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 50;
    }
    return 0;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataSource.count == 0) {
        return 0;
    }else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
    if (section == 0) {
     
        return 1;
    }else{
        
        return self.dataSource.count-1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        ZC_GoodList_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"ZC_GoodList_TCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.MyModel = [self.dataSource objectAtIndex:0];
        return cell;
        
    }else{
        
        ZC_GoodList2_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"ZC_GoodList2_TCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.MyModel = [self.dataSource objectAtIndex:indexPath.row+1];
        return cell;
        
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return kScreenWidth;
    }else if (indexPath.section == 1){
        
        return 150;
    }else{
        
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.VC_type = GoodDetail_ZC;
    
    if (indexPath.section == 0) {
      
        TV.goodsId = ((XZX_GoodList_ZCModel *)[self.dataSource objectAtIndex:0]).goodsCommonid;
    }else{
     
        TV.goodsId = ((XZX_GoodList_ZCModel *)[self.dataSource objectAtIndex:indexPath.row+1]).goodsCommonid;
    }

    TV.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:TV animated:YES];
}
-(void)ViewHistory{
   
    XZX_GoodHistoryList_ZCTV *VC = [[XZX_GoodHistoryList_ZCTV alloc]initWithNibName:@"XZX_GoodHistoryList_ZCTV" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (self.CustomerTableView.contentOffset.y<=sectionHeaderHeight && self.CustomerTableView.contentOffset.y>=0) {
        self.CustomerTableView.contentInset = UIEdgeInsetsMake(- self.CustomerTableView.contentOffset.y, 0, 0, 0);
    } else if (self.CustomerTableView.contentOffset.y>=sectionHeaderHeight) {
        self.CustomerTableView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
