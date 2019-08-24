//
//  XZX_GoodList_JFTV.m
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_JFTV.h"
#import "XZX_GoodDetail_CommonTV.h"
#import "XZX_GoodList_GetJFVC.h"

#import "XZXHomeJF1_TC.h"
#import "XZXHomeJF2_TC.h"
#import "XZXHomeJF3_TC.h"
#import "XZXHomeJF4_TC.h"


@interface XZX_GoodList_JFTV ()<XZXHomeJF1Delegate,XZXHomeJF2Delegate,XZXHomeJF3_Delegate,XZXHomeJF4Delegate>

@property (nonatomic,strong) XZX_GoodList_JFModel *MyModel;
@property (nonatomic,strong) NSString *scoreType;//3、积分兑换 4、积分购物

@end


@implementation XZX_GoodList_JFModel


@end


@implementation XZX_GoodList_JFTV

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"积分专区";
    //[self addRightItemWithIconName:@"shuoming"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHomeJF1_TC" bundle:nil] forCellReuseIdentifier:@"XZXHomeJF1_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHomeJF2_TC" bundle:nil] forCellReuseIdentifier:@"XZXHomeJF2_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHomeJF3_TC" bundle:nil] forCellReuseIdentifier:@"XZXHomeJF3_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXHomeJF4_TC" bundle:nil] forCellReuseIdentifier:@"XZXHomeJF4_TCID"];
    self.page = 1;
    self.scoreType = @"";
    [self ManualGetInformation];

    
}


-(void)ManualGetInformation{
    
    [self GetInformation];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
      
        if (self.MyModel.IsSelectLeft == true) {
         
            self.scoreType = @"1";
            self.page = self.MyModel.scoreExchange.count/10;
        }else{
            
            self.scoreType = @"2";
            self.page = self.MyModel.scoreBuy.count/10;
        }
        ++self.page;
        NSLog(@"第几页---%ld",self.page);
        [self GetInformation];
    }];
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"goodsClassNav/getScoreBuygoods" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"scoreType":self.scoreType,@"page":@(self.page)} success:^(XHResponse *responseObject) {
        
        [self.tableView.mj_footer endRefreshing];
        if (self.page == 1 && [self.scoreType length] == 0) {
      
            self.MyModel = [XZX_GoodList_JFModel yy_modelWithJSON:responseObject.data];
             self.MyModel.IsSelectLeft = true;
        }else{
        
            
            if (self.MyModel.IsSelectLeft == true) {
        
                if (self.page == 1) {
                    [self.MyModel.scoreExchange removeAllObjects];
                }
                for (NSDictionary *dic in [responseObject.data valueForKey:@"scoreExchange"]) {
                    
                    [self.MyModel.scoreExchange addObject:dic];
                }
            }else{
                
                if (self.page == 1) {
                     [self.MyModel.scoreBuy removeAllObjects];
                }
                for (NSDictionary *dic in [responseObject.data valueForKey:@"scoreBuy"]) {
                    
                    [self.MyModel.scoreBuy addObject:dic];
                }
            }
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
           
            XZXHomeJF1_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHomeJF1_TCID" forIndexPath:indexPath];
            cell.delegate = self;
            [cell.leftBtn setTitle:[NSString reviseString:[NSString stringWithFormat:@"%0.2f",[self.MyModel.lowerLevelScore floatValue] + [self.MyModel.agentAcore floatValue]]] forState:UIControlStateNormal];
            [cell.rightBtn setTitle:[NSString reviseString:self.MyModel.blueScore] forState:UIControlStateNormal];
            return cell;
        }else{
            //3.3
            XZXHomeJF2_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHomeJF2_TCID" forIndexPath:indexPath];
            cell.delegate = self;
            cell.right_lab.attributedText = [NSString changestringArray:@[@"精美好品积分换",@""] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"13"]];
            return cell;
        }
    }else{
        
        if (indexPath.row == 0) {
            XZXHomeJF3_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHomeJF3_TCID" forIndexPath:indexPath];
            cell.delegate = self;
            if (self.MyModel.IsSelectLeft == true) {
                
                [cell.leftBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
                cell.leftBottomView.backgroundColor = kThemeColor;
                [cell.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cell.rightBottomView.backgroundColor = [UIColor whiteColor];
            }else{
                
                [cell.rightBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
                cell.rightBottomView.backgroundColor = kThemeColor;
                [cell.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cell.leftBottomView.backgroundColor = [UIColor whiteColor];
            }
            return cell;
            
        }else{
            
            XZXHomeJF4_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHomeJF4_TCID" forIndexPath:indexPath];
            cell.delegate = self;
         if (self.MyModel.IsSelectLeft == true) {
             
             cell.scoreType = 1;
             cell.dataArray = self.MyModel.scoreExchange;
         }else{
             
             cell.scoreType = 2;
             cell.dataArray = self.MyModel.scoreBuy;
         }
            [cell.CustomerCollectionView reloadData];
            return cell;
        }
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return 0;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = kBackgroundColor;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return kScreenWidth*0.45;
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        return 70;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        return 45;
    }else{
        
        NSInteger row = 1;
        if (self.MyModel.IsSelectLeft == true) {
         
            row = self.MyModel.scoreExchange.count%3 == 0 ?self.MyModel.scoreExchange.count/3 : self.MyModel.scoreExchange.count/3+1 ;
        }else{
            
            row =  self.MyModel.scoreBuy.count%3 == 0 ?self.MyModel.scoreBuy.count/3 : self.MyModel.scoreBuy.count/3+1 ;
        }
        return (kScreenWidth/3 + 45)*row;
    }
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    //查看说明
}

-(void)HomeJF1_DidselectLeft:(BOOL)IsSelect{
    
    if (IsSelect == YES) {
        //查看红积分
        
    }else{
        //查看蓝积分
        
    }
}

-(void)HomeJF2_DidSelectLeft:(BOOL)IsSelect{
    
    
    
    if (IsSelect == YES) {
        //查看如何查看积分
        XZX_GoodList_GetJFVC *VC = [[XZX_GoodList_GetJFVC alloc]initWithNibName:@"XZX_GoodList_GetJFVC" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        //查看全场折扣商品
        
    }
}

-(void)DidSelectLeftBtn:(BOOL)IsSelectLeft{
    
    if (IsSelectLeft == true) {
        //积分兑
       
        if (self.MyModel.IsSelectLeft != true) {
            
            self.MyModel.IsSelectLeft = true;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }else{
      
        //积分购
       
        if (self.MyModel.IsSelectLeft != false) {
            
            self.MyModel.IsSelectLeft = false;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}


-(void)DidSelectCell:(NSString *)goodsId{
    
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = goodsId;
    TV.VC_type = GoodDetail_JF;
    TV.JF_type = self.MyModel.IsSelectLeft == true ? 3 : 4;
    TV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TV animated:YES];
}
@end
