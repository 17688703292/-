//
//  XZXMineOrderBaseTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMineOrderBaseTVC.h"
#import "XZXOrderDetailVC.h"
#import "XZXPaymentOrder.h"
#import "XZXTransportTVC.h"
#import "XZXReturnAfterSaleDetail.h"
#import "XZXPayResultVC.H"
#import "XZXEvalutionTVC.h"
#import "XZXStoreVC.h"

#import "XHMacro.h"
#import "XZXShopCarListheadCell.h"
#import "XZXMine_MyOrderHeadView.h"
#import "XZXMine_MyOrderCell.h"
#import "XZXMine_MyOrderFootView.h"


#import "XZXEvalutionTVCModel.h"


@interface XZXMineOrderBaseTVC ()<XZXMine_MyOrderFootViewDelegate,XZXShopCarListheadCellDelegate>

@property (nonatomic, assign) BOOL didLayoutSubViews;

@property (nonatomic,assign) NSInteger ServiceReturn_total;//服务器返回的订单总个数

@property (nonatomic,strong)XZXShopCarListheadCell *headCell;
@end

@implementation XZXMineOrderBaseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMine_MyOrderCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_MyOrderCellID"];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    
    [self ManualRefresh];
}

-(void)ManualRefresh{
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [self Orderlist_GetInformation:self.index];
    }];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.ServiceReturn_total > self.dataArray.count) {
            
            
            [self Orderlist_GetInformation:self.index];
        }else{
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    }];
    
    
}

-(void)Orderlist_GetInformation:(NSInteger )selectFlag{
    
    NSInteger order_state = 8;
    NSString *urlstr = @"orders/selectOrderList";
    switch (selectFlag) {
        case AllOrderBase:
            order_state = 8;
            break;
        case WattingPaymentBase:
            order_state = WattingPaymentBase_service;
            break;
        case WattingSendBase:
            order_state = WattingSendBase_service;
            break;
        case WattingReceiveBase:
            order_state = WattingReceiveBase_service;
            break;
        case FinishOrderBase:
            order_state = FinishOrderBase_service;
            break;
        case CancelBase:
            order_state = CancelBase_service;
            break;
        case AfterSaleBase:
            urlstr = @"orders/getAllCancelRefundOrderGood";
            order_state = AfterSaleBase_service;
            break;
        default:
            break;
    }
    
    
    [XHNetworking xh_postWithoutSuccess:urlstr parameters:@{@"buyerId":@(kUser.member_id),@"token":kUser.token,@"userId":@(kUser.member_id),@"orderState":selectFlag == AllOrderBase ?@"" : @(order_state),@"page":@(self.page)} success:^(XHResponse *responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.page == 1) {
            
            [self.dataArray removeAllObjects];
        }
        
        ++self.page;
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject.data allKeys] containsObject:@"count"] ) {
                
                self.ServiceReturn_total = [[responseObject.data valueForKey:@"count"] integerValue];
            }
            
            if ([[responseObject.data allKeys] containsObject:@"order"]) {
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"order"]) {
                    
                    [self.dataArray addObject:[XZXMineOrderModel yy_modelWithJSON:dic]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.ServiceReturn_total == self.dataArray.count) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    [self.tableView reloadData];
                });
            }
        }
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XZXMineOrderModel *model = [self.dataArray objectAtIndex:section];
    return model.orderGoodsList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    XZXMine_MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_MyOrderCellID" forIndexPath:indexPath];
    XZXMineOrderModel *model = [self.dataArray objectAtIndex:indexPath.section];
    XZXMineOrderGoodDetailModel *DetailModel =  model.orderGoodsList[indexPath.row];
    [cell LoadDataRefreshUI:model GoodDetailModel:DetailModel];
    
    if (indexPath.row+1 == model.orderGoodsList.count) {
        
        cell.good_sumPrice.hidden = NO;
    }else{
        
        cell.good_sumPrice.hidden = YES;
    }
    /**
     判断售后状态时，当orderGoodsRefundStatus=4时，说明用户已撤销申请，不需要再判断orderGoodsRefundSellerStratus
     */
    
    //除积分商品，都用订单金额
    NSString *payTitleStr = [NSString string];
    NSString *payMoneyStr = [NSString stringWithFormat:@"订单金额 ：¥ %@",[NSString reviseString:model.orderAmount]];
    UIColor *payMoneyColor = [UIColor blackColor];
    
    if (self.index == AfterSaleBase) {
        cell.AftersaleImage.hidden = false;
        [cell.goodImage sd_setImageWithURL:kImageUrl(model.storeId, DetailModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        NSMutableString *statu = [NSMutableString string];
        switch (DetailModel.orderGoodsRefundStatus) {
            case 1:
                {
                    cell.AftersaleImage.image = [UIImage imageNamed:@"jintuikuan"];
                    [statu  appendString: @"仅退款"];
                }
                break;
            case 2:
            {
                cell.AftersaleImage.image = [UIImage imageNamed:@"tuihuotuikuan"];
                [statu  appendString:@"退货退款"];
            }
                break;
            case 3:
            {
                cell.AftersaleImage.image = [UIImage imageNamed:@"huanhuo"];
                [statu  appendString:@"换货"];
            }
                break;
            case 4:
            {
                cell.AftersaleImage.image = [UIImage imageNamed:@"jintuikuan"];
                [statu  appendString: @"用户已撤销"];
            }
                break;
            default:
                break;
        }
        
        if (DetailModel.orderGoodsRefundStatus != 4) {
         
            switch ([DetailModel.orderGoodsRefundSellerStratus integerValue]) {
                case 0:
                {
                    [statu  appendString:@"  审核中"];
                }
                    break;
                case 1:
                {
                    [statu  appendString:@"   同意"];
                }
                    break;
                case 2:
                {
                    [statu  appendString:@"   拒绝"];
                }
                    break;
                default:
                    break;
            }
        }
        
        
        cell.good_sumPrice.textAlignment = NSTextAlignmentLeft;
        cell.good_sumPrice.text = statu;
        cell.good_sumPrice.textColor = [UIColor blackColor];
        cell.good_sumPrice.font = [UIFont systemFontOfSize:16.0];
     
    }
    else{
    
       
        cell.AftersaleImage.image = [UIImage imageNamed:@""];
        if (![model.crowdType isEqual:[NSNull class]]) {
            
            if ([model.crowdType integerValue] == 1) {
                
                //一元众筹
                if (model.orderState == 11) {
                    //等待中
                    cell.AftersaleImage.image = [UIImage imageNamed:@"yiyuanzhongchou_daikaijiang"];
                }else if(model.orderState == 12){
                    //失败
                    cell.AftersaleImage.image = [UIImage imageNamed:@"yiyuanzhongchou_weizhongjiang"];
                }else if(model.orderState != 10){
                    //成功
                    cell.AftersaleImage.image = [UIImage imageNamed:@"yiyuanzhongchou_yizhongjiang"];
                }
            }else if ([model.crowdType integerValue] == 2){
                
                //全款支持
                if (model.orderState == 11) {
                    //等待中
                    cell.AftersaleImage.image = [UIImage imageNamed:@"quankuanzhongchou_zhongchouzhong"];
                }else if(model.orderState == 12){
                    //失败
                    cell.AftersaleImage.image = [UIImage imageNamed:@"quankuanzhongchou_zhongchoushibai"];
                }else if(model.orderState != 10){
                    //成功
                    cell.AftersaleImage.image = [UIImage imageNamed:@"quankuanzhongchou_zhongchouchenggong"];
                }
            }else if ([model.crowdType integerValue] == 3){
                
                //积分购物
                payTitleStr = [NSString stringWithFormat:@"蓝积分：-%@ ",model.blueScore];
                if (model.orderState == WattingPaymentBase_service) {
                
                    cell.AftersaleImage.image = [UIImage imageNamed:@"jifenxianjin"];
                    //使用金钱支付
                    payMoneyStr = [NSString stringWithFormat:@"订单金额 ：¥ %@",model.orderAmount];
                }else{
                 
                 
                    if ([model.redScore floatValue] == 0) {
                         cell.AftersaleImage.image = [UIImage imageNamed:@"jifenxianjin"];
                        //使用金钱支付
                        payMoneyStr = [NSString stringWithFormat:@"订单金额 ：¥ %@",model.orderAmount];
                    }else{
                         cell.AftersaleImage.image = [UIImage imageNamed:@"honglanjifen"];
                        //使用红积分支付
                        payMoneyStr = [NSString stringWithFormat:@"红积分：-%@",model.redScore];
                        payMoneyColor = kThemeColor;
                    }
                }
                
                
            }else if ([model.crowdType integerValue] == 4){
                
                //积分兑换
                cell.AftersaleImage.image = [UIImage imageNamed:@"jifenduihuan"];
                payTitleStr = [NSString stringWithFormat:@"蓝积分：-%@",model.blueScore];
                payMoneyStr = @"";
            }
        }
        
       
        cell.good_sumPrice.attributedText = [NSString changestringArray:@[payTitleStr,payMoneyStr] colorArray:@[[UIColor hexStringToColor:@"4282eb"],payMoneyColor] fontArray:@[@"15.0",@"15.0"]];
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    XZXMineOrderModel *OrderModel = (XZXMineOrderModel *)[self.dataArray objectAtIndex:section];
    NSString *statu_str = [NSString new];
    switch (OrderModel.orderState) {
        case 0:
        {
           // statu_str = @"买家取消付款";
        }
            break;
        case 11:
        case 12:
        {
            statu_str = @"买家已付款";
        }
            break;
        case 10:
            {
                statu_str = @"等待买家付款";
            }
            break;
        case 20:
        {
            statu_str = @"买家已付款";
        }
            break;
        case 30:
        {
            statu_str = @"卖家已发货";
        }
            break;
        case 40:
        {
            statu_str = @"交易成功";
        }
            break;
        default:
            break;
    }
    
    
    self.headCell = [[[NSBundle mainBundle] loadNibNamed:@"XZXShopCarListheadCell" owner:nil options:nil]firstObject];
    self.headCell.statuContent.text = statu_str;
    self.headCell.statuContent.textColor = kThemeColor;
    self.headCell.delegate = self;
    [self.headCell.SelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
    }];
    self.headCell.storeName.attributedText = [NSString changestringArray:@[OrderModel.storeName,@"   >"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16.0",@"14.0"]];
    return self.headCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XZXMine_MyOrderFootView *footView = [[[NSBundle mainBundle]loadNibNamed:@"XZXMine_MyOrderFootView" owner:nil options:nil]firstObject];
    footView.tag = section;
    footView.delegate = self;
    switch (self.index) {
        case AllOrderBase:
        {
            
            XZXMineOrderModel *model = [self.dataArray objectAtIndex:section];
            
            if (model.orderState == ZC_serviceWait) {
            
                
                footView.LeftBtn.hidden  = YES;
                footView.LeftBtn.userInteractionEnabled = YES;
                [footView.RightBtn setTitle:@"查看详情" forState:UIControlStateNormal];

            }else if (model.orderState == ZC_serviceFair){
             
                
                footView.LeftBtn.hidden  = YES;
                footView.LeftBtn.userInteractionEnabled = YES;
                [footView.RightBtn setTitle:@"查看详情" forState:UIControlStateNormal];

            }else if (model.orderState == CancelBase_service) {
                
                footView.LeftBtn.hidden = YES;
                footView.LeftBtn.userInteractionEnabled = YES;
                footView.RightBtn.hidden = NO;
                [footView.RightBtn setTitle:@"已取消" forState:UIControlStateNormal];
            }else if (model.orderState == WattingPaymentBase_service){
                
                [footView.LeftBtn setTitle:@"取消" forState:UIControlStateNormal];
                [footView.RightBtn setTitle:@"下单支付" forState:UIControlStateNormal];
            }else if (model.orderState == WattingSendBase_service){
                
                footView.LeftBtn.hidden = YES;
                footView.LeftBtn.userInteractionEnabled = YES;
                footView.RightBtn.hidden = NO;
                [footView.RightBtn setTitle:@"待发货" forState:UIControlStateNormal];
            }else if (model.orderState == WattingReceiveBase_service){
                
                [footView.LeftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                [footView.RightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            }else if (model.orderState == FinishOrderBase_service){
                
                footView.LeftBtn.hidden  = YES;
                footView.LeftBtn.userInteractionEnabled = YES;
                [footView.RightBtn setTitle:@"已完成" forState:UIControlStateNormal];
            }else if (model.orderState == AfterSaleBase_service){
                
                footView.LeftBtn.hidden  = YES;
                footView.LeftBtn.userInteractionEnabled = YES;
                [footView.RightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            }
        }
            break;
        case WattingPaymentBase:
        {
            [footView.LeftBtn setTitle:@"取消" forState:UIControlStateNormal];
            [footView.RightBtn setTitle:@"下单支付" forState:UIControlStateNormal];
        }
            break;
        case WattingSendBase:
        {
            
            footView.LeftBtn.hidden = YES;
            footView.LeftBtn.userInteractionEnabled = YES;
            footView.RightBtn.hidden = NO;
            [footView.RightBtn setTitle:@"待发货" forState:UIControlStateNormal];
        }
            break;
        case WattingReceiveBase:
        {
            [footView.LeftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [footView.RightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        case FinishOrderBase:
        {
            
            
            [footView.LeftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
             XZXMineOrderModel *model = [self.dataArray objectAtIndex:section];
            if (model.evaluationState == 1) {
             
                [footView.RightBtn setTitle:@"已评价" forState:UIControlStateNormal];
            }else{
                
                [footView.RightBtn setTitle:@"未评价" forState:UIControlStateNormal];
            }
          
        }
            break;
        case AfterSaleBase:
        {
            footView.LeftBtn.hidden = YES;
            footView.LeftBtn.userInteractionEnabled = YES;
            [footView.RightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            
        }
            break;
        case  CancelBase:
        {
            
            footView.LeftBtn.hidden = YES;
            footView.LeftBtn.userInteractionEnabled = YES;
            [footView.RightBtn setTitle:@"已取消" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    return footView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
     XZXMineOrderModel *model = [self.dataArray objectAtIndex:indexPath.section];
    if (model.orderState != CancelBase_service &&
        model.orderState != AfterSaleBase_service) {
        
       
        
        XZXOrderDetailVC *DetailVC = kStoryboradController(@"Mine", @"XZXOrderDetailVCID");
        DetailVC.OrderModel = model;
        [self.navigationController pushViewController:DetailVC animated:YES];
    }
    
}


#pragma mark 进入店铺
-(void)EnterStore:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    XZXMineOrderModel *OrderModel = (XZXMineOrderModel *)[self.dataArray objectAtIndex:indexPath.section];
    
    XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.storeId = OrderModel.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark XZXMine_MyOrderFootViewDelegate 左右按钮
-(void)MyOrder_LeftBtn:(XZXMine_MyOrderFootView *)view{
    
    NSLog(@"左手---%ld",view.tag);
    
    switch (self.index) {
        case AllOrderBase:
        {
            XZXMineOrderModel *model = [self.dataArray objectAtIndex:view.tag];
            
            if (model.orderState == WattingPaymentBase_service){
                
                
                [self CancelOrder:view.tag];
            }else if (model.orderState == WattingReceiveBase_service){
                
                [self ViewTransportGood:view.tag];
            }
        }
            break;
        case WattingPaymentBase:
        {
            [self CancelOrder:view.tag];
        }
            break;
        case WattingSendBase:
        {
            //无内容
        }
            break;
        case WattingReceiveBase:
        {
            [self ViewTransportGood:view.tag];
            
        }
            break;
        case FinishOrderBase:
        {
              [self ViewTransportGood:view.tag];
        }
            break;
        case AfterSaleBase:
        {
            
            [self ViewTransportGood:view.tag];
        }
            break;
        case  CancelBase:
        {
            
        }
            break;
        default:
            break;
    }
    
}

-(void)MyOrder_RightBtn:(XZXMine_MyOrderFootView *)view{
    
    
    switch (self.index) {
        case AllOrderBase:
        {
            XZXMineOrderModel *model = [self.dataArray objectAtIndex:view.tag];
            
            if (model.orderState == WattingPaymentBase_service){
                
                [self PaymentGood:view.tag];
            }else if (model.orderState == WattingReceiveBase_service){
                
                [self ReceiveGood:view.tag];
            }else if (model.orderState == FinishOrderBase_service){
                
                [self EvalutionGood:view.tag];
                
            }else if (model.orderState == AfterSaleBase_service){
                
                [self ViewDetailOrder:view.tag];
            }else if (model.orderState == ZC_serviceWait ||
                      model.orderState == ZC_serviceFair){
                
                [self ViewDetailOrder:view.tag];
            }
        }
            break;
        case WattingPaymentBase:
        {
            [self PaymentGood:view.tag];
        }
            break;
        case WattingSendBase:
        {
            //无内容
        }
            break;
        case WattingReceiveBase:
        {
            [self ReceiveGood:view.tag];
            
        }
            break;
        case FinishOrderBase:
        {
            
            [self EvalutionGood:view.tag];
            
        }
            break;
        case AfterSaleBase:
        {
            
            [self ViewDetailOrder:view.tag];
        }
            break;
        case CancelBase:
        {
            
        }
            break;
        default:
            break;
    }
    
    
}
#pragma mark 取消订单
-(void)CancelOrder:(NSInteger )selectOrder_t{
    
    
    
    XZXMineOrderModel *model = [self.dataArray objectAtIndex:selectOrder_t];
    
    [XHNetworking xh_postWithSuccess:@"orders/cancelOrder" parameters:@{@"buyerId":@(kUser.member_id),@"token":kUser.token,@"orderId":model.orderId,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        self.page = 1;
        [self Orderlist_GetInformation:self.index];
    }];
}


#pragma mark 立即付款
-(void)PaymentGood:(NSInteger )selectOrder_t{
    
    XZXMineOrderModel *model = [self.dataArray objectAtIndex:selectOrder_t];
    
    XZXOrderDetailVC *DetailVC = kStoryboradController(@"Mine", @"XZXOrderDetailVCID");
    DetailVC.OrderModel = model;
    [self.navigationController pushViewController:DetailVC animated:YES];
    
}

#pragma mark 查看物流
-(void)ViewTransportGood:(NSInteger )selectOrder_t{
    XZXMineOrderModel *model = [self.dataArray objectAtIndex:selectOrder_t];
    XZXTransportTVC *TVC = [[XZXTransportTVC alloc]initWithNibName:@"XZXTransportTVC" bundle:nil];
    TVC.order_num = model.orderId;
    TVC.order_statu = model.orderState;
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 确认收货
-(void)ReceiveGood:(NSInteger )selectOder_t{
    
    UIAlertController *alertAC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请确认商品是否有损坏?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertAC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertAC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        XZXMineOrderModel *model = [self.dataArray objectAtIndex:selectOder_t];
        [XHNetworking xh_postWithSuccess:@"orders/confirmReceipt" parameters:@{@"buyerId":@(kUser.member_id),@"token":kUser.token,@"orderId":model.orderId,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
            
            self.page = 1;
            [self Orderlist_GetInformation:self.index];
        }];
    }]];
    
    
    [self presentViewController:alertAC animated:YES completion:^{
        
    }];
}

//@property (nonatomic,assign) NSInteger EvalutionLevel;//评价等级
//@property (nonatomic,copy)  NSString *EvalutionContent;//描述
//@property (nonatomic,strong) NSMutableArray *dataArray_Pic;//图片
//@property (nonatomic,assign) NSInteger anonymous;//匿名
//@property (nonatomic,strong)XZXMineOrderGoodDetailModel *GoodModel;//商品信息
#pragma mark 评价
-(void)EvalutionGood:(NSInteger )selectOder_t{
    XZXMineOrderModel *Order_model = [self.dataArray objectAtIndex:selectOder_t];
    XZXEvalutionTVC *TVC = kStoryboradController(@"AfterSale", @"XZXEvalutionTVCID");
    
    NSMutableArray *array = [NSMutableArray array];
    for (XZXMineOrderGoodDetailModel *Model in Order_model.orderGoodsList) {
     
        //评价信息
        XZXEvalutionTVCModel *model = [XZXEvalutionTVCModel new];
        model.orderID = Model.orderId;
        model.EvalutionLevel = 5;
        model.EvalutionContent = @"";
        model.dataArray_Pic = [NSMutableArray array];
        model.anonymous = 0;
        model.evaluationState = Order_model.evaluationState;
        model.dataArray_Pic   = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"tianjiayinhangka"], nil];
        //商品信息
        model.GoodModel = Model;
        
        [array addObject:model];
    }
    TVC.dataArray = array;
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 发起售后
-(void)AfterSale:(NSInteger )selectOrder_t{
    
    XZXReturnAfterSaleDetail *TVC = kStoryboradController(@"Mine", @"XZXReturnAfterSaleDetailID");
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 查看详情
-(void)ViewDetailOrder:(NSInteger )seletOrder_t{
    XZXMineOrderModel *model = [self.dataArray objectAtIndex:seletOrder_t];

    if (self.index == AfterSaleBase) {
    
        XZXReturnAfterSaleDetail *VC = kStoryboradController(@"AfterSale", @"XZXReturnAfterSaleDetailID");
        XZXOrderDetailModel *GoodDetailModel = [XZXOrderDetailModel new];
        GoodDetailModel.orderId = model.orderId;
        VC.GoodDetailModel = GoodDetailModel;
        VC.goodmodel = [model.orderGoodsList objectAtIndex:0];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (model.orderState != CancelBase_service &&
        model.orderState != AfterSaleBase_service) {
        
    
        XZXOrderDetailVC *DetailVC = kStoryboradController(@"Mine", @"XZXOrderDetailVCID");
        DetailVC.OrderModel = model;
        [self.navigationController pushViewController:DetailVC animated:YES];
    }
}

#pragma mark 搜索订单
-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    [MBProgressHUD xh_showHudWithMessage:@"搜索" toView:self.view completion:^{
        
    }];
}

@end

