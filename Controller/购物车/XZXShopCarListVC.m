//
//  XZXShopCarListVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopCarListVC.h"
#import "XZXShopGood_UploadOrderVC.h"
#import "XZX_GoodDetail_CommonTV.h"
#import "XZXStoreVC.h"

//#import "XZXPaymentOrder.h"
//#import "XZXMine_EditAdressTVC.h"
//#import "XZXShopGood_UploadOrderVC.h"
#import "XZXShopCarListheadCell.h"
#import "XZXShopCarListCell.h"



#import "XZXShopCarListVCModel.h"


@interface XZXShopCarListVC ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,XZXShopCarListCellDelegate,XZXShopCarListheadCellDelegate>

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)XZXShopCarListVCModel *ShopCarModel;
@property (nonatomic,assign) CGFloat OrderPrice;//订单价格
@property (nonatomic,assign)BOOL IsDelectGood;//区分删除和结算


@property (nonatomic,assign)NSInteger  page;
@property (nonatomic,assign)NSInteger  Total;

@property (nonatomic,strong)XZXShopCarListheadCell *headCell;
@end


@implementation XZXShopCarListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";

    //默认结算界面
    [self AdjustNavigation];

    self.SumPrice.adjustsFontSizeToFitWidth = YES;
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopCarListCell" bundle:nil] forCellReuseIdentifier:@"XZXShopCarListCellID"];
    self.CustomerTableView.tableFooterView  = [[UIView alloc]initWithFrame:CGRectZero];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    [self SetManualRefresh];
 
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //YES：允许右滑返回  NO：禁止右滑返回
    return NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewWillAppear:(BOOL)animated{
    self.page = 1;
    [self GetInformation];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


-(void)SetManualRefresh{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.CustomerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            //先判断数据库是否有第一页的数据，取出来做临时显示。
            [self GetInformation];
        }];
       // [self.CustomerTableView.mj_header beginRefreshing];
        
        
        self.CustomerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
            //調用此塊時自動進入刷新狀態
            if (self.Total <= self.dataSource.count) {
                
                [self.CustomerTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
             
                [self GetInformation];
            }
        }];
    });
}

-(void)GetInformation{

    [XHNetworking xh_postWithoutSuccess:@"cart/selectCartList" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"page":@(self.page)} success:^(XHResponse *responseObject) {
        
        
            [self.CustomerTableView.mj_header endRefreshing];
            [self.CustomerTableView.mj_footer endRefreshing];
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            if (self.page == 1) {
                
                self.OrderPrice = 0;
                self.SumPrice.text = [NSString stringWithFormat:@"合计：¥ %0.2f", self.OrderPrice];
                self.AllSelectBtn.selected = false;
                [self.dataSource removeAllObjects];
            }
            self.Total = [[responseObject.data valueForKey:@"count"] integerValue];
            self.Total = 100;
            ++self.page;
      
            
            if ([[responseObject.data valueForKey:@"list"] count] == 0) {
                [self.CustomerTableView.mj_footer endRefreshingWithNoMoreData];
            }
                for (NSDictionary *tempdic in [responseObject.data valueForKey:@"list"]) {
                    
                        XZXShopCarListVCModel *CarListVCModel = [XZXShopCarListVCModel yy_modelWithJSON:tempdic];
                        CarListVCModel.selectStore = 0;
                    for (XZXShopCarList_GoodVCModel *GoodModel in CarListVCModel.data) {
                     
                        GoodModel.selectGood = 0;
                    }
                    [self.dataSource addObject:CarListVCModel];
                }
        }
            [self.CustomerTableView reloadData];
    }];
    
}

#pragma mark UITableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    XZXShopCarListVCModel *ShopCarModel = (XZXShopCarListVCModel *)self.dataSource[section];
    
    self.headCell = [[[NSBundle mainBundle] loadNibNamed:@"XZXShopCarListheadCell" owner:nil options:nil]firstObject];

    self.headCell.storeName.attributedText = [NSString changestringArray:@[ShopCarModel.name,@"   >"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16.0",@"14.0"]];
    self.headCell.delegate = self;
    self.headCell.SelectBtn.tag = section;
    if (ShopCarModel.selectStore == 0) {
        
        self.headCell.SelectBtn.highlighted = false;
    }else{
        
        self.headCell.SelectBtn.highlighted = true;
    }
    return self.headCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XZXShopCarListVCModel *Model = [self.dataSource objectAtIndex:section];
    return Model.data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZXShopCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopCarListCellID" forIndexPath:indexPath];
     XZXShopCarListVCModel *Model = [self.dataSource objectAtIndex:indexPath.section];
    cell.GoodModel = [Model.data objectAtIndex:indexPath.row];
    cell.delegate = self;
    //cell.GoodsPrice.adjustsFontSizeToFitWidth  = YES;
    return cell;
}

#pragma mark 进入店铺
-(void)EnterStore:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self.CustomerTableView];
    NSIndexPath *indexPath = [self.CustomerTableView indexPathForRowAtPoint:point];
    XZXShopCarListVCModel *Model = [self.dataSource objectAtIndex:indexPath.section];
    
    XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.storeId = Model.data.count > 0 ? [Model.data objectAtIndex:0].storeId:@"1";
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark 选择商品
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXShopCarListVCModel * model= self.dataSource[indexPath.section];
    XZXShopCarList_GoodVCModel *goodModel = [model.data objectAtIndex:indexPath.row];
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = goodModel.goodsId;
    TV.VC_type = GoodDetail_CommonTV;
    TV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TV animated:YES];
    
}

-(void)DidSelectStor:(NSInteger)section{
    
    XZXShopCarListVCModel *ShopCarModel = [self.dataSource objectAtIndex:section];
    ShopCarModel.selectStore = ShopCarModel.selectStore == 0 ? 1: 0;
    for (XZXShopCarList_GoodVCModel *goodModel in ShopCarModel.data) {
        
        goodModel.selectGood = ShopCarModel.selectStore;
    }
    [self CountPrice];
    [self.CustomerTableView reloadData];
}


-(void)SelectSignalGood:(XZXShopCarListCell *)cell{
    
    NSIndexPath *indexPath = [self.CustomerTableView indexPathForCell:cell];
    XZXShopCarListVCModel *ShopCarModel = (XZXShopCarListVCModel *)self.dataSource[indexPath.section];
    XZXShopCarList_GoodVCModel *goodModel = [ShopCarModel.data objectAtIndex:indexPath.row];
    if (goodModel.selectGood == 1) {
        
        goodModel.selectGood = 0;
    }else{
        
        goodModel.selectGood = 1;
    }
 
    
    for (XZXShopCarListVCModel *ShopCarModel_temp in self.dataSource) {
        for (XZXShopCarList_GoodVCModel *goodModel_temp in ShopCarModel_temp.data) {
           
            if (goodModel_temp.selectGood != 1) {
                
                self.AllSelectBtn.selected = false;
                break;
            }
        }
    }
    [self CountPrice];
    [self.CustomerTableView reloadData];
}

-(void)ReduceGood:(XZXShopCarListCell *)cell{
   
   NSIndexPath *indexPath = [self.CustomerTableView indexPathForCell:cell];
   XZXShopCarListVCModel *ShopCarModel = (XZXShopCarListVCModel *)self.dataSource[indexPath.section];
    XZXShopCarList_GoodVCModel *goodModel = [ShopCarModel.data objectAtIndex:indexPath.row];
    if (goodModel.goodsNum >= 2) {
        
        NSInteger currentnum = goodModel.goodsNum;
        [XHNetworking xh_postWithoutSuccess:@"cart/updateCart" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"cartId":goodModel.cartId,@"cartUnionId":goodModel.cartUnionId,@"goodsNum":@(--currentnum)} success:^(XHResponse *responseObject) {
           
            goodModel.goodsNum = --goodModel.goodsNum;
            [self CountPrice];
            [self.CustomerTableView reloadData];
        }];
    
    }
}

-(void)AdGood:(XZXShopCarListCell *)cell{
    
     NSIndexPath *indexPath = [self.CustomerTableView indexPathForCell:cell];
     XZXShopCarListVCModel *ShopCarModel = (XZXShopCarListVCModel *)self.dataSource[indexPath.section];
     XZXShopCarList_GoodVCModel *goodModel = [ShopCarModel.data objectAtIndex:indexPath.row];
        
        NSInteger currentnum = goodModel.goodsNum;
        [XHNetworking xh_postWithoutSuccess:@"cart/updateCart" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"cartId":goodModel.cartId,@"cartUnionId":goodModel.cartUnionId,@"goodsNum":@(++currentnum)} success:^(XHResponse *responseObject) {
            
            goodModel.goodsNum = ++goodModel.goodsNum;
            [self CountPrice];
            [self.CustomerTableView reloadData];
        }];
}




- (IBAction)AllSelect_Action:(id)sender {
    
    self.AllSelectBtn.selected = !self.AllSelectBtn.selected;
    
        for (XZXShopCarListVCModel *ShopCarModel in self.dataSource) {
            
            ShopCarModel.selectStore = self.AllSelectBtn.isSelected == true ? 1 : 0;
            for (XZXShopCarList_GoodVCModel *GoodModel in ShopCarModel.data) {
            
                GoodModel.selectGood = self.AllSelectBtn.isSelected == true ? 1 : 0;
            }
        }
    
    [self CountPrice];
    [self.CustomerTableView reloadData];
    
}

-(void)CountPrice{
    
    self.OrderPrice = 0;
    for (XZXShopCarListVCModel *ShopCarModel in self.dataSource) {
        for (XZXShopCarList_GoodVCModel *goodModel in ShopCarModel.data) {
         
            
            if (goodModel.selectGood == 1) {
                self.OrderPrice +=[[NSString reviseString:goodModel.goodsPrice] floatValue] * goodModel.goodsNum;
            }
        }
    }
    self.SumPrice.text = [NSString stringWithFormat:@"合计：¥ %0.2f", self.OrderPrice];
}
#pragma mark 提交订单/删除订单

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
   self.IsDelectGood = !self.IsDelectGood;
    [self AdjustNavigation];
}

-(void)AdjustNavigation{
    
    if (!self.IsDelectGood) {
        
      
        [self addSignalRightItemWithTitle:@"管理" titleColor:[UIColor whiteColor]];
        [self.SureBtn setTitle:@"结算" forState:UIControlStateNormal];
        [self.SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.SureBtn setBackgroundColor:kThemeColor];
        self.SureBtn.cornerRadius = 0;
        self.AllSelectBtn.selected = NO;
        self.OrderPrice = 0;
        self.SumPrice.hidden = NO;
    }else{
        
        [self addSignalRightItemWithTitle:@"完成" titleColor:[UIColor whiteColor]];
        
        [self.SureBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.SureBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [self.SureBtn setBackgroundColor:[UIColor whiteColor]];
        self.SureBtn.layer.borderColor = kThemeColor.CGColor;
        self.SureBtn.layer.borderWidth = 1.0f;
        self.SureBtn.cornerRadius = 25.0f;
        
        self.AllSelectBtn.selected = NO;
        self.OrderPrice = 0;
        self.SumPrice.hidden = YES;
    }
}
- (IBAction)Sure_Action:(id)sender {
    
    if (!self.IsDelectGood) {
        
        [self PlaceOrder];
    }else{
        
        [self DelectOrder];
    }
}
#pragma mark 提交订单
-(void)PlaceOrder{

    if (self.OrderPrice == 0) {

        return;
    }
    XZXShopGood_UploadOrderVC *VC = kStoryboradController(@"Homepage", @"XZXShopGood_UploadOrderVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.UploadOrder_type = CarList;
    NSMutableString *paramete_id = [NSMutableString string];
    NSMutableArray *tables = [NSMutableArray array];
    for (NSInteger j = 0; j < self.dataSource.count; j++) {
        XZXShopCarListVCModel *model = [self.dataSource objectAtIndex:j];
        for (XZXShopCarList_GoodVCModel *goodModel in model.data) {
            
            if (goodModel.selectGood == 1) {
      
                    
                [paramete_id appendString:[NSString stringWithFormat:@"%@_",goodModel.cartId]];
                [tables addObject:@{@"cartId":goodModel.cartId,@"goodsNum":@(goodModel.goodsNum)}];

            }
        }
    }
    
    VC.tables = tables;
    VC.paramete_id = paramete_id;
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(void)EnterPaymentOrder:(NSMutableDictionary *)data{
   
//    XZXPaymentOrder *VC = kStoryboradController(@"Mine", @"XZXPaymentOrderID");
//    VC.hidesBottomBarWhenPushed = YES;
//    VC.order_data = data;
//    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark 删除订单
-(void)DelectOrder{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableString *tempMustrr = [NSMutableString string];
    for (NSInteger j = 0; j < self.dataSource.count; j++) {
        XZXShopCarListVCModel *model = [self.dataSource objectAtIndex:j];
        for (XZXShopCarList_GoodVCModel *goodModel in model.data) {
            if (goodModel.selectGood == 1) {
                [tempArray addObject:[NSString stringWithFormat:@"%@",goodModel.cartId]];
    
                    
                    [tempMustrr appendString:[NSString stringWithFormat:@"%@_",goodModel.cartId]];
                
            }
        }
    }

    
    [XHNetworking xh_postWithoutSuccess:@"cart/deleteCart" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"cartIdStr":tempMustrr} success:^(XHResponse *responseObject) {
        
        self.page = 1;
        [self GetInformation];
    }];
}


@end
