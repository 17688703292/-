//
//  XZXEvalutionListTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXEvalutionListTVC.h"

#import "XZXShopGoodEvalution_ListModel.h"
#import "XZXShopGoodEvalution_Model.h"

#import "GoodDetail_Evalution1.h"
#import "XZXShopAllEvalution_TC.h"

#import <YBImageBrowser/YBImageBrowser.h>
@interface XZXEvalutionListTVC ()<XZXShopAllEvalutionDelegate>
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)NSInteger Total;//总个数
@property (nonatomic,strong)XZXShopGoodEvalution_ListModel *MyModel;

@end

@implementation XZXEvalutionListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评价";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodDetail_Evalution1" bundle:nil] forCellReuseIdentifier:@"GoodDetail_Evalution1ID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXShopAllEvalution_TC" bundle:nil] forCellReuseIdentifier:@"XZXShopAllEvalution_TCID"];
    [self ManualGetInformation];
}
-(void)ManualGetInformation{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self.page = 1;
        [self GetInformation];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.Total <= self.dataArray.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            ++self.page;
            [self GetInformation];
        }
    }];
    
}

-(void)GetInformation{
    
    [XHNetworking xh_postAlwaysWithResponse:@"evaluateGoods/secrahEvaluateByGoodsId" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"page":@(self.page),@"gevalGoodsid":self.gevalGoodsid} showIndicator:YES response:^(XHResponse *responseObject) {
    
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]] &&
            [[responseObject.data valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
            
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            self.Total = [[responseObject.data valueForKey:@"countAll"] integerValue];
            self.MyModel = [XZXShopGoodEvalution_ListModel yy_modelWithJSON:responseObject.data];
            for (XZXShopGoodEvalution_Model *model in self.MyModel.data) {
                [self.dataArray addObject:model];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


#pragma mark - Table view data source



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
   
    return self.dataArray.count +1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    
        GoodDetail_Evalution1 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_Evalution1ID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.MyModel = self.MyModel;
        return cell;
    }else{
        
     
        XZXShopAllEvalution_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopAllEvalution_TCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.MyModel = (XZXShopGoodEvalution_Model *)[self.dataArray objectAtIndex:indexPath.row-1];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)View_MaxPic:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    XZXShopGoodEvalution_Model *Model = [self.dataArray objectAtIndex:indexPath.row-1];
    YBImageBrowseCellData *data0 = [YBImageBrowseCellData new];
    data0.url = [NSURL URLWithString:[Model.gevalImage containsString:@"://"] ? Model.gevalImage : [NSString stringWithFormat:@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/%@",Model.gevalImage]];
    YBImageBrowser *ImageBrowser = [YBImageBrowser new];
    ImageBrowser.dataSourceArray = @[data0];
    ImageBrowser.currentIndex = indexPath.row;
    [ImageBrowser show];
    
}
@end
