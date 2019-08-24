//
//  XZXOrderDetailVC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/9.
//  Copyright © 2019 zhu. All rights reserved.
//



#import "XZXOrderDetailVC.h"
#import "XZXPaymentOrder.h"
#import "XZXReturnMoneyTVC.h"
#import "XZXReturngoodsTVC.h"
#import "XZXReturnAfterSale.h"
#import "XZXReturnAfterSaleDetail.h"
#import "XZXPayResultVC.h"
#import "XZXTransportTVC.h"
#import "XZXEvalutionTVC.h"
#import "XZXStoreVC.h"
#import "LYPaymentAlertController.h"
#import "XZXRegisterVC.h"

#import "XZXOrderDetailModel.h"
#import "XZXEvalutionTVCModel.h"

#import "XZXMyOrderDetail_ReceinceAdressCell.h"
#import "XZXMyOrderDetail_goodCell.h"
#import "XZXMyOrderDetail_PaytypeCell.h"
#import "XZXReturnAfterSaleDetailCell.h"

@interface XZXOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource,XZXMyOrderDetail_goodCellDelegate,XZXReturnAfterSaleDetailCellDelegate,LYPaymentAlertControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *CustomerTableview;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *payMoney;
- (IBAction)PayMoney_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CancelOrder;
- (IBAction)CancelOrder_Action:(id)sender;

@property (nonatomic,strong) XZXOrderDetailModel *MyModel;



//红积分支付需要的参数

@property (nonatomic,strong) NSDictionary *redscore_order_data;
@property (nonatomic,copy)   NSString *redscore_url;
@property (nonatomic,strong) NSMutableDictionary *redscore_parameters;

@end

@implementation XZXOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.CustomerTableview.dataSource = self;
    self.CustomerTableview.delegate   = self;
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXMyOrderDetail_ReceinceAdressCell" bundle:nil] forCellReuseIdentifier:@"XZXMyOrderDetail_ReceinceAdressCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXMyOrderDetail_goodCell" bundle:nil] forCellReuseIdentifier:@"XZXMyOrderDetail_goodCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXMyOrderDetail_PaytypeCell" bundle:nil] forCellReuseIdentifier:@"XZXMyOrderDetail_PaytypeCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXReturnAfterSaleDetailCell" bundle:nil] forCellReuseIdentifier:@"XZXReturnAfterSaleDetailCellID"];
    self.bottomView.layer.borderWidth = 1.0;
    self.bottomView.layer.borderColor = kBackgroundColor.CGColor;
    
    self.CancelOrder.cornerRadius = 20.0;
    self.CancelOrder.layer.borderWidth = 1.0;
    self.CancelOrder.layer.borderColor = kBackgroundColor.CGColor;
    
    self.payMoney.cornerRadius = 20.0;
    self.payMoney.layer.borderWidth = 1.0;
    self.payMoney.layer.borderColor = [UIColor redColor].CGColor;
     self.bottomView.hidden = true;
    [self GetInformation];
}

-(void)GetInformation{


    [XHNetworking xh_postWithoutSuccess:@"orders/getOrderDetails" parameters:@{@"buyerId":@(kUser.member_id),@"token":kUser.token,@"orderId":self.OrderModel.orderId,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            self.MyModel = [XZXOrderDetailModel yy_modelWithJSON:responseObject.data];
            
            
            if (self.MyModel.orderState == 10) {
            
                self.bottomView.hidden = false;
            }
            
            [self.CustomerTableview reloadData];
        }
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    
   
}
#pragma mark UITableviewdelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = kBackgroundColor;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            return 70;
        }else{
            
            return UITableViewAutomaticDimension;
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            return 44;
        }else{
           return 140;
        }
    }else if (indexPath.section == 2 ||
              indexPath.section == 3){
        
        return 50;
    }else{
        
        return UITableViewAutomaticDimension;
    }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (![self.MyModel isKindOfClass:[XZXOrderDetailModel class]]) {
        
        return 0;
    }
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        //10:未付款 20:待发货 30:待收货 40:待评价
        switch (self.MyModel.orderState) {
            case 10:
            case 20:
            {
                return 2;
            }
                break;
            case 30:
            case 40:
            {
                return 3;
            }
                break;
            default:
                break;
        }
        return 0;
    }else if (section == 1){
        //商品列表
        return  self.MyModel.goodsList.count*2;
    }else if (section == 2){
        //商品信息统计
        if ([self.MyModel.crowdType isKindOfClass:[NSString class]]) {
            
            if ([self.MyModel.crowdType integerValue] == 3 ||
                [self.MyModel.crowdType integerValue] == 4) {
                
                return 5;
            }
        }
        return 3;
    }else if (section == 3){
        //支付方式
        if (self.MyModel.orderState == 10) {
           
            return 0;
        }else if (self.MyModel.orderState == 11 ||
                  self.MyModel.orderState == 12){
         //众筹商品 支付方式 + 项目进展
            return 2;
        }
        return 1;
    }else if (section == 4){
        
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //订单进展状态
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imageView.image = [UIImage imageNamed:@"img_2"];
            cell.textLabel.numberOfLines = 0;
             cell.textLabel.textColor = kThemeColor;
            if (self.MyModel.orderState == 10) {
                
                cell.imageView.image = [UIImage imageNamed:@"img_3"];
                cell.textLabel.text = @"等待买家付款";
                if ([self.MyModel.crowdType integerValue] == 5) {
                    
                    
                    
                    cell.textLabel.attributedText =  [NSString changestringArray:@[@"待付款\n",[NSString stringWithFormat:@"还剩%@自动确认",[XHTools ConvertStrToTime_receicve:[NSString stringWithFormat:@"%ld",[XHTools nsstringConversionNSDatehhmmss:@"2019-08-22 10:12:15"] + [self.MyModel.expireMinute integerValue]*60 - self.MyModel.serverTime]]]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"16.0",@"14.0"]];
                }
            }else if (self.MyModel.orderState == 20){
                
                cell.textLabel.attributedText = [NSString changestringArray:@[@"买家已付款"] colorArray:@[kThemeColor] fontArray:@[@"17.0"]];
            }else if (self.MyModel.orderState == 30){
              
                cell.imageView.image = [UIImage imageNamed:@"img_4"];
            cell.textLabel.attributedText =  [NSString changestringArray:@[@"商家已发货\n",self.MyModel.serverTime - self.MyModel.deliveryTime > 3600*10*24 ?@"系统自动收货":[NSString stringWithFormat:@"还剩%@自动确认",[XHTools ConvertStrToTime_receicve:[NSString stringWithFormat:@"%ld",3600*10*24 - (self.MyModel.serverTime - self.MyModel.deliveryTime)]]]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"16.0",@"14.0"]];
                
            }else if (self.MyModel.orderState == 40){
                cell.imageView.image = [UIImage imageNamed:@"img_1"];
                cell.textLabel.attributedText = [NSString changestringArray:@[@"交易成功"] colorArray:@[kThemeColor] fontArray:@[@"17.0"]];
            }else{
                
                cell.textLabel.text = @"";
            }
            cell.detailTextLabel.text = @"";
            cell.backgroundColor = [UIColor colorWithRed:226/255.0 green:187/255.0 blue:195/255.0 alpha:1];
            return cell;
            
        }else if (indexPath.row == 1){
            if(self.MyModel.orderState == 10 ||
               self.MyModel.orderState == 20){
                
                //收货地址
                XZXMyOrderDetail_ReceinceAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyOrderDetail_ReceinceAdressCellID" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.Adress_detail.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",self.MyModel.addressMessage],[NSString stringWithFormat:@"%@    ",self.MyModel.reciverName],[NSString stringWithFormat:@"    %@",self.MyModel.reciverPhone]] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor],[UIColor lightGrayColor]] fontArray:@[@"17.0",@"15.0",@"15.0"]];
                
                return cell;
                
            }else{
                
                //快递路线
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
                }

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.imageView.image = [UIImage imageNamed:@""];
                cell.backgroundColor = [UIColor whiteColor];
                cell.textLabel.text = @"\n快件已发出,点击查看详情\n";
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.textColor = kThemeColor;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = @"";
                return cell;
            }
            
        }else{
            //收货地址
            XZXMyOrderDetail_ReceinceAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyOrderDetail_ReceinceAdressCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.Adress_detail.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",self.MyModel.addressMessage],[NSString stringWithFormat:@"%@    ",self.MyModel.reciverName],[NSString stringWithFormat:@"    %@",self.MyModel.reciverPhone]] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor],[UIColor lightGrayColor]] fontArray:@[@"17.0",@"15.0",@"15.0"]];
           
            //cell.Adress_detail.text = self.MyModel.addressMessage;
            return cell;
            
        }
    }
    else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            //店铺名称
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imageView.image = [UIImage imageNamed:@"dianpu"];
            cell.textLabel.text = self.MyModel.storeName;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else{
            
            //商品列表
            XZXMyOrderDetail_goodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyOrderDetail_goodCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegte = self;
            cell.OrderDetailModel = self.MyModel;
            XZXMineOrderGoodDetailModel *model = [self.MyModel.goodsList objectAtIndex:indexPath.row-1];
            cell.OrderGoodDetailModel = model;
            //判断售后按钮状态
            cell.operationBtn.hidden = true;
            cell.operationBtn.cornerRadius = 5.0;
            cell.operationBtn.layer.borderWidth = 1.0;
            [cell.operationBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            cell.operationBtn.layer.borderColor = kThemeColor.CGColor;
            
            if (self.MyModel.orderState == 20 ||
                self.MyModel.orderState == 30 ||
                self.MyModel.orderState == 40) {
                
                /**
                 积分兑不能售后
                 积分购可以售后
                 */
                
                if ([self.MyModel.crowdType integerValue] == 4) {
                    
                    cell.operationBtn.hidden = true;
                }else{
                 
                    cell.operationBtn.hidden = false;
                }
                
                if (model.orderGoodsRefundStatus == 0) {
                    
                    if (self.MyModel.orderState == 20 ||
                        self.MyModel.orderState == 30) {
                        
                        [cell.operationBtn setTitle:@"退款" forState:UIControlStateNormal];
                    }else{
                        
                        if (model.evaluationState == 1) {
                            //已评价
                            cell.operationBtn.hidden = true;
                        }else{
                      
                              [cell.operationBtn setTitle:@"申请售后" forState:UIControlStateNormal];
                        }
                    }
                }else if (model.orderGoodsRefundStatus == 4){
                    
                    [cell.operationBtn setTitle:@"用户已撤销" forState:UIControlStateNormal];
                }else{
                    
                    if ([model.orderGoodsRefundSellerStratus integerValue] == 0) {
                        
                        [cell.operationBtn setTitle:@"审核中" forState:UIControlStateNormal];
                    }else if ([model.orderGoodsRefundSellerStratus integerValue] == 1){
                        
                        [cell.operationBtn setTitle:@"售后完成" forState:UIControlStateNormal];
                    }else if ([model.orderGoodsRefundSellerStratus integerValue] == 2){
                        
                        [cell.operationBtn setTitle:@"售后被拒绝" forState:UIControlStateNormal];
                    }
                }
            }
            
            
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row >= 0 && indexPath.row <= 5) {
         
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            cell.imageView.image = [UIImage imageNamed:@""];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell3"];
            }
            cell.backgroundColor = [UIColor whiteColor];
            if (indexPath.row == 0) {
                //总价 货币政策解决房价。降息，资产会上涨
                XZXMineOrderGoodDetailModel *model = [self.MyModel.goodsList objectAtIndex:0];
                cell.textLabel.text = [NSString stringWithFormat:@"共%ld件商品",self.MyModel.goodsList.count];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"小计:¥ %0.2f",[[NSString reviseString:model.goodsPrice] floatValue]*model.goodsNum];
            }
            else if (indexPath.row == 1){
                //邮费
                cell.textLabel.text = @"邮费";
                cell.detailTextLabel.text =[NSString stringWithFormat:@"小计:¥ %@",self.MyModel.shippingFee];
                
            }else if(indexPath.row == 2){
                //实际支付金额
                
                cell.detailTextLabel.attributedText = [NSString changestringArray:@[self.MyModel.orderState == 10 ? @"需付款   ":@"实际支付  ",[NSString stringWithFormat:@"¥ %@",self.MyModel.money]] colorArray:@[[UIColor blackColor],[UIColor redColor ]] fontArray:@[@"17.0",@"15.0"]];
                
            }else if (indexPath.row == 3){
                
                cell.textLabel.text = @"蓝积分";
                cell.detailTextLabel.text = [NSString stringWithFormat:@" - %@",self.MyModel.blueScore];
                cell.detailTextLabel.textColor = [UIColor hexStringToColor:@"4282eb"];
            }else{
                
                cell.textLabel.text = @"红积分";
                cell.detailTextLabel.text = [NSString stringWithFormat:@" - %@",self.MyModel.redScore];
                cell.detailTextLabel.textColor = kThemeColor;
            }
            
            return cell;
        }else{
            
            XZXReturnAfterSaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXReturnAfterSaleDetailCellID" forIndexPath:indexPath];
            cell.delegate = self;
            cell.CancelApplication.hidden = true;
            cell.EditApplication.hidden   = false;
            return cell;
        }
    }
    else if (indexPath.section == 3){
        
        //支付方式
        if (indexPath.row == 0) {
            
            XZXMyOrderDetail_PaytypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyOrderDetail_PaytypeCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            /**
             区分积分商品（支付方式多一个扣除积分）和其余商品
            **/
            if ([self.MyModel.payMethod isEqualToString:@"wxPay"] ||
                [self.MyModel.payMethod isEqualToString:@"wxpay"]) {
                
            }else if ([self.MyModel.payMethod isEqualToString:@"aliPay"] ||
                      [self.MyModel.payMethod isEqualToString:@"alipay"]){
                //支付宝
                cell.pay_type.text = @"支付宝";
                cell.pay_typeImage.image = [UIImage imageNamed:@"zhifubaozhifu"];
                
            }else if ([self.MyModel.payMethod isEqualToString:@"blueScorePay"]){
                
                cell.pay_type.text = @"蓝积分支付";
                cell.pay_typeImage.image = [UIImage imageNamed:@""];
            }else if ([self.MyModel.payMethod isEqualToString:@"redScorePay"]){
                
                cell.pay_type.text = @"红积分支付";
                cell.pay_typeImage.image = [UIImage imageNamed:@""];
            }
            return cell;
        }else{
         
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell5"];
            }
            
            
            if (![self.MyModel.crowdType isEqual:[NSNull class]]) {
                    cell.textLabel.text = @"项目进展";
                if ([self.MyModel.crowdType integerValue] == 1) {
                    
                    //一元众筹
                    if (self.MyModel.orderState == 11) {
                        //等待中
                        cell.detailTextLabel.text = @"待开奖";
                       
                    }else if(self.MyModel.orderState == 12){
                        //失败
                        cell.detailTextLabel.text = @"未中奖";
                       
                    }else if(self.MyModel.orderState != 10){
                        //成功
                          cell.detailTextLabel.text = @"已中奖";
                        
                    }
                }else if ([self.MyModel.crowdType integerValue] == 2){
                    
                    //全款支持
                    if (self.MyModel.orderState == 11) {
                        //等待中
                         cell.detailTextLabel.text = @"众筹中";
                       
                    }else if(self.MyModel.orderState == 12){
                        //失败
                         cell.detailTextLabel.text = @"众筹失败";
                       
                    }else if(self.MyModel.orderState != 10){
                        //成功
                         cell.detailTextLabel.text = @"众筹成功";
                       
                    }
                }
            }
            
            return cell;
        }
    }else{
        //其它
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell4"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:@""];
        cell.textLabel.numberOfLines = 0;

        NSString *order_sn_str = [NSString stringWithFormat:@"订单编号:%@",self.MyModel.orderId];
        NSString *add_time_str = [NSString stringWithFormat:@"创建时间:%@",self.MyModel.orderTime];
        NSString *pay_time = [NSString stringWithFormat:@"支付时间%@",self.MyModel.payTIme];
        
        if (self.MyModel.orderState == 10) {

            cell.textLabel.text = [NSString stringWithFormat:@"%@\n\n\n%@",order_sn_str,add_time_str];
        }else{
        
            NSString *pay_type = [NSString string];
            if ([self.MyModel.payMethod isEqualToString:@"wxPay"] ||
                [self.MyModel.payMethod isEqualToString:@"wxpay"]) {
                
                  pay_type = @"微信";
            }else if ([self.MyModel.payMethod isEqualToString:@"aliPay"] ||
                      [self.MyModel.payMethod isEqualToString:@"alipay"]){
                //支付宝
                pay_type = @"支付宝";
                
            }else if ([self.MyModel.payMethod isEqualToString:@"blueScorePay"]){
                
                pay_type = @"蓝积分支付";
                pay_time = @"";
            }else if ([self.MyModel.payMethod isEqualToString:@"redScorePay"]){
                
                pay_type = @"红积分支付";
                pay_time = @"";
            }
            
            NSString *pat_type_str = [NSString stringWithFormat:@"支付方式：%@",pay_type];
        
            cell.textLabel.text  = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n\n%@",order_sn_str,add_time_str,pat_type_str,pay_time];
        }
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"";
        return cell;
    }
}


#pragma mark 申请售后
-(void)didselectCell:(XZXMyOrderDetail_goodCell *)cell{

    NSIndexPath *indexPath = [self.CustomerTableview indexPathForCell:cell];
    NSLog(@"%ld",indexPath.row);
    
    XZXMineOrderGoodDetailModel *goodModel = [XZXMineOrderGoodDetailModel new];
    if (self.MyModel.goodsList.count > indexPath.row-1) {
        
        goodModel = self.MyModel.goodsList[indexPath.row-1];
    }


    
    if (self.MyModel.orderState == 20 ||
        self.MyModel.orderState == 30 ||
        self.MyModel.orderState == 40) {
        
        cell.operationBtn.hidden = false;
        
        
        if (goodModel.orderGoodsRefundStatus == 0) {
            
            if (self.MyModel.orderState == 20 ||
                self.MyModel.orderState == 30) {
                
                XZXReturnMoneyTVC *TVC = kStoryboradController(@"AfterSale",@"XZXReturnMoneyTVCID");
                                //将选中的商品信息传入
                    TVC.Finish = ^{
                        [self GetInformation];
                    };
                    TVC.tag = ReturnMoney;
            
                    TVC.DetailModel = self.MyModel;
                    TVC.goodmodel   = goodModel;
                    [self.navigationController pushViewController:TVC animated:YES];
            }else{
                
                //待评价-可申请售后（包括但不限于退货退款、退款、退货）
                XZXReturnAfterSale *TVC = kStoryboradController(@"AfterSale", @"XZXReturnAfterSaleID");
                TVC.Finish = ^{
                
                    [self GetInformation];
                };
                //将选中的商品信息传入
           
                TVC.DetailModel = self.MyModel;
                TVC.goodmodel   = goodModel;
                [self.navigationController pushViewController:TVC animated:YES];
            }
        }else if (goodModel.orderGoodsRefundStatus == 4){
            
         
            [MBProgressHUD xh_showHudWithMessage:@"用户主动撤销无法再次申请" toView:self.view completion:^{
                
            }];
        }else{
            
            if ([goodModel.orderGoodsRefundSellerStratus integerValue] == 0) {
                
            }else if ([goodModel.orderGoodsRefundSellerStratus integerValue] == 1){
                
                [cell.operationBtn setTitle:@"售后完成" forState:UIControlStateNormal];
            }else if ([goodModel.orderGoodsRefundSellerStratus integerValue] == 2){
                
                [cell.operationBtn setTitle:@"售后被拒绝" forState:UIControlStateNormal];
            }
            
            XZXReturnAfterSaleDetail *VC = kStoryboradController(@"AfterSale", @"XZXReturnAfterSaleDetailID");
             self.MyModel.money = [NSString stringWithFormat:@"%0.2f",[[NSString reviseString:goodModel.goodsPrice] floatValue]*goodModel.goodsNum*kUser.discount];
            VC.GoodDetailModel = self.MyModel;
            VC.goodmodel    = goodModel;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1 &&
        indexPath.section == 0){
        if(self.MyModel.orderState == 10 ||
           self.MyModel.orderState == 20){
        
        }else{
            //查看快递
            
            XZXTransportTVC *TVC = [[XZXTransportTVC alloc]initWithNibName:@"XZXTransportTVC" bundle:nil];
             TVC.order_num = self.MyModel.orderId;
             TVC.order_statu = self.MyModel.orderState;
            [self.navigationController pushViewController:TVC animated:YES];
            
        }
    }else if (indexPath.row == 0 &&
              indexPath.section == 1){
        
        //进入店铺
        XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
        VC.hidesBottomBarWhenPushed = YES;
        VC.storeId = self.MyModel.storeId;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark 评价商品

#pragma mark 立即支付 或 联系商家
- (IBAction)PayMoney_Action:(id)sender {
    
    if (self.MyModel.orderState == 10) {
        
        //立即支付
        XZXPaymentOrder *payment = [XZXPaymentOrder new];
        payment.order_data = [NSMutableDictionary dictionaryWithDictionary:@{@"money":[NSString stringWithFormat:@"%@",self.MyModel.money],@"orders":self.MyModel.outTradeNo}];
        [payment  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        payment.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        if ([self.MyModel.crowdType integerValue] == 3 ||
            [self.MyModel.crowdType integerValue] == 4) {
         
            payment.VC_type = HaveRecordPay;
        }
        payment.PaySuccessBlock = ^(NSDictionary * _Nonnull order_data) {
            
            XZXPayResultVC *ResultVC = [[XZXPayResultVC alloc]initWithNibName:@"XZXPayResultVC" bundle:nil];
            ResultVC.order_data = [NSMutableDictionary dictionaryWithDictionary:order_data];
            ResultVC.allMoney = [order_data valueForKey:@"money"];
        
            [self.navigationController pushViewController:ResultVC animated:YES];
        };
        
        payment.PayRedScoredBlock = ^(NSDictionary *order_data, NSString *url, NSMutableDictionary *parameters) {
            
            self.redscore_order_data = order_data;
            self.redscore_url        = url;
            self.redscore_parameters = parameters;
            [self PayRedScoredInputPassword];
        };
        [self presentViewController:payment animated:YES completion:^{
            
        }];
        
    }else if(self.MyModel.orderState == 40){
        //评价

        XZXEvalutionTVC *TVC = kStoryboradController(@"AfterSale", @"XZXEvalutionTVCID");
        
        NSMutableArray *array = [NSMutableArray array];
        for (XZXMineOrderGoodDetailModel *Model in self.MyModel.goodsList) {
            
            XZXEvalutionTVCModel *model = [XZXEvalutionTVCModel new];
            model.orderID = Model.orderId;
            model.EvalutionLevel = 5;
            model.EvalutionContent = @"";
            model.dataArray_Pic = [NSMutableArray array];
            model.anonymous = 0;
            model.evaluationState = self.MyModel.evaluationState;
            model.dataArray_Pic   = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"tianjiayinhangka"], nil];
            model.GoodModel = Model;
            [array addObject:model];
        }
        TVC.dataArray = array;
        [self.navigationController pushViewController:TVC animated:YES];
    }
}

/**
 红积分密码支付界面
 **/
-(void)PayRedScoredInputPassword{
    
    NSString *amount = [NSString stringWithFormat:@"¥ %@",[NSString reviseString:[self.redscore_order_data valueForKey:@"money"]]];
    NSString *remarks = @"";
    LYPaymentAlertController *paymentAlert =  [LYPaymentAlertController alertControllerWithTitle:@"请输入支付密码" numberOfCharacters:6];
    paymentAlert.contentOffset = CGSizeMake(0, 50);
    paymentAlert.headerView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds) * 0.8, 150)];
        // 金额
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.width, 100)];
        amountLabel.numberOfLines = 2;
        amountLabel.attributedText = ({
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:amount];
            [attributedString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:35.0], NSForegroundColorAttributeName: UIColor.blackColor} range:NSMakeRange(0, amount.length)];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:remarks]];
            [attributedString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:16.0], NSForegroundColorAttributeName: UIColor.blackColor} range:NSMakeRange(attributedString.length - remarks.length, remarks.length)];
            attributedString;
        });
        amountLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:amountLabel];
        // 选择银行卡
        UIButton *selectBankCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBankCardButton.frame = CGRectMake(0, amountLabel.bottom, headerView.width/2, 40);
        [selectBankCardButton setTitle:@"支付方式" forState:UIControlStateNormal];
        [selectBankCardButton setBackgroundColor:UIColor.whiteColor];
        //[selectBankCardButton setImage:[UIImage imageNamed:LoadPic] forState:UIControlStateNormal];
        [selectBankCardButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        selectBankCardButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        selectBankCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        selectBankCardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [headerView addSubview:selectBankCardButton];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(headerView.width/2, amountLabel.bottom, headerView.width/2-20, 40)];
        label.text = @"红积分";
        label.textAlignment = NSTextAlignmentRight;
        [headerView addSubview:label];
        headerView;
    });
    paymentAlert.footerView = ({
        // headerView footerView 的 origin，width设置为paymentAlert的width
        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds) * 0.8, 20)];
        resultLabel.textAlignment = NSTextAlignmentCenter;
        resultLabel.textColor = UIColor.redColor;
        resultLabel.font = [UIFont systemFontOfSize:11];
        resultLabel;
    });
    paymentAlert.delegate = self;
    
    
    [self presentViewController:paymentAlert animated:YES completion:^{
        
    }];
    
}



#pragma mark - LYPaymentAlertControllerDelegate

- (void)lYPaymentController:(LYPaymentAlertController *)paymentController securityTextOfCompeletion:(NSString *)securityText
{
    
    [self.redscore_parameters setObject:securityText forKey:@"memberPaypwd"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"text/*",@"application/octet-stream",@"application/zip"]];
    //[MBProgressHUD xh_showDeterminateHudWithMessage:@"正在生成支付订单" toView:self.view];
    [manager POST:self.redscore_url parameters:self.redscore_parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *orderStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [orderStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] ;
        
        if ([[dic valueForKey:@"code"] integerValue] == 200) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                //获取推荐商品ID
                XZXPayResultVC *ResultVC = [[XZXPayResultVC alloc]initWithNibName:@"XZXPayResultVC" bundle:nil];
                ResultVC.order_data = [NSMutableDictionary dictionaryWithDictionary:self.redscore_order_data];
                ResultVC.allMoney = [NSString stringWithFormat:@"%0.2f",[[self.redscore_order_data valueForKey:@"money"] floatValue]];
                [self.navigationController pushViewController:ResultVC animated:YES];
            }];
            
        }else if ([[dic valueForKey:@"code"] integerValue] == 401){
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还未设置红积分支付密码，是否马上去设置" preferredStyle:UIAlertControllerStyleAlert];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    XZXRegisterVC *vc = kStoryboradController(@"Login", @"XZXRegisterVCID");
                    vc.type = XZXCommomVCTypeEditPayPassword;
                    vc.memberPhone = kUser.account;
                    [self.navigationController pushViewController:vc animated:true];
                }]];
                
                [self presentViewController:alertVC animated:YES completion:^{
                    
                }];
            }];
        }else{
            
            
            NSString *errormsg = @"支付出错了，请稍后再试";
            if ([[dic valueForKey:@"errorMsg"] isKindOfClass:[NSString class]]) {
                if ([[dic valueForKey:@"errorMsg"] length] > 0) {
                    errormsg = [dic valueForKey:@"errorMsg"];
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
            
            UILabel *resultLabel = (UILabel *)paymentController.footerView;
            resultLabel.text = errormsg;
            resultLabel.textColor = UIColor.redColor;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark 取消订单
- (IBAction)CancelOrder_Action:(id)sender {
    
    if (self.MyModel.orderState == 10) {
     
        //取消订单
        [XHNetworking xh_postWithSuccess:@"orders/cancelOrder" parameters:@{@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"token":kUser.token,@"orderId":self.MyModel.orderId} success:^(XHResponse *responseObject) {
            
            
            [MBProgressHUD xh_showHudWithMessage:@"订单取消成功" toView:self.view completion:^{
                
            }];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }else if (self.MyModel.orderState == 40){
       
        //查看物流
    
        XZXTransportTVC *TVC = [[XZXTransportTVC alloc]initWithNibName:@"XZXTransportTVC" bundle:nil];
        TVC.order_num = self.MyModel.orderId;
        TVC.order_statu = self.MyModel.orderState;
        [self.navigationController pushViewController:TVC animated:YES];
    }
    
}

@end

