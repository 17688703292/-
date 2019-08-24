//
//  XZXReturngoodsTVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXReturngoodsTVC.h"
#import "XZXMineOrderVC.h"
#import "XZXReturnAfterSaleDetail.h"
#import "XZXMineOrderVC.h"
#import "CSImagePickerManager.h"

#import "XZXMine_goodCell.h"
#import "XZXShopOrderDetail_good2Cell.h"
#import "XZXReturnAfterSaleSelectImageTVC.h"

@interface XZXReturngoodsTVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,XZXReturnAfterSaleSelectImageTVCDelegate>

@property (nonatomic,strong)UITableView *CustomerTableView;
@property (nonatomic,strong)UICollectionView *CustomerCollectionview;
@property (nonatomic, copy) NSString *Return_reason;//退款状态
@property (nonatomic,strong)NSString *Message;//买家留言
@property (nonatomic, strong) CSImagePickerManager *imageManager;
@property (nonatomic,strong)NSMutableArray *dataArray_Pic;//上传的凭证

@property (nonatomic,strong)dispatch_group_t uploadPicGroup;
@property (nonatomic,strong)dispatch_queue_t uploadPicQueue;
@end

@implementation XZXReturngoodsTVC
{
    UIWindow *keyWindow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"申请换货";
    self.Message = [NSString string];

    self.uploadPicGroup = dispatch_group_create();
    self.uploadPicQueue = dispatch_queue_create("uploadPicQueue", DISPATCH_QUEUE_SERIAL);
    
    if (self.RGVC_Type == Edit_RGAfterSale) {
        
      
        self.Return_reason = [self.RGVC_Model valueForKey:@"Return_reason"];
        self.Message = [self.RGVC_Model valueForKey:@"orderGoodsRefundExplain"];
        
    }
    //刷新界面
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_goodCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_goodCellID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopOrderDetail_good2Cell" bundle:nil] forCellReuseIdentifier:@"XZXShopOrderDetail_good2CellID"];
       [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXReturnAfterSaleSelectImageTVC" bundle:nil] forCellReuseIdentifier:@"XZXReturnAfterSaleSelectImageTVCID"];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    self.CustomerTableView.tableFooterView = [UIView new];
    self.CustomerTableView.backgroundColor = [UIColor clearColor];
    
    //加载图片选择
    self.CustomerCollectionview.collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    self.CustomerCollectionview.delegate = self;
    self.CustomerCollectionview.dataSource = self;
    [self.CustomerCollectionview registerNib:[UINib nibWithNibName:@"XZXMine_AboutMe_TeamCell" bundle:nil] forCellWithReuseIdentifier:@"XZXMine_AboutMe_TeamCellID"];
    [self.CustomerCollectionview registerNib:[UINib nibWithNibName:@"XZXMine_EnterStore_SelectPic" bundle:nil] forCellWithReuseIdentifier:@"XZXMine_EnterStore_SelectPicID"];
    
    self.CustomerCollectionview.showsVerticalScrollIndicator = YES;
    self.CustomerCollectionview.bounces = false;
    self.CustomerCollectionview.showsHorizontalScrollIndicator = false;
    [self.dataArray_Pic addObject:[UIImage imageNamed:@"tianjiayinhangka"]];
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
    
        return 120;
    }else if (indexPath.section == 2 && indexPath.row == 1){
        
       return 100*((self.dataArray_Pic.count-1)/3+1);
    }
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }
    
    return 2;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self SelectReson];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        
      
    }else if (indexPath.section == 1 && indexPath.row == 2){
        
      
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        XZXMine_goodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_goodCellID" forIndexPath:indexPath];
        cell.goodName.text = self.goodmodel.goodsName;
        cell.goodName.numberOfLines = 0;
        cell.goodContent.numberOfLines = 0;
        cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.goodmodel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",self.goodmodel.goodsScore]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"17.0",@"15.0"]];
        [cell.goodImage sd_setImageWithURL:kImageUrl(self.goodmodel.storeId,self.goodmodel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        return cell;
    }else if (indexPath.section == 1){
        
        
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = @"换货原因";
            cell.detailTextLabel.text = [self.Return_reason length] == 0 ? @"请选择" : self.Return_reason;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            
        }else{
            XZXShopOrderDetail_good2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopOrderDetail_good2CellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.InputcontentBlock = ^(NSString * _Nonnull content) {
                self.Message = content;
                
            };
            return cell;
        }
        
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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

#pragma mark UICollectionView


-(void)GetPhont_XZXReturnAfterSaleSelectImageTVCDelegate:(XZXReturnAfterSaleSelectImageTVC *)cell{
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            
            [self.dataArray_Pic addObject:image];
        }
        
        [self.CustomerTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
}


-(void)SelectReson{
    
    NSArray *Reasons = [NSArray array];

    Reasons = @[@{@"reason":@"尺码拍错/不喜欢/不想要"},@{@"reason":@"质量问题"},@{@"reason":@"材料/面料与商品描述不符"},@{@"reason":@"大小尺寸与商品描述不符"},@{@"reason":@"颜色/款式/图案与描述不符"},@{@"reason":@"卖家发错货"},@{@"reason":@"假冒品牌"},@{@"reason":@"收到商品少见或破损"}];

    UIAlertController *alertAC = [UIAlertController alertControllerWithTitle:@"退款原因" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSDictionary *dic in Reasons) {
        
        UIAlertAction *reason1 = [UIAlertAction actionWithTitle:[dic valueForKey:@"reason"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.Return_reason = action.title;
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



-(void)takePhoto{
    
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            
            [self.dataArray_Pic addObject:image];
        }
        
        [self.CustomerTableView reloadData];
        [self.CustomerCollectionview reloadData];
    }];
}
#pragma mark 提交换货申请



- (IBAction)UploadAfterSale_Action:(id)sender {
    
    if (
        [self.Return_reason length] == 0) {
        [MBProgressHUD xh_showHudWithMessage:@"请选择原换货因" toView:self.view completion:^{
            
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
        
        parameters = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"recId":self.goodmodel.recId,@"orderId":self.DetailModel.orderId,@"goodsId":self.goodmodel.goodsId,@"orderGoodsRefundStatus":@(3),@"orderGoodsRefundReason":[NSString stringWithFormat:@"%@",self.Return_reason],@"orderGoodsRefundExplain":self.Message};
    }else{
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:orderGoodsRefundImgList options:kNilOptions error:nil];
        NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        parameters = @{@"token":kUser.token,@"userId":@(kUser.member_id),@"recId":self.goodmodel.recId,@"orderId":self.DetailModel.orderId,@"goodsId":self.goodmodel.goodsId,@"orderGoodsRefundStatus":@(3),@"orderGoodsRefundReason":[NSString stringWithFormat:@"%@",self.Return_reason],@"orderGoodsRefundExplain":self.Message,@"orderGoodsRefundImgList":json};
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
