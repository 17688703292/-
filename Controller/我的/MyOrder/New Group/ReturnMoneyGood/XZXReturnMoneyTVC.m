//
//  XZXReturnMoneyTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXReturnMoneyTVC.h"
#import "XZXMineOrderVC.h"
#import "XZXReturnAfterSaleDetail.h"
#import "XZXOrderDetailVC.h"
#import "CSImagePickerManager.h"


#import "XZXMine_goodCell.h"
#import "XZXShopOrderDetail_good2Cell.h"
#import "XZXReturnAfterSaleSelectImageTVC.h"


@interface XZXReturnMoneyTVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,XZXReturnAfterSaleSelectImageTVCDelegate>


@property (nonatomic,strong)UITableView *CustomerTableView;
@property (nonatomic, copy) NSString *pro_statu;//货物状态
@property (nonatomic, copy) NSString *Return_reason;//退款状态
@property (nonatomic,strong)NSString *Message;//买家留言

@property (nonatomic, strong) CSImagePickerManager *imageManager;
@property (nonatomic,strong)NSMutableArray *dataArray_Pic;//上传的凭证


@property (nonatomic,strong)dispatch_group_t uploadPicGroup;
@property (nonatomic,strong)dispatch_queue_t uploadPicQueue;
@end



@implementation XZXReturnMoneyTVC
{
    UIWindow *keyWindow;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.uploadPicGroup = dispatch_group_create();
    self.uploadPicQueue = dispatch_queue_create("uploadPicQueue", DISPATCH_QUEUE_SERIAL);
    //区分修改申请还是第一次提交申请
    if (self.tag == ReturnMoney) {
        
        self.title = @"申请退款";
        [self.dataArray_Pic addObject:[UIImage imageNamed:@"tianjiayinhangka"]];
        
    }else if(self.tag == ReturnMoneyAndGood){
        
        self.title = @"退货退款";
        [self.dataArray_Pic addObject:[UIImage imageNamed:@"tianjiayinhangka"]];
        
    }
    self.Message = [NSString string];
    
    
    if (self.RMVC_Type == Edit_RMAfterSale) {
        
        self.pro_statu = [self.RMVC_Model valueForKey:@"pro_statu"];
        self.Return_reason = [self.RMVC_Model valueForKey:@"Return_reason"];
        self.Message = [self.RMVC_Model valueForKey:@"orderGoodsRefundExplain"];
        
    }
    
    //刷新界面
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_goodCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_goodCellID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopOrderDetail_good2Cell" bundle:nil] forCellReuseIdentifier:@"XZXShopOrderDetail_good2CellID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXReturnAfterSaleSelectImageTVC" bundle:nil] forCellReuseIdentifier:@"XZXReturnAfterSaleSelectImageTVCID"];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    self.CustomerTableView.tableFooterView = [UIView new];
    self.CustomerTableView.backgroundColor = [UIColor clearColor];

    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(NSMutableArray *)dataArray_Pic{
    
    if (!_dataArray_Pic) {
        _dataArray_Pic = [NSMutableArray array];
    }
    return _dataArray_Pic;
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView   heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section ==2){
        
        return 10;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120;
        }
        return 50;
    }else if (indexPath.section == 2 && indexPath.row == 1){
        return 100*((self.dataArray_Pic.count-1)/3+1);
    }
    return 50;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if ([self.DetailModel.crowdType integerValue] == 3) {
            return 7;
        }else if ([self.DetailModel.crowdType integerValue] == 4){
            
            return 6;
        }else{
       
            return 5;
        }
    }else{
        return 2;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    if (indexPath.section == 0) {
        
        XZXMine_goodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_goodCellID" forIndexPath:indexPath];
        cell.goodName.numberOfLines = 0;
        cell.goodContent.numberOfLines = 0;
        cell.goodName.text = self.goodmodel.goodsName;
        cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.goodmodel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",self.goodmodel.goodsScore]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"17.0",@"15.0"]];
        [cell.goodImage sd_setImageWithURL:kImageUrl(self.goodmodel.storeId,self.goodmodel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        return cell;
    }else if (indexPath.section == 1){
        
        if (indexPath.row < 4) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            if (indexPath.row == 0) {
                cell.textLabel.text = @"货物状态";
                 cell.detailTextLabel.text =  [self.pro_statu length] == 0 ? @"请选择" : self.pro_statu;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"退款原因";
                cell.detailTextLabel.text = [self.Return_reason length] == 0 ? @"请选择" : self.Return_reason;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }else if (indexPath.row == 2){
                
                cell.textLabel.attributedText = [NSString changestringArray:@[@"退款金额：",[NSString stringWithFormat:@"¥ %@",self.DetailModel.money]] colorArray:@[[UIColor lightGrayColor],kThemeColor] fontArray:@[@"16.0",@"18.0"]];
                cell.detailTextLabel.text = @"";
                
            }else{
                
                cell.textLabel.text = [NSString stringWithFormat:@"最多退款：¥ %@,含发货邮费 ¥ %@",self.DetailModel.money,self.DetailModel.shippingFee];
                cell.textLabel.textColor = [UIColor lightGrayColor];
                cell.detailTextLabel.text = @"";
                cell.backgroundColor = kBackgroundColor;
                
            }
            return cell;
        }else if(indexPath.row == 4){
            
            XZXShopOrderDetail_good2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopOrderDetail_good2CellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([self.Message length]!=0) {
                cell.Input_content.text = self.Message;
            }
            cell.InputcontentBlock = ^(NSString * _Nonnull content) {
                
                self.Message = content;
            };
            return cell;
        }else if (indexPath.row == 5){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell3"];
            }
            cell.backgroundColor = [UIColor whiteColor];
            cell.imageView.image = [UIImage imageNamed:@""];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"蓝积分";
            cell.detailTextLabel.text = [NSString stringWithFormat:@" + %@",self.DetailModel.blueScore];
            cell.detailTextLabel.textColor = [UIColor hexStringToColor:@"4282eb"];
            return cell;
        }else{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell3"];
            }
            cell.backgroundColor = [UIColor whiteColor];
            cell.imageView.image = [UIImage imageNamed:@""];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"红积分";
            cell.detailTextLabel.text = [NSString stringWithFormat:@" + %@",self.DetailModel.redScore];
            cell.detailTextLabel.textColor = kThemeColor;
            return cell;
        }
    }else{
        
        if (indexPath.row == 0) {
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            }
            cell.textLabel.text = @"上传凭证(最多上传3张图片)";
            return cell;
        }else{

            XZXReturnAfterSaleSelectImageTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXReturnAfterSaleSelectImageTVCID" forIndexPath:indexPath];
            cell.delegate = self;
            cell.dataArray_Pic = self.dataArray_Pic;
            [cell.CustomerCollectionView reloadData];
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        [self SelectPro_statu];
    }else if (indexPath.section == 1 && indexPath.row == 1){

        [self SelectReson];
    }
    
}


#pragma mark UICollectionView


-(void)GetPhont_XZXReturnAfterSaleSelectImageTVCDelegate:(XZXReturnAfterSaleSelectImageTVC *)cell{
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            
            [self.dataArray_Pic addObject:image];
        }
        
        [self.CustomerTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
}




#pragma mark 获取售后原因

-(void)SelectPro_statu{
    

    NSArray *Reasons = @[@{@"reason":@"未收到货"},@{@"reason":@"已收到货"}];
        UIAlertController *alertAC = [UIAlertController alertControllerWithTitle:@"货物状态" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSDictionary *dic in Reasons) {
            
            UIAlertAction *reason1 = [UIAlertAction actionWithTitle:[dic valueForKey:@"reason"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self.pro_statu = action.title;
                [self.CustomerTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [alertAC addAction:reason1];
            [reason1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        }
        
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertAC addAction:cancle];
        [self presentViewController:alertAC animated:YES completion:^{
            
        }];

}

-(void)SelectReson{
    
    
    if ([self.pro_statu length] == 0) {
        
        [self SelectPro_statu];
        return;
    }
        
    NSArray *Reasons = [NSArray array];
    if ([self.pro_statu isEqualToString:@"未收到货"]) {
     
        Reasons = @[@{@"reason":@"多拍/排错/不想要"},@{@"reason":@"快递t一直未送到"},@{@"reason":@"未按约定时间发货"},@{@"reason":@"快递无跟踪记录"},@{@"reason":@"空包裹/少货"},@{@"reason":@"其它"}];
    }else{
        
        Reasons = @[@{@"reason":@"尺码拍错/不喜欢/不想要"},@{@"reason":@"质量问题"},@{@"reason":@"材料/面料与商品描述不符"},@{@"reason":@"大小尺寸与商品描述不符"},@{@"reason":@"颜色/款式/图案与描述不符"},@{@"reason":@"卖家发错货"},@{@"reason":@"假冒品牌"},@{@"reason":@"收到商品少见或破损"}];
    }
        UIAlertController *alertAC = [UIAlertController alertControllerWithTitle:@"退款原因" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSDictionary *dic in Reasons) {
            
            UIAlertAction *reason1 = [UIAlertAction actionWithTitle:[dic valueForKey:@"reason"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self.Return_reason = action.title;
                [self.CustomerTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
              
            }];
            [alertAC addAction:reason1];
            [reason1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        }
        
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertAC addAction:cancle];
        [self presentViewController:alertAC animated:YES completion:^{
            
        }];

}

#pragma mark 提交申请


- (IBAction)UploadAfterSale_Action:(id)sender {
    
    
    if ([self.pro_statu length] == 0 ||
        [self.Return_reason length] == 0) {
        [MBProgressHUD xh_showHudWithMessage:@"请选择退款原因" toView:self.view completion:^{

        }];
        return;
    }
    
    
    if (self.dataArray_Pic.count > 1) {
   
        NSMutableArray *orderGoodsRefundImgList = [NSMutableArray array];
        NSLog(@"开始传递");
        for (NSInteger j = 1; j<self.dataArray_Pic.count; j++) {
        
            dispatch_group_async(self.uploadPicGroup, dispatch_get_main_queue(), ^{
                
                NSData *data = [XHTools compressImage:self.dataArray_Pic[j] toByte:102400];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyyMMddhhmmssSSSS"];
                NSString *dateNow = [formatter stringFromDate:[NSDate date]];
                
                [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleHorizontalBar fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    
                    dispatch_group_enter(self.uploadPicGroup);
                    [formData appendPartWithFileData:data name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow] mimeType:@"png/image"];
                    
                } success:^(XHResponse *responseObject) {
                    
                    dispatch_group_leave(self.uploadPicGroup);
                    if(responseObject != nil){
                     
                        [orderGoodsRefundImgList addObject:@{@"redundImg":[responseObject.data valueForKey:@"url"],@"recId":@([self.goodmodel.recId integerValue])}];
                    }
                    
                }];
            });
            
        }
            dispatch_group_notify(self.uploadPicGroup,dispatch_get_main_queue(), ^{
                NSLog(@"开始传递完成");
                 [self UploadMessage:orderGoodsRefundImgList];
            });
    }else{
        
        [self UploadMessage:[NSMutableArray array]];
    }
}

-(void)UploadMessage:(NSMutableArray *)orderGoodsRefundImgList{
    
    NSDictionary *parameters = [NSDictionary dictionary];
    if (orderGoodsRefundImgList.count == 0) {
        
        parameters = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"recId":self.goodmodel.recId,@"orderId":self.DetailModel.orderId,@"goodsId":self.goodmodel.goodsId,@"orderGoodsRefundStatus":@(self.tag),@"orderGoodsRefundReason":[NSString stringWithFormat:@"%@ ：%@",self.pro_statu,self.Return_reason],@"orderGoodsRefundExplain":self.Message};
    }else{
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:orderGoodsRefundImgList options:kNilOptions error:nil];
        NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        parameters = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"recId":self.goodmodel.recId,@"orderId":self.DetailModel.orderId,@"goodsId":self.goodmodel.goodsId,@"orderGoodsRefundStatus":@(self.tag),@"orderGoodsRefundReason":[NSString stringWithFormat:@"%@ ：%@",self.pro_statu,self.Return_reason],@"orderGoodsRefundExplain":self.Message,@"orderGoodsRefundImgList":json};
    }
    
    [XHNetworking xh_postWithSuccess:@"orders/refundOrderGood" parameters:parameters success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                XZXReturnAfterSaleDetail *VC = kStoryboradController(@"AfterSale", @"XZXReturnAfterSaleDetailID");
                VC.GoodDetailModel = self.DetailModel;
                VC.goodmodel    = self.goodmodel;
                [self.navigationController pushViewController:VC animated:YES];
            });
        }
    }];
}
@end
