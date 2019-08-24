//
//  XZXClass_two_TVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXClass_two_TVC.h"
#import "XZX_GoodDetail_CommonTV.h"

#import "XZXShopGoodTypeHeadCell.h"
#import "XZXClass_good_TC.h"

#import "XZXClass_two_Model.h"

@interface XZXClass_two_TVC ()<XZXClass_good_TCDelegate>

@property (nonatomic,strong) dispatch_queue_t XZXClass_two_queue;
@property (nonatomic,assign) NSInteger Current_class;//当前选择的商品标签
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign)NSInteger Total;//总个数
@property (nonatomic,strong)XZXShopGoodTypeHeadCell *headView;
@end

@implementation XZXClass_two_TVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.XZXClass_two_queue = dispatch_queue_create("XZXShopCVC_queue", DISPATCH_QUEUE_CONCURRENT);
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXClass_good_TC" bundle:nil] forCellReuseIdentifier:@"XZXClass_good_TCID"];
    //IphoneX 底部留空白
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.Current_class = 0;
    
    
    [self AddReturnTopBtnIconImageName:@"zhiding" frame:CGRectMake(kScreenWidth*0.8, kScreenHeight*0.8, 50, 50) blcok:^{
        
        
    }];
    __weak typeof(self) weakSelf = self;
    self.Begain = ^{
        
        
        //[weakSelf.tableView scrollsToTop];
        [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    };
    
    [self ManualGetInformation];
}


-(void)viewWillAppear:(BOOL)animated{
    
    self.ReturnTopBtn.hidden = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.ReturnTopBtn.hidden = true;
}

-(void)ManualGetInformation{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        
        //获取默认第一个分类、切换分类接口不一样
        if (self.Current_class == 0) {
            
            [self GetInformation];
        }else{
            [self GetInformationGoodList];
        }
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.Total <= ((XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class]).goodsWithBLOBsPc.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            ++self.page;
            if (self.Current_class == 0) {
                
                [self GetInformation];
            }else{
                [self GetInformationGoodList];
            }
        }
    }];
    
}


-(void)GetInformation{
    
    [XHNetworking xh_postAlwaysWithResponse:@"goodsClassNav/getGoodsClassDetail" parameters:@{@"gcParentId":self.gcParentId,@"page":@(self.page)} showIndicator:YES response:^(XHResponse *responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.Total = [[responseObject.data valueForKey:@"count"] integerValue];
        
        dispatch_async(self.XZXClass_two_queue, ^{
            
            if (self.page == 1) {
                
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in [responseObject.data valueForKey:@"data"]) {
                    
                    [self.dataArray addObject:[XZXClass_two_Model yy_modelWithJSON:dic]];
                }
            }else{
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"data"]) {
                    
                    XZXClass_two_Model *two_Model = [XZXClass_two_Model yy_modelWithJSON:dic];
                    for (XZXClass_two_good_Model *good_model in two_Model.goodsWithBLOBsPc) {
                        XZXClass_two_Model *Orange_Model = (XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class];
                        [Orange_Model.goodsWithBLOBsPc addObject:good_model];
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"总个数---%ld",((XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class]).goodsWithBLOBsPc.count);
                [self.tableView reloadData];
            });
        });
        
        
    }];
}

-(void)GetInformationGoodList{
    
    
    [XHNetworking xh_postWithoutSuccess:@"goodsClassNav/getGoodsClassExchangeDetail" parameters:@{@"gcId":((XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class]).gcId,@"page":@(self.page)} success:^(XHResponse *responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.Total = [[responseObject.data valueForKey:@"count"] integerValue];
        
        dispatch_async(self.XZXClass_two_queue, ^{
            
            if (self.page == 1) {
                
                XZXClass_two_Model *model = [self.dataArray objectAtIndex:self.Current_class];
                [model.goodsWithBLOBsPc removeAllObjects];
                NSMutableArray *goodsWithBLOBsPc = [NSMutableArray array];
                for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
                    [goodsWithBLOBsPc addObject:[XZXClass_two_good_Model yy_modelWithJSON:dic]];
                }
                model.goodsWithBLOBsPc = goodsWithBLOBsPc;
                
            }else{
                
                XZXClass_two_Model *model = [self.dataArray objectAtIndex:self.Current_class];
                NSMutableArray *goodsWithBLOBsPc = [NSMutableArray arrayWithArray:model.goodsWithBLOBsPc];
                for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
                    [goodsWithBLOBsPc addObject:[XZXClass_two_good_Model yy_modelWithJSON:dic]];
                }
                model.goodsWithBLOBsPc = goodsWithBLOBsPc;
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"总个数---%ld",((XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class]).goodsWithBLOBsPc.count);
                [self.tableView reloadData];
                //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                
            });
        });
    }];
    
}

#pragma mark - Table view data source  商品列表显示

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return 0;
    }
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.dataArray.count == 0) {
        
        UIView *view = [UIView new];
        view.backgroundColor = kThemeColor;
        return view;
    }
    
    self.headView = [[[NSBundle mainBundle]loadNibNamed:@"XZXShopGoodTypeHeadCell" owner:nil options:nil] firstObject];
    self.headView.dataSource = self.dataArray;
    self.headView.selectGoodType = self.Current_class;
    
    __weak __typeof(self) weakSelf = self;
    self.headView.selectGoodTypeBlock = ^(NSInteger electGoodType_t) {
        
        //选择类别后。商品类型下标、商品类型、页数重定位
        weakSelf.Current_class = electGoodType_t;
        weakSelf.page = 1;
        [weakSelf GetInformationGoodList];
        NSLog(@"刷新所有段落");
    };
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.headView.CustomerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.Current_class inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
    });
    return self.headView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.dataArray.count == 0) {
        return 0;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"刷新段落内容");
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
        
    }else{
        
        
        XZXClass_good_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXClass_good_TCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.GoodModel_dataSource = [NSMutableArray arrayWithArray:((XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class]).goodsWithBLOBsPc];
        [cell.CustomerCVC reloadData];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 0;
    }else{
        NSInteger Allcount = [((XZXClass_two_Model *)[self.dataArray objectAtIndex:self.Current_class]).goodsWithBLOBsPc count];
        NSInteger num = Allcount%2 > 0? Allcount/2 +1 : Allcount/2;
        
        return ((kScreenWidth-20)/2+115)*num + 10;
    }
}

#pragma mark 进入商品详情
-(void)EntergoodsDetailVC:(XZXClass_two_good_Model *)model{
    
    
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = model.goodsId;
    TV.VC_type = GoodDetail_CommonTV;
    [self.navigationController pushViewController:TV animated:YES];
}
@end
