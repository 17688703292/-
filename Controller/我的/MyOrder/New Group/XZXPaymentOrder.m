//
//  XZXPaymentOrder.m
//  DoorLock
//
//  Created by RedSky on 2019/3/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXPaymentOrder.h"
#import "XZXMine_AdressListTVC.h"
#import <AlipaySDK/AlipaySDK.h>


#import "XZXPaymentOrderPayType_Cell2.h"
#import "XZXPaymentOrderPayType_Cell.h"
#import "XZXPaymentOrderSure_Cell.h"
#import "WXApi.h"


@interface XZXPaymentOrder ()<UITableViewDelegate,UITableViewDataSource,XZXPaymentOrderSure_CellDelegate>

@property (nonatomic,assign)NSInteger SelectPayType;//0选择微信，1选择支付宝 2红积分
@property (nonatomic,strong)UITableView *CustomerTableView;

@property (nonatomic,strong)NSMutableDictionary *parameters;
@property (nonatomic,copy) NSString *url;
@end

@implementation XZXPaymentOrder


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单";
    
    self.CustomerTableView = [[UITableView alloc]init];
    [self.view addSubview:self.CustomerTableView];
    [self.CustomerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(490);
    }];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXPaymentOrderPayType_Cell2" bundle:nil] forCellReuseIdentifier:@"XZXPaymentOrderPayType_Cell2ID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXPaymentOrderPayType_Cell" bundle:nil] forCellReuseIdentifier:@"XZXPaymentOrderPayType_CellID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXPaymentOrderSure_Cell" bundle:nil] forCellReuseIdentifier:@"XZXPaymentOrderSure_CellID"];
    self.CustomerTableView.delegate = self;
    self.CustomerTableView.dataSource = self;
    self.SelectPayType = 0;//默认选择微信支付
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kPaySuccessNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPaySuccessNotification object:nil];
    
}


#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }else if (section == 1){
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView *view = [UIView new];
        UIButton *delectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [delectBtn setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [view addSubview:delectBtn];
        [delectBtn addTarget:self action:@selector(DelectView) forControlEvents:UIControlEventTouchDown];
        
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3.0, 0, kScreenWidth/3.0, 60)];
        [view addSubview:title];
        title.text = @"确认付款";
        title.textAlignment = NSTextAlignmentCenter;
        
        return view;
    }else{
        
        UILabel *lable = [UILabel new];
        lable.text = @" 支付方式";
        lable.backgroundColor = kBackgroundColor;
        return lable;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else if(section == 1){
        
        if (self.VC_type == HaveRecordPay) {
            return 3;
        }else{
            return 2;
        }
    }else{
        
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        return 120;
    }else if(indexPath.section == 2){
        
        return 100;
    }else{
        
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        XZXPaymentOrderPayType_Cell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXPaymentOrderPayType_Cell2ID" forIndexPath:indexPath];
        cell.Price_label.attributedText = [NSString changestringArray:@[@"¥ ",[NSString reviseString:[self.order_data valueForKey:@"money"]]] colorArray:@[kThemeColor,[UIColor blackColor]] fontArray:@[@"20.0",@"40.0"]];
        return cell;
        
    }else if(indexPath.section == 1){
        
        XZXPaymentOrderPayType_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXPaymentOrderPayType_CellID" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            
            cell.pay_image.image = [UIImage imageNamed:@"weixinzhifu"];
            cell.pay_name.text   = @"微信";
            if (self.SelectPayType == 0) {
             
                  cell.pay_select.highlighted = YES;
            }else{
             
                  cell.pay_select.highlighted = false;
            }
            
        }else if(indexPath.row == 1){
            
            cell.pay_image.image = [UIImage imageNamed:@"zhifubaozhifu"];
            cell.pay_name.text   = @"支付宝";
            if (self.SelectPayType == 1) {
                
                cell.pay_select.highlighted = YES;
            }else{
                
                cell.pay_select.highlighted = false;
            }
        }else{
            
            cell.pay_image.image = [UIImage imageNamed:@"hongjifenzhifu"];
            cell.pay_name.text   = @"红积分(使用红积分抵扣)";
            if (self.SelectPayType == 2) {
                
                cell.pay_select.highlighted = YES;
            }else{
                
                cell.pay_select.highlighted = false;
            }
            
        }
        
        return cell;
        
    }else{
        
        XZXPaymentOrderSure_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXPaymentOrderSure_CellID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        self.SelectPayType = indexPath.row;
        [self.CustomerTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void)DelectView{
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.PayFairBlock) {
            
            self.PayFairBlock();
        }
    }];
}


#pragma mark XZXPaymentOrderSure_CellDeletate 支付

-(void)PayMoney{
  

    NSMutableString *orders = [NSMutableString string];
    if ([[self.order_data valueForKey:@"orders"] isKindOfClass:[NSArray class]]) {
        
        for (NSInteger j = 0; j < [[self.order_data valueForKey:@"orders"] count]; j++) {
            NSString *order = [[self.order_data valueForKey:@"orders"] objectAtIndex:j];
            if (j == [[self.order_data valueForKey:@"orders"] count] -1) {
                
                [orders appendFormat:@"%@",order];
            }else{
                
                [orders appendFormat:@"%@_",order];
            }
        }
    }else if([[self.order_data valueForKey:@"orders"] isKindOfClass:[NSString class]]){
        
        orders = [self.order_data valueForKey:@"orders"];
    }

   
    if (self.SelectPayType == 0) {
        
        [self requestAliPaySessionWith:orders orderType:@"1" payType:@"WeChat"];
    }else if(self.SelectPayType == 1){
        
        [self requestAliPaySessionWith:orders orderType:@"2" payType:@"AliPay"];
    }else{
        
        [self requestAliPaySessionWith:orders orderType:@"3" payType:@"RedScore"];
    }
}


- (void)requestAliPaySessionWith:(NSString *)orderNum orderType:(NSString *)type payType:(NSString *)payType {
    
    self.parameters = [NSMutableDictionary dictionary];
    [self.parameters setObject:@(kUser.member_id) forKey:@"userId"];
    [self.parameters setObject:kUser.token forKey:@"token"];
    [self.parameters setObject:orderNum forKey:@"outTradeNoStr"];
    
    if ([payType isEqualToString:@"WeChat"]) {
        
        [self.parameters setObject:@"2" forKey:@"type"];
    
    }else if([payType isEqualToString:@"AliPay"]){
        
        [self.parameters setObject:@"1" forKey:@"type"];
        
    }else if ([payType isEqualToString:@"RedScore"]){
        
        [self.parameters setObject:@"3" forKey:@"type"];
    }
    //4个8
           self.url = [NSString stringWithFormat:@"%@orders/buyGoods",LocalIP];//本地
         //    self.url = [NSString stringWithFormat:@"%@orders/buyGoods",TestServiceIP];//测试服
         //  self.url = @"http://www.ydmall.xyz/xmall-manager-web/orders/buyGoods";//正式服
    if ([payType isEqualToString:@"AliPay"]) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"text/*",@"application/octet-stream",@"application/zip"]];
        
        [MBProgressHUD xh_showDeterminateHudWithMessage:@"正在生成支付订单" toView:self.view];
        
        //NSString *urlStr = @"http://192.168.18.104:8888/orders/buyGoods";
       
        [manager POST:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            // 返回签名
            NSString *orderStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *jsonData = [orderStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] ;
            if ([[dic valueForKey:@"code"] integerValue] == 200) {
                
                [self.order_data setObject:[[dic valueForKey:@"data"] valueForKey:@"gcId"] forKey:@"gcId"];
                // 调用支付宝支付接口
                [[AlipaySDK defaultService] payOrder:[[dic valueForKey:@"data"] valueForKey:@"aliPay"] fromScheme:@"XZX.BigMarket" callback:^(NSDictionary *resultDic) {

                    if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                        // 支付成功
                        [self dismissViewControllerAnimated:YES completion:^{


                            //获取推荐商品ID
                           
                            if (self.PaySuccessBlock) {
                                
                                self.PaySuccessBlock(self.order_data);
                            }
                        }];
                    } else {
                        [MBProgressHUD xh_showHudWithMessage:@"支付失败" toView:self.view completion:^{
                            
                        }];
                   
                    }

                }];
            }else{
                
                NSString *errormsg = @"支付出错了，请稍后再试";
                if ([[dic valueForKey:@"errorMsg"] isKindOfClass:[NSString class]]) {
                    if ([[dic valueForKey:@"errorMsg"] length] > 0) {
                        errormsg = [dic valueForKey:@"errorMsg"];
                    }
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD xh_showHudWithMessage:errormsg toView:self.view completion:^{
                    
                }];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    } else if([payType isEqualToString:@"WeChat"]){
        

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"text/*",@"application/octet-stream",@"application/zip"]];
        [MBProgressHUD xh_showDeterminateHudWithMessage:@"正在生成支付订单" toView:self.view];
        [manager POST:self.url parameters:self.parameters   progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // 返回签名
            NSString *orderStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSData *jsonData = [orderStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] ;
            
            if ([[dic valueForKey:@"code"] integerValue] == 200) {
                
                NSDictionary *wechat_pay = [[dic valueForKey:@"data"] valueForKey:@"wxPay"];
                if ([[[dic valueForKey:@"data"] allKeys] containsObject:@"gcId"]) {
                    
                    [self.order_data setObject:[[dic valueForKey:@"data"] valueForKey:@"gcId"] forKey:@"gcId"];
                }
                // 解析结果
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = wechat_pay[@"partnerid"];
                request.prepayId = wechat_pay[@"prepayid"];
                request.package = @"Sign=WXPay";
                request.nonceStr = wechat_pay[@"noncestr"];
                request.sign= wechat_pay[@"sign"];
                request.timeStamp = (UInt32)[wechat_pay[@"timestamp"] longLongValue];
                request.openID = wechat_pay[@"appid"];
                
                
                [WXApi sendReq:request];
            
            }else{
                
                NSString *errormsg = @"支付出错了，请稍后再试";
                if ([[dic valueForKey:@"errorMsg"] isKindOfClass:[NSString class]]) {
                    if ([[dic valueForKey:@"errorMsg"] length] > 0) {
                        errormsg = [dic valueForKey:@"errorMsg"];
                    }
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD xh_showHudWithMessage:errormsg toView:self.view completion:^{
                    
                }];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }];
    }else{
        //红积分支付
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self dismissViewControllerAnimated:YES completion:^{
        
            if (self.PayRedScoredBlock) {
                self.PayRedScoredBlock(self.order_data, self.url, self.parameters);
            }
           
        }];
    }
}



#pragma makr 支付成功回调
- (void)paySuccess:(NSNotification *)notification {
    NSLog(@"%@----------result",notification.object);
    
    
    if ([notification.object isKindOfClass:[NSString class]]) {
        
        if ([notification.object intValue] == 0) {
            // 支付成功
            // 支付成功展示
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                //获取推荐商品ID
               
                if (self.PaySuccessBlock) {
                    
                    self.PaySuccessBlock(self.order_data);
                }
            }];
        } else {
            [MBProgressHUD xh_showHudWithMessage:@"支付失败" toView:self.view completion:^{
                
            }];
            
        }
        return;
    } else if ([notification.object isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = notification.object;
        
        if ([dic[@"resultStatus"] integerValue] == 9000) {
            // 支付成功
            // 支付成功展示
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                
                //获取推荐商品ID
               
                if (self.PaySuccessBlock) {
                    
                    self.PaySuccessBlock(self.order_data);
                }
            }];
        } else {
            [MBProgressHUD xh_showHudWithMessage:@"支付失败" toView:self.view completion:^{
                
            }];
            
        }
        
        
    } else {
        [MBProgressHUD xh_showHudWithMessage:@"支付失败" toView:self.view completion:^{
            
        }];
    }
}


@end
