//
//  XZXReturnAfterSaleDetail.m
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXReturnAfterSaleDetail.h"
#import "XZXMineOrderBaseTVC.h"
#import "XZXMineOrderVC.h"
#import "XZXAfterSale.h"
#import "XZXReturnMoneyTVC.h"
#import "XZXReturngoodsTVC.h"
#import "XZXSignalInputTextFieldTC.h"
#import "XZXReturngood_SubmissionNumberVC.h"


#import "XZXReturnAfterSaleDetailCell.h"
#import "XZXMine_goodCell.h"

//售后详情
#import "XZXMineAfterSaleDetailModel.h"

@interface XZXReturnAfterSaleDetail ()<UITableViewDelegate,UITableViewDataSource,XZXReturnAfterSaleDetailCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *CustomerTableview;
- (IBAction)ContactStore_Action:(id)sender;

@property (nonatomic,copy)NSString *Logistics_company;//物流公司
@property (nonatomic,copy)NSString *orderNum_company;//物流编号
@property (nonatomic,strong)XZXMineAfterSaleDetailModel *MyModel;
@end

@implementation XZXReturnAfterSaleDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"售后详情";
    
    self.CustomerTableview.dataSource = self;
    self.CustomerTableview.delegate   = self;
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXReturnAfterSaleDetailCell" bundle:nil] forCellReuseIdentifier:@"XZXReturnAfterSaleDetailCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXMine_goodCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_goodCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXSignalInputTextFieldTC" bundle:nil] forCellReuseIdentifier:@"XZXSignalInputTextFieldTCID"];
    self.CustomerTableview.tableFooterView = [UIView new];
    self.CustomerTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self GetInformation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZXAfterSale class]]) {
            
            [self.navigationController popToViewController:VC animated:YES];
            return;
        }else if ([VC isKindOfClass:[XZXMineOrderVC class]]){
            
            [self.navigationController popToViewController:(XZXMineOrderVC *)VC animated:YES];
            return;
        }else if ([VC isKindOfClass:[XZXMineOrderBaseTVC class]]){
            
            
            [self.navigationController popToViewController:(XZXMineOrderBaseTVC *)VC animated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GetInformation{
    
    [XHNetworking xh_postWithSuccess:@"orders/getRefundOrderGood" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"orderId":self.GoodDetailModel.orderId,@"goodsId":self.goodmodel.goodsId,@"recId":self.goodmodel.recId} success:^(XHResponse *responseObject) {
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            self.MyModel = [XZXMineAfterSaleDetailModel yy_modelWithJSON:responseObject.data];
            
            if ([self.MyModel.orderGoodsRefundSellerStratus integerValue] == 1) {
                
                if ([self.MyModel.orderGoodsRefundStatus integerValue] == 3) {
                 
                    [self GetInformation_statu];
                }
            }
            [self.CustomerTableview reloadData];
        }
    }];
}

-(void)GetInformation_statu{
    
    [XHNetworking xh_postWithoutSuccess:@"refundReturn/getDataById" parameters:@{@"orderId":self.GoodDetailModel.orderId,@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        //refundState 1处理中 3已同意
        switch ([[responseObject.data valueForKey:@"state"] integerValue]) {
            case 2:
                {
                    //未提交运单号
                     [self addRightItemWithTitle:@"提交快递单号" titleColor:[UIColor whiteColor]];
                    
                }
                break;
            case 1:
            {
                //已经提交运单号
                 self.MyModel.orderGoodsRefundSellerStratus = @"100";
                [self.CustomerTableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
                break;
            default:
                break;
        }
   
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 2;
    }else if (section == 1){
     
        return 3;
    }else{
        
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 110;
        }
        return UITableViewAutomaticDimension;
    }else if (indexPath.section == 1){
        if (indexPath.row == 2) {
            return 50;
        }
        return UITableViewAutomaticDimension;
    }else{
        if (indexPath.row == 0) {
            return 50;
        }else if (indexPath.row ==1){
            return 120;
        }else{
            return UITableViewAutomaticDimension;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor colorWithRed:253/255.0 green:216/255.0 blue:216/255.0 alpha:1];
             cell.textLabel.textColor = kThemeColor;
             cell.textLabel.numberOfLines = 0;
            switch ([self.MyModel.orderGoodsRefundSellerStratus integerValue]) {
                case 0:
                    {
                        cell.textLabel.text = [NSString stringWithFormat:@"请等待商家处理\n%@",[XHTools ConvertStrToTime_receicve:[NSString stringWithFormat:@"%ld",3600*10*24 - [XHTools dateRemaining:self.MyModel.refundTime]]]];
                    }
                    break;
                case 1:
                {
                     if ([self.MyModel.orderGoodsRefundStatus integerValue] == 3) {
                         
                      
                         cell.textLabel.text  = @"商家已同意您的申请,请提交您的运单号";
                     }else{
                    
                         
                         cell.textLabel.text = @"商家已同意您的退款申请";
                     }
                }
                    break;
                case 2:
                {
                    cell.textLabel.text  = @"您的申请已被商家拒绝\n如有疑问可点击下方按钮联系我们";
                }
                    break;
                case 100:
                {
                    cell.textLabel.text = @"运单号已提交成功，商家收到货物并确认后，将会重新给您发货";
                }
                    break;
                default:
                    break;
            }
            
            if ([self.MyModel.orderGoodsRefundStatus integerValue] == 4) {
           
                cell.textLabel.text  = @"您已撤销了售后申请";
            }
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.numberOfLines = 0;
            //cell.textLabel.text  = @"您的每一个申请我们都会认真审核评估\n如有疑问请点击下方按钮联系我们";
            cell.textLabel.text  =@"";
        }
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row ==2) {
            
            XZXReturnAfterSaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXReturnAfterSaleDetailCellID" forIndexPath:indexPath];
            cell.delegate = self;
            
            switch ([self.MyModel.orderGoodsRefundSellerStratus integerValue]) {
                case 0:
                {
                    cell.CancelApplication.hidden = false;
                    cell.EditApplication.hidden = false;
                }
                    break;
                case 1:
                {
                    cell.CancelApplication.hidden = true;
                    cell.EditApplication.hidden = true;
                }
                    break;
                case 2:
                {
                    cell.CancelApplication.hidden = true;
                    cell.EditApplication.hidden = false;
                    
                    
                }
                    break;
                default:
                    break;
            }
            
            
            if ([self.MyModel.orderGoodsRefundStatus integerValue] == 4) {
                
                cell.CancelApplication.hidden = true;
                cell.EditApplication.hidden = true;
            }
            return cell;
        }else{
            
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
             
              
            }
            
            cell.imageView.image = [UIImage imageNamed:@"xuanzhong_hong"];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"商家同意或超时处理，系统会退款给您";
            }else{
                cell.textLabel.text = @"如果商家拒绝，您可以修改退款申请后再次发起，商家会重新处理";
            }
            return cell;
        }
    }
//    else if(indexPath.section == 2){
//        XZXSignalInputTextFieldTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXSignalInputTextFieldTCID" forIndexPath:indexPath];
//        if (indexPath.row == 0) {
//            
//            [cell.signalInputText creatLeftTitle:@"物流公司："];
//         
//        }else{
//            
//            [cell.signalInputText creatLeftTitle:@"物流单号："];
//        }
//        cell.InputTextField = ^(NSString * _Nonnull contentStr, XZXSignalInputTextFieldTC * _Nonnull cellBlock) {
//          
//            NSIndexPath *Index_Block = [self.CustomerTableview indexPathForCell:cellBlock];
//            if (Index_Block.row == 0) {
//                
//                self.Logistics_company = contentStr;
//            }else{
//                
//                self.orderNum_company = contentStr;
//            }
//        };
//        return cell;
//    }
    else{
        if (indexPath.row == 0) {
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
            }
            
            cell.textLabel.text = @"售后信息";
            return cell;
            
        }else if (indexPath.row == 1) {
            //商品详情
            XZXMine_goodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_goodCellID" forIndexPath:indexPath];
            cell.goodName.numberOfLines = 0;
            cell.goodContent.numberOfLines = 0;
            cell.backgroundColor = kBackgroundColor;
            cell.goodName.text = self.goodmodel.goodsName;
            cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.goodmodel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",self.goodmodel.goodsScore]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"17.0",@"15.0"]];
            [cell.goodImage sd_setImageWithURL:kImageUrl(self.goodmodel.storeId,self.goodmodel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
            return cell;
        }else{
            //订单信息
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
            }
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            if (self.MyModel != nil) {
                
            
                NSMutableArray *muarray_str = [NSMutableArray array];
                if ([self.MyModel.orderGoodsRefundStatus integerValue] == 1) {
                    [muarray_str addObject:[NSString stringWithFormat:@"退款原因：%@\n\n",self.MyModel.orderGoodsRefundReason]];
                    
                    if ([self.MyModel.crowdType integerValue] == 3) {
                        //积分购物
                        if ([self.MyModel.redScore integerValue] > 0) {
                        
                            //红积分支付
                            [muarray_str addObject:[NSString stringWithFormat:@"返还红积分：%@\n\n",self.MyModel.redScore]];
                            [muarray_str addObject:[NSString stringWithFormat:@"返还蓝积分：%@\n\n",self.MyModel.blueScore]];
                            
                        }else{
                            
                            [muarray_str addObject:[NSString stringWithFormat:@"退款金额：¥ %@\n\n",self.MyModel.orderGoodsRefundMoney]];
                            [muarray_str addObject:[NSString stringWithFormat:@"返还蓝积分：%@\n\n",self.MyModel.blueScore]];
                        }
                        
                    }else if ([self.MyModel.crowdType integerValue] == 4){
                        
                        //积分兑换
                        [muarray_str addObject:[NSString stringWithFormat:@"返还蓝积分：%@\n\n",self.MyModel.goodsScore]];
                    }else{
                        
                        //普通
                        [muarray_str addObject:[NSString stringWithFormat:@"退款金额：¥ %@\n\n",self.MyModel.orderGoodsRefundMoney]];
                        [muarray_str addObject:[NSString stringWithFormat:@"扣除积分：%@\n\n",self.MyModel.goodsScore]];
                    }
                    
                    
                }else if([self.MyModel.orderGoodsRefundStatus integerValue] == 2){
                    
                    [muarray_str addObject:[NSString stringWithFormat:@"退货退款原因：%@\n\n",self.MyModel.orderGoodsRefundReason]];
                    [muarray_str addObject:[NSString stringWithFormat:@"退款金额：¥%@\n\n",self.MyModel.orderGoodsRefundMoney]];
                    
                }else{
                    [muarray_str addObject:[NSString stringWithFormat:@"换货原因：%@\n\n",self.MyModel.orderGoodsRefundReason]];
                    
                }
                
                [muarray_str addObject:[NSString stringWithFormat:@"退款编号：%@\n\n",self.MyModel.refundOrder]];
                
                NSMutableArray *muarray_color = [NSMutableArray array];
                NSMutableArray *muarray_font  = [NSMutableArray array];
                for (NSString *str in muarray_str) {
                    [muarray_font addObject:@"15.0"];
                    [muarray_color addObject:[UIColor lightGrayColor]];
                }
                
                cell.textLabel.attributedText = [NSString changestringArray:muarray_str colorArray:muarray_color fontArray:muarray_font];
            }
            return cell;
        }
    }
}



#pragma mark 撤销申请

-(void)left_Action{
    
    //撤销申请
    [XHNetworking xh_postWithoutSuccess:@"orders/cancelRefundOrderGood" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"recId":self.goodmodel.recId,@"orderId":self.GoodDetailModel.orderId,@"goodsId":self.goodmodel.goodsId} success:^(XHResponse *responseObject) {
        
        for (UIViewController *VC in self.navigationController.viewControllers) {
            if ([VC isKindOfClass:[XZXMineOrderVC class]]) {
                
                [self.navigationController popToViewController:(XZXMineOrderVC *)VC animated:YES];
            }else if ([VC isKindOfClass:[XZXMineOrderBaseTVC class]]){
                
                [self.navigationController popToViewController:(XZXMineOrderBaseTVC *)VC animated:YES];
            }
        }
    }];
}


-(void)Right_Action:(XZXReturnAfterSaleDetailCell *)cell{
    
   
        if ([self.MyModel.orderGoodsRefundStatus integerValue] == 1) {
            XZXReturnMoneyTVC *tvc = kStoryboradController(@"AfterSale", @"XZXReturnMoneyTVCID");
            tvc.hidesBottomBarWhenPushed = YES;
            tvc.goodmodel = self.goodmodel;
            self.GoodDetailModel.money = self.MyModel.orderGoodsRefundMoney;
            tvc.DetailModel = self.GoodDetailModel;
            tvc.tag =  ReturnMoney;
            tvc.RMVC_Type = Edit_RGAfterSale;
            NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
            [mudic setObject:self.MyModel.orderGoodsRefundReason forKey:@"pro_statu"];
            [mudic setObject:self.MyModel.orderGoodsRefundReason forKey:@"Return_reason"];
            [mudic setObject:self.MyModel.orderGoodsRefundExplain forKey:@"orderGoodsRefundExplain"];
            tvc.RMVC_Model = mudic;
            [self.navigationController pushViewController:tvc animated:YES];
            
        }else if ([self.MyModel.orderGoodsRefundStatus integerValue] == 2){
            XZXReturnMoneyTVC *tvc = kStoryboradController(@"AfterSale", @"XZXReturnMoneyTVCID");
            tvc.hidesBottomBarWhenPushed = YES;
            tvc.goodmodel = self.goodmodel;
            self.GoodDetailModel.money = self.MyModel.orderGoodsRefundMoney;
            tvc.DetailModel = self.GoodDetailModel;
            tvc.tag =  ReturnMoneyAndGood;
            tvc.RMVC_Type = Edit_RMAfterSale;
            NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
            [mudic setObject:self.MyModel.orderGoodsRefundReason forKey:@"pro_statu"];
            [mudic setObject:self.MyModel.orderGoodsRefundReason forKey:@"Return_reason"];
            [mudic setObject:self.MyModel.orderGoodsRefundExplain forKey:@"orderGoodsRefundExplain"];
            tvc.RMVC_Model = mudic;
            [self.navigationController pushViewController:tvc animated:YES];
            
        }else if ([self.MyModel.orderGoodsRefundStatus integerValue] == 3){
           
            XZXReturngoodsTVC *tvc = kStoryboradController(@"AfterSale", @"XZXReturngoodsTVCID");
            tvc.hidesBottomBarWhenPushed = YES;
            tvc.goodmodel = self.goodmodel;
            self.GoodDetailModel.money = self.MyModel.orderGoodsRefundMoney;
            tvc.DetailModel = self.GoodDetailModel;
            tvc.RGVC_Type = Edit_RGAfterSale;
            NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
            [mudic setObject:self.MyModel.orderGoodsRefundReason forKey:@"pro_statu"];
            [mudic setObject:self.MyModel.orderGoodsRefundReason forKey:@"Return_reason"];
            [mudic setObject:self.MyModel.orderGoodsRefundExplain forKey:@"orderGoodsRefundExplain"];
            tvc.RGVC_Model = mudic;
            
            [self.navigationController pushViewController:tvc animated:YES];
        }
}

- (IBAction)ContactStore_Action:(id)sender {
    
    
    [XHNetworking xh_postWithoutSuccess:@"store/getStoreDetails" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"storeId":self.MyModel.storeId} success:^(XHResponse *responseObject) {
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject.data valueForKey:@"storePhone"] isKindOfClass:[NSString class]]) {
                if ([[responseObject.data valueForKey:@"storePhone"] length] > 0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[responseObject.data valueForKey:@"storePhone"]]]];
                }
            }else{
                
                [MBProgressHUD xh_showHudWithMessage:@"商家未预留电话" toView:self.view completion:^{
                    
                }];
            }
        }
    }];
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    XZXReturngood_SubmissionNumberVC *VC = kStoryboradController(@"AfterSale", @"XZXReturngood_SubmissionNumberVCID");
    VC.orderId = self.GoodDetailModel.orderId;
    [self.navigationController pushViewController:VC animated:YES];
}
@end
