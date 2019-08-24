//
//  XZXShopGood_UploadOrderVC.m
//  DoorLock
//
//  Created by RedSky on 2019/3/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopGood_UploadOrderVC.h"
#import "XZXMine_AdressListTVC.h"
#import "XZXMine_EditAdressTVC.h"
#import "XZXPaymentOrder.h"
#import "XZXPayResultVC.h"
#import "LYPaymentAlertController.h"
#import "XZXRegisterVC.h"

#import "XZXPaymentOrder_AdressCell.h"
#import "XZXShopOrderDetail_good2Cell.h"
#import "XZXShopOrderDetail_goodCell.h"
#import "XZXShopGoodsDetailImage.h"

#import "XZXShopCarListheadCell.h"


#import "XZXShopGood_UploadOrderModel.h"

@interface XZXShopGood_UploadOrderVC ()<UITableViewDelegate,UITableViewDataSource,LYPaymentAlertControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *CustomerTableview;
- (IBAction)UploadOrder_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;//总价 商品价格+邮费
@property (nonatomic,strong)XZXShopGood_UploadOrderModel *MyModel;


@property (nonatomic,strong)XZXShopCarListheadCell *headCell;//商店名称


//红积分支付需要的参数

@property (nonatomic,strong) NSDictionary *redscore_order_data;
@property (nonatomic,copy)   NSString *redscore_url;
@property (nonatomic,strong) NSMutableDictionary *redscore_parameters;


@end



@implementation XZXShopGood_UploadOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXPaymentOrder_AdressCell" bundle:nil] forCellReuseIdentifier:@"XZXPaymentOrder_AdressCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXShopOrderDetail_good2Cell" bundle:nil] forCellReuseIdentifier:@"XZXShopOrderDetail_good2CellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXShopOrderDetail_goodCell" bundle:nil] forCellReuseIdentifier:@"XZXShopOrderDetail_goodCellID"];
    [self.CustomerTableview registerNib:[UINib nibWithNibName:@"XZXShopGoodsDetailImage" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodsDetailImageID"];
    self.CustomerTableview.dataSource = self;
    self.CustomerTableview.delegate   = self;
    self.CustomerTableview.tableFooterView = [UIView new];
    self.view.backgroundColor = kBackgroundColor;

    [self Get_orderInformation];
}

-(NSMutableArray *)GuiGe_Array{
    if (!_GuiGe_Array) {
        _GuiGe_Array = [NSMutableArray array];
    }
    return _GuiGe_Array;
}

-(void)Get_orderInformation{

    NSString *url = [NSString string];
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.UploadOrder_type == CarList) {
        url = @"cart/getCartByCartId";
        dic =  @{@"token":kUser.token,@"userId":@(kUser.member_id),@"cartIdStr":self.paramete_id,@"buyerId":@(kUser.member_id)};
    }else if(self.UploadOrder_type == Good_Order ||
             self.UploadOrder_type == Actity_ZY ||
             self.UploadOrder_type == Actity_MS ||
             self.UploadOrder_type == Actity_TG ||
             self.UploadOrder_type == Actity_Agent ||
             self.UploadOrder_type == Actity_JF){
        
        url = @"orders/getGoodsStatement";
        dic =  @{@"token":kUser.token,@"userId":@(kUser.member_id),@"goodsId":self.CommonModel.goodsId,@"buyerId":@(kUser.member_id),@"goodsNum":@(self.CommonModel.goodnum)};
    }else if (self.UploadOrder_type == Actity_ZC){
        
        url = @"activitys/getGoodsStatement";
        dic = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"goodsId":self.CommonModel.goodsId,@"buyerId":@(kUser.member_id),@"crowdType":@(self.ZC_type),@"goodsNum":@(self.CommonModel.goodnum)};
    }
    [XHNetworking xh_postAlwaysWithResponse:url parameters:dic showIndicator:YES response:^(XHResponse *responseObject) {
  
         /**
            1、判断有没有默认地址，如果没有跳转到地址管理页面          */
        if (responseObject.code == 200) {
            if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
                
                if ([[responseObject.data valueForKey:@"address"] isKindOfClass:[NSNull class]]) {
                    
                    UIAlertController *AC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还没有设置货地址，请先设置" preferredStyle:UIAlertControllerStyleAlert];
                    [AC addAction:[UIAlertAction actionWithTitle:@"暂时不，继续浏览" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }]];
                    
                    [AC addAction:[UIAlertAction actionWithTitle:@"好的，去添加收货地址" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        //跳转到添加地址界面
                        
                        XZXMine_EditAdressTVC * TVC = [XZXMine_EditAdressTVC new];
                        TVC.type = AddAdressForOrder;
                        TVC.AddAdressForOrderBlock = ^{
                            
                            [self Get_orderInformation];
                            
                        };
                        [self.navigationController pushViewController:TVC animated:YES];
                        
                        
                    }]];
                    
                    [self presentViewController:AC animated:YES completion:^{
                        
                    }];
                    
                }else{
                    /**
                     2、有收货地址
                     */
                    
                    if (self.UploadOrder_type == CarList) {
                        
                        //购物车进入从云端获取商品信息
                        
                        self.MyModel = [XZXShopGood_UploadOrderModel yy_modelWithJSON:responseObject.data];
                        
                        for (XZXShopGood_UploadOrder_GoodModel *TempModel in self.MyModel.cart) {
                            
                            self.MyModel.payMoney_f += [[NSString reviseString:TempModel.goodsPrice] floatValue]*[TempModel.goodsNum integerValue] + [TempModel.shippingFee floatValue];
                        }
                        self.MyModel.payMoney_f = self.MyModel.payMoney_f*kUser.discount;
                    }else{
                        
                        //商品详情从本地获取商品信息
                        
                        XZXMine_AreaListModel *addreModel = [XZXMine_AreaListModel yy_modelWithJSON:responseObject.data];
                        
                        XZXShopGood_UploadOrder_GoodModel *GoodModel = [XZXShopGood_UploadOrder_GoodModel yy_modelWithJSON:responseObject.data];
                        GoodModel.buyerMessage = @"";
                        //个数
                        GoodModel.goodsNum = [NSString stringWithFormat:@"%ld",self.CommonModel.goodnum];
                        //规格
                        
                        GoodModel.GuiGe_array = self.GuiGe_Array;
                        
                        NSMutableString *guige_str = [NSMutableString string];
                        for (NSInteger j =0; j < self.GuiGe_Array.count ; j++ ) {
                            XZXShopGoodSelectGuiGeModel *GuiGeModel = [self.GuiGe_Array objectAtIndex:j];
                            if (j == self.GuiGe_Array.count - 1) {
                                [guige_str appendString:[NSString stringWithFormat:@"%@",GuiGeModel.spValueName]];
                            }else{
                                
                                [guige_str appendString:[NSString stringWithFormat:@"%@ + ",GuiGeModel.spValueName]];
                            }
                        }
                        
                        GoodModel.GuiGe_str = [NSMutableString stringWithString:guige_str];
                        
                        self.MyModel = [XZXShopGood_UploadOrderModel new];
                        self.MyModel.address = addreModel;
                        self.MyModel.cart = [NSMutableArray arrayWithObjects:GoodModel, nil];
                        self.MyModel.goodsFreight = [[responseObject.data valueForKey:@"goodsFreight"] isKindOfClass:[NSNull class]] ? @"0" :[responseObject.data valueForKey:@"goodsFreight"];
                        
                        CGFloat goodprice_f = [[NSString reviseString:GoodModel.goodsPrice] floatValue];
                        if (GoodModel.goodsPromotionType == 20 ||
                            GoodModel.goodsPromotionType == 30 ||
                            GoodModel.goodsPromotionType == 60) {
                            
                            goodprice_f = [[NSString reviseString:GoodModel.goodsPromotionPrice] floatValue];
                        }
                        self.MyModel.payMoney_f = goodprice_f*self.CommonModel.goodnum*kUser.discount + [self.MyModel.goodsFreight floatValue];
                    }
                    
                    
                    
                    self.pricelabel.text = [NSString stringWithFormat:@"合计：¥ %0.2f",self.MyModel.payMoney_f];
                    [self.CustomerTableview reloadData];
                  
                }
        
            }

        }else if (responseObject.code == 1019){
            //无收货地址
                UIAlertController *AC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还没有设置货地址，请先设置" preferredStyle:UIAlertControllerStyleAlert];
                [AC addAction:[UIAlertAction actionWithTitle:@"暂时不，继续浏览" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                
                [AC addAction:[UIAlertAction actionWithTitle:@"好的，去添加收货地址" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    //跳转到添加地址界面
                    
                    XZXMine_EditAdressTVC * TVC = [XZXMine_EditAdressTVC new];
                    TVC.type = AddAdressForOrder;
                    TVC.AddAdressForOrderBlock = ^{
                        
                        [self Get_orderInformation];
                        
                    };
                    [self.navigationController pushViewController:TVC animated:YES];
                    
                    
                }]];
                
                [self presentViewController:AC animated:YES completion:^{
                    
                }];
        }
    }];
}

-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.UploadOrder_type == CarList) {
        //从购物车进入返回时刷新购物车
        if (self.GetFirstPageInformation) {
            self.GetFirstPageInformation();
        }
    }
}


#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    if (section != 1) {
        return 0;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    self.headCell = [[[NSBundle mainBundle] loadNibNamed:@"XZXShopCarListheadCell" owner:nil options:nil]firstObject];
    [self.headCell.SelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
    }];
    if (section > 0) {
        
        XZXShopGood_UploadOrder_GoodModel *goodModel = [self.MyModel.cart objectAtIndex:section-1];
        self.headCell.storeName.attributedText = [NSString changestringArray:@[goodModel.storeName,@"   >"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"16.0",@"14.0"]];
    }
    return self.headCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    if (section == 1) {
        return 20;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    UIImageView *backimage = [UIImageView new];
   
    if (section == 0) {
        backimage.image = [UIImage imageNamed:@"fenge"];
        backimage.contentMode = UIViewContentModeScaleToFill;
    }
    backimage.backgroundColor = kBackgroundColor;
    return backimage;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        
        return UITableViewAutomaticDimension;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 120;
        }else{
            
            return 50;
        }
    }else{
        
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.MyModel == nil) {
        return 0;
    }
    if (self.UploadOrder_type == Actity_JF) {
        
        return 2 + self.MyModel.cart.count;
        
    }else{
     
        return 1 + self.MyModel.cart.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 3;
    }else{
        
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        XZXPaymentOrder_AdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXPaymentOrder_AdressCellID" forIndexPath:indexPath];
        cell.MyModel = self.MyModel.address;
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            //商品详情
            XZXShopOrderDetail_goodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopOrderDetail_goodCellID" forIndexPath:indexPath];
            
            cell.MyModel = self.MyModel.cart[indexPath.section-1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        else if (indexPath.row == 1){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"配送金额";
            if (self.UploadOrder_type == CarList) {
      
                XZXShopGood_UploadOrder_GoodModel *model = self.MyModel.cart[indexPath.section-1];
                cell.detailTextLabel.text = [model.shippingFee integerValue] == 0 ? @"免邮": [NSString stringWithFormat:@"¥ %@",model.shippingFee];
            }else{
                
                  cell.detailTextLabel.text = [self.MyModel.goodsFreight integerValue] == 0 ? @"免邮": [NSString stringWithFormat:@"¥ %@",self.MyModel.goodsFreight];
            }
      
           
            return cell;
            
        }
        else{
            
            //买家留言
            XZXShopOrderDetail_good2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopOrderDetail_good2CellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.InputcontentBlock = ^(NSString * _Nonnull content) {

                [self.MyModel.cart objectAtIndex:indexPath.section-1].buyerMessage = content;
            };
            return cell;
        }
    }else{
        //积分购物
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.textLabel.text = @"蓝积分";
        cell.detailTextLabel.attributedText = [NSString changestringArray:@[@" - ",[NSString stringWithFormat:@"%ld",[self.CommonModel.score integerValue]*self.CommonModel.goodnum]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"15.0",@"15.0"]];
            //cell.imageView.image = [UIImage imageNamed:@"xuanzhong"];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 

    if (indexPath.section == 0) {
        
        XZXMine_AdressListTVC *TVC = [XZXMine_AdressListTVC new];
        TVC.tag = UploadOrder_selectAdress;
        TVC.ChangeAddressInOrder = ^(XZXMine_AreaListModel *model) {
        
            self.MyModel.address = model;
            NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"member_id":@(kUser.member_id)}];
            if (self.UploadOrder_type == CarList) {
                
                NSData *data = [NSJSONSerialization dataWithJSONObject:self.tables options:kNilOptions error:nil];
                NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                [mudic setObject:json forKey:@"tables"];
                [mudic setObject:@(self.MyModel.address.addressId) forKey:@"addressId"];
            }else{
                
                XZXShopGood_UploadOrder_GoodModel *GoodModel = [self.MyModel.cart objectAtIndex:0];
                if (GoodModel == nil) {
                    return;
                }
                [mudic setObject:@(self.MyModel.address.addressId) forKey:@"addressId"];
                [mudic setObject:@"" forKey:@"tables"];
                [mudic setObject:GoodModel.goodsId forKey:@"goodsId"];
                [mudic setObject:GoodModel.goodsNum forKey:@"goodsNum"];
            }
            [XHNetworking xh_postWithoutSuccess:@"orders/getShippingFee" parameters:mudic success:^(XHResponse *responseObject) {
                
                if (responseObject.code == 200) {
                    
                    
                    if (self.UploadOrder_type == CarList) {
                       
                   
                        
                        self.MyModel.goodsFreight = [NSString stringWithFormat:@"%@",responseObject.data];
                        self.MyModel.payMoney_f = 0.0;
                        for (XZXShopGood_UploadOrder_GoodModel *TempModel in self.MyModel.cart) {
                            for (NSDictionary *dic in responseObject.data) {
                                
                                if ([TempModel.goodsId isEqualToString:[NSString stringWithFormat:@"%@",[dic valueForKey:@"goodsId"]]]) {
                                    
                                    TempModel.shippingFee = [NSString stringWithFormat:@"%@",[dic valueForKey:@"shippingFee"]];
                                    break;
                                }
                            }
                            
                            self.MyModel.payMoney_f += [[NSString reviseString:TempModel.goodsPrice] floatValue]*[TempModel.goodsNum integerValue] + [TempModel.shippingFee integerValue];
                        }
                        
                       // self.MyModel.payMoney_f = self.MyModel.payMoney_f*kUser.discount + [self.MyModel.goodsFreight floatValue];
                    }else{
                        //先计算商品价格，再加上最新邮费
                         CGFloat goodSumprice =  self.MyModel.payMoney_f - [self.MyModel.goodsFreight floatValue];
                        self.MyModel.goodsFreight = [NSString stringWithFormat:@"%@",[responseObject.data count]>0?[[responseObject.data objectAtIndex:0] valueForKey:@"shippingFee"]:@"0"];
                        self.MyModel.payMoney_f = goodSumprice + [self.MyModel.goodsFreight floatValue];
                    }
              
            self.pricelabel.text = [NSString stringWithFormat:@"合计：¥ %0.2f",self.MyModel.payMoney_f];
                    [self.CustomerTableview reloadData];
                }
            }];
            
            
        };
        [self.navigationController pushViewController:TVC animated:YES];

    }
}
#pragma mark 提交订单
- (IBAction)UploadOrder_Action:(id)sender {
    
    [self.view endEditing:YES];
    NSString *url = [NSString string];
    NSDictionary *dic = [NSDictionary dictionary];
    
    //商品规格
    NSMutableString *mustr = [NSMutableString string];
    for (NSInteger j =0; j < self.GuiGe_Array.count ; j++ ) {
        XZXShopGoodSelectGuiGeModel *model = [self.GuiGe_Array objectAtIndex:j];
        if (j == self.GuiGe_Array.count - 1) {
            [mustr appendString:[NSString stringWithFormat:@"%@",model.spValueId]];
        }else{
            
            [mustr appendString:[NSString stringWithFormat:@"%@_",model.spValueId]];
        }
    }
    
    if (self.UploadOrder_type == CarList) {
        //购物车
        NSMutableArray *goods = [NSMutableArray array];
        for (XZXShopGood_UploadOrder_GoodModel *googModel in self.MyModel.cart) {
            
            [goods addObject:@{@"cartId":googModel.cartId,@"buyerMessage":googModel.buyerMessage}];
        }
        NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:kNilOptions error:nil];
        NSString *jsonstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        url = @"orders/generatePrepaidOrders";
        dic =  @{@"token":kUser.token,@"userId":@(kUser.member_id),@"cartIdStr":self.paramete_id,@"buyerId":@(kUser.member_id),@"addressId":@(self.MyModel.address.addressId),@"orders":jsonstr};
    }else if(self.UploadOrder_type == Good_Order ||
             self.UploadOrder_type == Actity_ZY){
        //普通商品、自营
        XZXShopGood_UploadOrder_GoodModel *GoodModel = [self.MyModel.cart objectAtIndex:0];
        if (GoodModel == nil) {
            return;
        }
        url = @"orders/generatePrepaOrdersByGoodsId";
        dic =  @{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"goodsId":GoodModel.goodsId,@"goodsNum":GoodModel.goodsNum,@"addressId":@(self.MyModel.address.addressId),@"spValueId":mustr,@"buyerMessage":GoodModel.buyerMessage};
    }else if (self.UploadOrder_type == Actity_MS ||
              self.UploadOrder_type == Actity_TG){
       //秒杀、团购
        XZXShopGood_UploadOrder_GoodModel *GoodModel = [self.MyModel.cart objectAtIndex:0];
        if (GoodModel == nil) {
            return;
        }
        url = @"activitys/generatePrepaOrdersByGoodsId";
        dic = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"activityType":@(self
                    .activitytype),@"addressId":@(self.MyModel.address.addressId),@"buyerId":@(kUser.member_id),@"goodsNum":GoodModel.goodsNum,@"spValueId":mustr,@"buyerMessage":GoodModel.buyerMessage,@"goodsId":GoodModel.goodsId};
    }else if (self.UploadOrder_type == Actity_Agent){
        
        XZXShopGood_UploadOrder_GoodModel *GoodModel = [self.MyModel.cart objectAtIndex:0];
        if (GoodModel == nil) {
            return;
        }
        url = @"activitys/generatePrepaOrdersByGoodsId2";
        dic = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"goodsId":GoodModel.goodsId,@"goodsNum":GoodModel.goodsNum,@"addressId":@(self.MyModel.address.addressId),@"spValueId":mustr,@"buyerMessage":GoodModel.buyerMessage};
   
    }else if (self.UploadOrder_type == Actity_ZC){
        XZXShopGood_UploadOrder_GoodModel *GoodModel = [self.MyModel.cart objectAtIndex:0];
        if (GoodModel == nil) {
            return;
        }
        //1、一元众筹。2、全款
        url = @"activitys/groupBuygeneratePrepaOrdersByGoodsId";
        dic = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"goodsId":GoodModel.goodsId,@"goodsNum":GoodModel.goodsNum,@"addressId":@(self.MyModel.address.addressId),@"spValueId":mustr,@"buyerMessage":GoodModel.buyerMessage,@"crowdType":@(self.ZC_type)};
    }else if (self.UploadOrder_type == Actity_JF){
        XZXShopGood_UploadOrder_GoodModel *GoodModel = [self.MyModel.cart objectAtIndex:0];
        if (GoodModel == nil) {
            return;
        }
        
        url = @"activitys/generatePrepaOrdersByScoreGoodsId";
        dic = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"activityType":@"60",@"goodsId":GoodModel.goodsId,@"addressId":@(self.MyModel.address.addressId),@"goodsNum":GoodModel.goodsNum,@"buyerMessage":GoodModel.buyerMessage};
        
        if (self.JF_type == 3) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否选择使用蓝积分兑换商品" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                [self LoadOrderUrl:url Parameters:dic];
            }]];
            [self presentViewController:alertVC animated:YES completion:^{
                
            }];
            
            return;
            
        }
    }
      [self LoadOrderUrl:url Parameters:dic];
 
}

-(void)LoadOrderUrl:(NSString *)url_hex Parameters:(NSDictionary *)dic{
    
    [XHNetworking xh_postWithoutSuccess:url_hex parameters:dic success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            
            
            if ([[responseObject.data allKeys] containsObject:@"crowdType"]) {
                if ([[responseObject.data valueForKey:@"crowdType"] integerValue] == 4 &&
                    [[responseObject.data valueForKey:@"money"] floatValue] == 0) {
                    //蓝积分购物
                    
                    XZXPayResultVC *ResultVC = [[XZXPayResultVC alloc]initWithNibName:@"XZXPayResultVC" bundle:nil];
                    ResultVC.order_data =  [NSMutableDictionary dictionaryWithDictionary:@{@"money":@"0",@"orders":[responseObject.data valueForKey:@"outTradeNo"]}];
                    ResultVC.allMoney =@"0";
                    
                    [self.navigationController pushViewController:ResultVC animated:YES];
                    return ;
                }
            }
            
            XZXPaymentOrder *payment = [XZXPaymentOrder new];
            payment.order_data = [NSMutableDictionary dictionaryWithDictionary:@{@"money":[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"money"]],@"orders":[responseObject.data valueForKey:@"outTradeNo"]}];
            [payment  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            payment.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            if (self.UploadOrder_type == Actity_JF) {
                
                payment.VC_type = HaveRecordPay;
            }
            
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.providesPresentationContextTransitionStyle = YES;
            self.definesPresentationContext = YES;
            payment.PayFairBlock = ^{
                
                [MBProgressHUD xh_showHudWithMessage:@"请到订单列表去支付" toView:self.view completion:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            };
            payment.PaySuccessBlock = ^(NSDictionary * _Nonnull order_data) {
                
                XZXPayResultVC *ResultVC = [[XZXPayResultVC alloc]initWithNibName:@"XZXPayResultVC" bundle:nil];
                ResultVC.order_data = [NSMutableDictionary dictionaryWithDictionary:order_data];
                ResultVC.allMoney = [NSString stringWithFormat:@"%0.2f",[[order_data valueForKey:@"money"] floatValue]];
                
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
            
        }else{
            
            
            [MBProgressHUD xh_showHudWithMessage:@"出错了" toView:self.view completion:^{
                
            }];
        }
    }];
    
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
                ResultVC.allMoney = [NSString stringWithFormat:@"%0.2f",[[self.redscore_order_data valueForKey:@"money"] floatValue] ];
                
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
@end
