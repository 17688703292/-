//
//  XZX_GoodDetail_CommonTV.m
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodDetail_CommonTV.h"
#import "XZXShopCarListVC.h"
#import "XZXShopGood_UploadOrderVC.h"
#import "XZXShopGoodSelectVC.h"
#import "XZXShopGoodSelect_ZC_VC.h"
#import "XZXEvalutionListTVC.h"
#import "XZXStoreVC.h"
#import "XZXStoreInformationTVC.h"
#import "XZXServicesListVC.h"

#import "XZXGOODdetail_AdTC.h"
#import "GoodDetail_goodImage.h"
#import "GoodDetail_goodName.h"
#import "GoodDetail_SendGoodAddress.h"
#import "GoodDetail_coupon1.h"
#import "GoodDetail_coupon2.h"
#import "GoodDetail_coupon3.h"
#import "GoodDetail_coupon4.h"
#import "GoodDetail_coupon5.h"
#import "GoodDetail_Evalution1.h"
#import "XZXShopEvalution_TC.h"
#import "GoodDetail_goodMSTC.h"
#import "XZXGoodDetail_companyInformationTC.h"
#import "XZXGoodDetail_EvalutionHeadTC.h"

#import "XZX_GoodDetail_CommonModel.h"
#import "XZXShopGoodEvalution_ListModel.h"
#import "UINavigationBar+Awesome.h"
#import "goodsImagesListModel.h"

#import <YBImageBrowser/YBImageBrowser.h>


/**
 众筹
 */
#import "GoodDetail_goodZCprogressTC.h"
#import "GoodDetail_goodZCprogressTC2.h"


@interface XZX_GoodDetail_CommonTV()<XZXGOODdetail_AdTCDelegate>

@property (nonatomic,strong) XZX_GoodDetail_CommonModel *CommonModel;
@property (nonatomic,strong) XZXShopGoodEvalution_ListModel *EvalutionListModel;


//秒杀
@property (nonatomic,assign) NSInteger  LastTime;//返回当前商品的秒杀的剩余时间
@property (nonatomic,strong) NSTimer *MS_timer;
@property (nonatomic,copy) NSString *AlertMessage;//无法抢购商品提示语言

@property (nonatomic,strong)YBImageBrowser *ImageBrowser;
@property (nonatomic,strong)NSMutableArray *ImageBrowser_dataSource;
@end

@implementation XZX_GoodDetail_CommonTV

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.title = @"商品详情";
    [self addRightItemWithIconName:@"fenxiang"];
  
    
    [self.CustomerTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(self.CommandBackView.mas_top);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
    }];
    
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_goodImage" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodImageID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"XZXGOODdetail_AdTC" bundle:nil] forCellReuseIdentifier:@"XZXGOODdetail_AdTCID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_goodName" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodNameID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_SendGoodAddress" bundle:nil] forCellReuseIdentifier:@"GoodDetail_SendGoodAddressID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_coupon1" bundle:nil] forCellReuseIdentifier:@"GoodDetail_coupon1ID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_coupon2" bundle:nil] forCellReuseIdentifier:@"GoodDetail_coupon2ID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_coupon3" bundle:nil] forCellReuseIdentifier:@"GoodDetail_coupon3ID"];
     [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_coupon4" bundle:nil] forCellReuseIdentifier:@"GoodDetail_coupon4ID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_coupon5" bundle:nil] forCellReuseIdentifier:@"GoodDetail_coupon5ID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_Evalution1" bundle:nil] forCellReuseIdentifier:@"GoodDetail_Evalution1ID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"XZXShopEvalution_TC" bundle:nil] forCellReuseIdentifier:@"XZXShopEvalution_TCID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_goodMSTC" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodMSTCID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"XZXGoodDetail_companyInformationTC" bundle:nil] forCellReuseIdentifier:@"XZXGoodDetail_companyInformationTCID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"XZXGoodDetail_EvalutionHeadTC" bundle:nil] forCellReuseIdentifier:@"XZXGoodDetail_EvalutionHeadTCID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_goodZCprogressTC" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodZCprogressTCID"];
    [self.CustomerTV registerNib:[UINib nibWithNibName:@"GoodDetail_goodZCprogressTC2" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodZCprogressTC2ID"];
    self.CustomerTV.dataSource = self;
    self.CustomerTV.delegate   = self;
    self.CustomerTV.separatorStyle = UITableViewCellEditingStyleNone;
    self.CustomerTV.backgroundColor = kBackgroundColor;
    
    

    switch (self.VC_type) {
        case GoodDetail_CommonTV:
        case GoodDetail_ZY:
        case GoodDetail_RM:
        
            {
                [self.CSBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
                [self.CollectionBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
                [self.BuyCarBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
               
                self.SpecialBackView.hidden = true;
                
            }
        break;
        case GoodDetail_MS:
        {
            [self.special_CSBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.special_CollectionBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
              [self.carBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            self.SpecialBackView.backgroundColor = [UIColor whiteColor];
            
            self.SpecialBackView.hidden = false;
     
        }
            break;
        case GoodDetail_TG:
        {
            [self.special_CSBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.special_CollectionBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
              [self.carBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            self.SpecialBackView.backgroundColor = [UIColor whiteColor];
            
            self.SpecialBackView.hidden = false;
          
        }
            break;
             case GoodDetail_JF:
        {
            [self.special_CSBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.special_CollectionBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.carBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            self.SpecialBackView.backgroundColor = [UIColor whiteColor];
         
            if (self.JF_type == 3) {
                
                   [self.special_ByBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
            }else if (self.JF_type == 4){
                
                   [self.special_ByBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            }
            self.SpecialBackView.hidden = false;
        }
            break;
        case GoodDetail_Agent:
        {
            [self.CSBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.CollectionBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.BuyCarBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            
            self.SpecialBackView.hidden = true;
        }
            break;
        case GoodDetail_ZC:
        {
            [self.special_CSBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.special_CollectionBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            [self.carBtn xh_setImagePosition:XHButtonImagePositionTop spacing:4];
            self.SpecialBackView.backgroundColor = [UIColor whiteColor];
            [self.special_ByBtn  setTitle:@"立即支持" forState:UIControlStateNormal];
            self.SpecialBackView.hidden = false;
        }
            break;
        default:
            break;
    }
    
    
    [self GetInformation];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
#if 0
   // self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
     
                           forBarPosition:UIBarPositionAny
     
                               barMetrics:UIBarMetricsDefault];   // 设置navigationBar的颜色为透明的
    
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
#endif 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
#if 0
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 50) {
        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[kThemeColor colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[kThemeColor colorWithAlphaComponent:0]];
    }
#endif 
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = false;
    [self.MS_timer invalidate];
    self.MS_timer = nil;
}

-(void)MS_LastTime_ReloadUI{
    
    --self.LastTime;
    [UIView performWithoutAnimation:^{
        
        [self.CustomerTV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];

   
    if (self.LastTime <= 0) {
        self.special_ByBtn.backgroundColor = kBackgroundColor;
        [self.MS_timer invalidate];
        self.MS_timer = nil;
    }
}
-(void)GetInformation{
    
   
    if (self.VC_type == GoodDetail_ZC) {
        
        
        [XHNetworking xh_postWithoutSuccess:@"activitys/getGroupBuyGoodsDetails" parameters:@{@"goodsCommonid":self.goodsId,@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {
            
            

            
            self.CommonModel = [XZX_GoodDetail_CommonModel yy_modelWithDictionary:(NSDictionary *)responseObject.data];
            self.CommonModel.goodnum = 1;
             self.CommonModel.IsOver = false;
            //string转data
            NSData * jsonData = [[responseObject.data valueForKey:@"content"]  dataUsingEncoding:NSUTF8StringEncoding];
            //json解析
            self.CommonModel.content = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            
            self.CollectionBtn.selected = self.CommonModel.favoritesFlag == 1? true :false;
            
            //添加放大图片到数据源
            self.ImageBrowser_dataSource = [NSMutableArray array];
            for (NSString *url in self.CommonModel.mobileBody) {
                YBImageBrowseCellData *data0 = [YBImageBrowseCellData new];
                data0.url = [NSURL URLWithString:url];
                
                [self.ImageBrowser_dataSource addObject:data0];
            }
            
            if ([[XHTools getNowTimeTimestamp_HaoMiao] compare:self.CommonModel.activityEndDate]==NSOrderedAscending != 1) {
                
                self.CommonModel.IsOver = true;
                [self.special_ByBtn setBackgroundColor:[UIColor lightGrayColor]];
                [self.special_ByBtn setTitle:@"已结束" forState:UIControlStateNormal];
            }
           
            
            [self.CustomerTV reloadData];
            //获取评价
            [XHNetworking xh_postWithoutSuccess:@"evaluateGoods/secrahEvaluateByGoodsId" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"page":@"1",@"gevalGoodsid":self.goodsId} success:^(XHResponse *responseObject) {
                
                if (responseObject.code == 200 &&
                    [[responseObject.data valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
                    
                    self.EvalutionListModel = [XZXShopGoodEvalution_ListModel yy_modelWithJSON:responseObject.data];
                }
                [self.CustomerTV reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }];
    }else{
        
        
        [XHNetworking xh_postWithoutSuccess:@"goodsClassNav/getGoodsDetail" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"goodsId":self.goodsId,@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
            
            self.CommonModel = [XZX_GoodDetail_CommonModel yy_modelWithDictionary:(NSDictionary *)responseObject.data];
            self.CommonModel.goodnum = 1;
            self.CollectionBtn.selected = self.CommonModel.favoritesFlag == 1? true :false;
            
            //添加放大图片到数据源
            self.ImageBrowser_dataSource = [NSMutableArray array];
            for (NSString *url in self.CommonModel.mobileBody) {
                YBImageBrowseCellData *data0 = [YBImageBrowseCellData new];
                data0.url = [NSURL URLWithString:url];
                
                [self.ImageBrowser_dataSource addObject:data0];
            }
            
            
            if (self.CommonModel.goodsPromotionType == 20) {
                self.special_ByBtn.backgroundColor = [UIColor hexStringToColor:@"a6a6a6"];
                self.LastTime = 0;
                
                
                if ([XHTools dateRemaining:self.CommonModel.spikeTime] > 0) {
                    
                    [self.special_ByBtn setTitle:@"等待开抢" forState:UIControlStateNormal];
                    self.AlertMessage = @"即将开启，不容错过";
                    
                }else{
                    
                    
                    if (-[XHTools dateRemaining:self.CommonModel.spikeTime] < self.CommonModel.spikeLasttime*60) {
                        
                        
                        
                        self.LastTime = self.CommonModel.spikeLasttime*60 + [XHTools dateRemaining:self.CommonModel.spikeTime];
                        
                        if (self.LastTime > 0) {
                            
                            self.MS_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(MS_LastTime_ReloadUI) userInfo:nil repeats:YES];
                            self.special_ByBtn.backgroundColor = kThemeColor;
                            
                        }
                    }else{
                        self.LastTime = -1;
                        [self.special_ByBtn setTitle:@"已结束" forState:UIControlStateNormal];
                        self.AlertMessage = @"限时抢购，手慢即无";
                    }
                }
            }
            
            [self.CustomerTV reloadData];
            //获取评价
            [XHNetworking xh_postWithoutSuccess:@"evaluateGoods/secrahEvaluateByGoodsId" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"page":@"1",@"gevalGoodsid":self.goodsId} success:^(XHResponse *responseObject) {
                
                if (responseObject.code == 200 &&
                    [[responseObject.data valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
                    
                    self.EvalutionListModel = [XZXShopGoodEvalution_ListModel yy_modelWithJSON:responseObject.data];
                }
                [self.CustomerTV reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 0) {
        if (self.VC_type == GoodDetail_MS) {
            
            
            if (indexPath.row == 0) {
                
                 return kScreenWidth;
            }
            else if (indexPath.row == 1){
             
                return 50;
            }
            else{
                return UITableViewAutomaticDimension;
            }
            
        }else if (self.VC_type == GoodDetail_ZC){
            if (indexPath.row == 0) {
                
                return kScreenWidth;
            }else if (indexPath.row == 1){
               
                return UITableViewAutomaticDimension;
            }else if (indexPath.row == 2){
                
                return 50;
            }else if (indexPath.row == 3){
                
                return 50;
            }
            return 0;
        }else{
            
            if (indexPath.row == 0) {
                return kScreenWidth;
            }else{
                return UITableViewAutomaticDimension;
            }
            
        }
    
        
    }else if (indexPath.section == 1){

        return 50;
    }else if (indexPath.section == 2){
       
        if (indexPath.row == 0) {
            return 50;
        }else if(indexPath.row == 2){
            return UITableViewAutomaticDimension;
        }else{
            return 50;
        }
    }else if (indexPath.section == 3){
        
        return 40;
    }else if (indexPath.section == 4){
       
        if (indexPath.row == 0 ) {
            
            return 40;
        }
        else if (indexPath.row == 1){
            
            return 60;
        }
        else{
            
            return UITableViewAutomaticDimension;
        }
    }else{
     
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        //简介
        if (self.VC_type == GoodDetail_MS) {
            return 3;
        }else if (self.VC_type == GoodDetail_ZC){
            
            return 4;
        }
        return 2;
    }else if (section == 1){
      
        //规格
        if (self.VC_type == GoodDetail_ZC) {
            
            if ([self.CommonModel.type2 isEqualToString:@"0"]) {
                return 0;
            }
            return 1;
        }else{
         
            if (self.CommonModel.type.count == 0) {
                return 0;
            }
            return 1;
        }
    }else if (section == 2){
        //发货地址、礼品券
        if(self.CommonModel.youhui.count == 0){
            if (self.VC_type == GoodDetail_ZC) {
                
                if (self.CommonModel.content.count > 0) {
               
                     return 3;
                }else{
                     return 2;
                }
               
            }else{
             
                return 1;
            }
        }
        return 4;
    }else if (section == 3){
        
        //经营资质
        return 1;
    }
    else if (section == 4){
        //评价
        if (self.VC_type == GoodDetail_ZC) {
            
            return 0;
        }else if (self.EvalutionListModel.data.count != 0) {
            
            return 3;
        }
        return 2;
    }else{
        //详情
 
        return self.CommonModel.mobileBody.count;
    }
}

- (GoodDetail_goodZCprogressTC *)extracted:(NSIndexPath * _Nonnull)indexPath tableView:(UITableView * _Nonnull)tableView {
    GoodDetail_goodZCprogressTC *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodZCprogressTCID" forIndexPath:indexPath];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            XZXGOODdetail_AdTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXGOODdetail_AdTCID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
          
            [cell.dataSourceUrl removeAllObjects];
            [cell.dataSourceLink removeAllObjects];
            [cell.dataSourceTitle removeAllObjects];
            
            for (goodsImagesListModel *AdvModel in self.CommonModel.goodsImagesList) {
                
                [cell.dataSourceUrl addObject:kImageUrl(self.CommonModel.storeId,AdvModel.goodsImage)];
                //[cell.dataSourceLink addObject:@""];
            }
            cell.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            cell.cycleScrollview.clipsToBounds = true;
            cell.cycleScrollview.imageURLStringsGroup = cell.dataSourceUrl;
            cell.cycleScrollview.titlesGroup = cell.dataSourceTitle;
            return cell;
            
        }else{
            
            if (self.VC_type == GoodDetail_MS && indexPath.row == 1) {
                
                GoodDetail_goodMSTC *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodMSTCID" forIndexPath:indexPath];
                if (self.LastTime > 0) {
                    
                    cell.hourTitle.text = self.LastTime/60/60%24 > 9 ? [NSString stringWithFormat:@"%ld",self.LastTime/60/60%24] :[NSString stringWithFormat:@"0%ld",self.LastTime/60/60%24];
                    cell.mineTitle.text  = self.LastTime%3600/60 > 9 ? [NSString stringWithFormat:@"%ld",self.LastTime%3600/60] : [NSString stringWithFormat:@"0%ld",self.LastTime%3600/60];
                    cell.secondTitle.text = self.LastTime%60 > 9 ? [NSString stringWithFormat:@"%ld",self.LastTime%60] : [NSString stringWithFormat:@"0%ld",self.LastTime%60];
                }else{
                    
                    cell.hourTitle.text = @"00";
                    cell.mineTitle.text  = @"00";
                    cell.secondTitle.text = @"00";
                }
                return cell;
            }else if (self.VC_type == GoodDetail_ZC && indexPath.row == 2){
                
                GoodDetail_goodZCprogressTC * cell = [self extracted:indexPath tableView:tableView];
                cell.progress_pro.progress = ([self.CommonModel.currentFullPeople integerValue] + [self.CommonModel.currentOnePeople integerValue])/[self.CommonModel.fullPaymentPeople floatValue];
                cell.progress_lab.text = [NSString stringWithFormat:@"%0.f%%",([self.CommonModel.currentFullPeople integerValue] + [self.CommonModel.currentOnePeople integerValue])/[self.CommonModel.fullPaymentPeople floatValue]*100];
                return cell;
                
            }else if (self.VC_type == GoodDetail_ZC && indexPath.row == 3){
                GoodDetail_goodZCprogressTC2 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodZCprogressTC2ID" forIndexPath:indexPath];
                cell.MyModel = self.CommonModel;
                return cell;
            }
            
            GoodDetail_goodName *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodNameID" forIndexPath:indexPath];
            if (self.CommonModel.goodsName != nil) {
             
                NSString *price = [NSString reviseString:self.CommonModel.price];
                NSInteger total = [self.CommonModel.goodsStorage integerValue];
                NSInteger saleNum = [self.CommonModel.goodsSalenum integerValue];
                NSString *pricestatu = @"热卖价";
                if (self.VC_type == GoodDetail_MS){
                    
                    pricestatu = @"秒杀价";
                    price = [NSString reviseString:self.CommonModel.goodsPromotionPrice];
                    total = self.CommonModel.activityCount - self.CommonModel.activitySellCount;
                    saleNum = self.CommonModel.activitySellCount;
                }else if (self.VC_type == GoodDetail_TG){
                    
                    pricestatu = @"团购价";
                }else if (self.VC_type == GoodDetail_ZC){
                    
                    pricestatu = @"众筹价\n";
                    price = [NSString reviseString:self.CommonModel.price];//使用正常价格
                    total = self.CommonModel.activityCount - self.CommonModel.activitySellCount;
                    
                    NSArray *string_s = @[[NSString stringWithFormat:@"¥ %@ ",price],pricestatu,self.CommonModel.goodsName];
                    cell.name.attributedText = [NSString changestringArray:string_s colorArray:@[kThemeColor,kThemeColor,[UIColor blackColor]] fontArray:@[@"19",@"14",@"17"]];
                    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                    return cell;
                }else if (self.VC_type == GoodDetail_JF){
                 
                    
                    if ([self.CommonModel.goodsPromotionPrice floatValue] == 0) {
                     
                        NSArray *string_s = @[[NSString stringWithFormat:@"积分:%@\n\n",self.CommonModel.score],[NSString stringWithFormat:@"销量：%ld",self.CommonModel.activitySellCount],[NSString stringWithFormat:@"   库存：%ld",self.CommonModel.activityCount - self.CommonModel.activitySellCount],[NSString stringWithFormat:@"   浏览量：%@\n\n",self.CommonModel.goodsClick],self.CommonModel.goodsName];
                        cell.name.attributedText = [NSString changestringArray:string_s colorArray:@[kThemeColor,[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor blackColor]] fontArray:@[@"19",@"14",@"14",@"17"]];
                    }else{
                        
                        NSArray *string_s = @[[NSString stringWithFormat:@"积分:%@",self.CommonModel.score],@" + ",[NSString stringWithFormat:@"¥ %@\n\n",self.CommonModel.goodsPromotionPrice],[NSString stringWithFormat:@"销量：%ld",self.CommonModel.activitySellCount],[NSString stringWithFormat:@"   库存：%ld",self.CommonModel.activityCount - self.CommonModel.activitySellCount],[NSString stringWithFormat:@"   浏览量：%@\n\n",self.CommonModel.goodsClick],self.CommonModel.goodsName];
                        cell.name.attributedText = [NSString changestringArray:string_s colorArray:@[kThemeColor,[UIColor lightGrayColor],kThemeColor,[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor blackColor]] fontArray:@[@"19",@"15",@"14",@"14",@"14",@"17"]];
                    }
                    return cell;
                    
                }else if (self.VC_type == GoodDetail_RM){
                    
                    pricestatu = @"热卖价";
                }
                else if([self.CommonModel.storeId integerValue] == 1 || self.CommonModel.isOwnShop == 1) {
                    
                    pricestatu = @"自营价";
                }
   
                NSArray *string_s = @[[NSString stringWithFormat:@"¥ %@ ",price],pricestatu,[NSString stringWithFormat:@"积分：%@\n\n",self.CommonModel.score],[NSString stringWithFormat:@"销量：%ld",saleNum],[NSString stringWithFormat:@"   库存：%ld",total],[NSString stringWithFormat:@"   浏览量：%@\n\n",self.CommonModel.goodsClick],self.CommonModel.goodsName];
                cell.name.attributedText = [NSString changestringArray:string_s colorArray:@[kThemeColor,kThemeColor,[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor blackColor]] fontArray:@[@"19",@"14",@"14",@"14",@"14",@"14",@"17"]];
            }
             cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1){
      
        
        XZXGoodDetail_companyInformationTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXGoodDetail_companyInformationTCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableString *mustr = [NSMutableString string];
        
        for (NSDictionary *dic in self.CommonModel.type) {
            
            [mustr appendString:[NSString stringWithFormat:@" %@",[dic valueForKey:@"spName"]]];
        }
        cell.content_lab.text = [NSString stringWithFormat:@"已选 ：请选择 %@",mustr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
         //发货地址
            GoodDetail_SendGoodAddress *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_SendGoodAddressID" forIndexPath:indexPath];
            [cell.SendAddressBtn setTitle:[NSString stringWithFormat:@"%@ | 快递：¥ %@",self.CommonModel.sellAddress,self.CommonModel.expressFee] forState:UIControlStateNormal];
            if (self.VC_type == GoodDetail_CommonTV || self.VC_type == GoodDetail_JF) {
           
                 cell.sales.text = [NSString stringWithFormat:@"月销 %@",self.CommonModel.goodsSalenum];
            }else if (self.VC_type == GoodDetail_ZC){
                
                cell.sales.text = @"";
            }else{
                cell.sales.text = [NSString stringWithFormat:@"月销 %ld",self.CommonModel.activitySellCount];
            }
           
             cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }else if(indexPath.row == 1){
            if (self.VC_type == GoodDetail_ZC) {
                
                 GoodDetail_coupon4 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_coupon4ID" forIndexPath:indexPath];
                cell.transport_lab.text = [NSString stringWithFormat:@"预计%@开始发货",self.CommonModel.pregoodsDeliverDate];
                return cell;
            }else{
             
                //优惠券
                GoodDetail_coupon1 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_coupon1ID" forIndexPath:indexPath];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                return cell;
            }
        }else if (indexPath.row == 2){
            
            if (self.VC_type == GoodDetail_ZC) {
                
                GoodDetail_coupon5 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_coupon5ID" forIndexPath:indexPath];
                if (self.CommonModel.content.count > 0) {
                    //商品包含了服务
                    cell.content_lb.text = [[self.CommonModel.content objectAtIndex:0] valueForKey:@"title"];
                }
                return cell;
            }else{
                
                GoodDetail_coupon2 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_coupon2ID" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                return cell;
            }
        }else{
            
            GoodDetail_coupon3 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_coupon3ID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }
        
    }else if (indexPath.section == 3){
        
        XZXGoodDetail_companyInformationTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXGoodDetail_companyInformationTCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            
            XZXGoodDetail_EvalutionHeadTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXGoodDetail_EvalutionHeadTCID" forIndexPath:indexPath];
            cell.textLabel.text = [NSString stringWithFormat:@"用户评价（%@）",self.EvalutionListModel.countAll];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row == 1){
            
            GoodDetail_Evalution1 *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_Evalution1ID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.MyModel = self.EvalutionListModel;
            return cell;
        }else{
            
            XZXShopEvalution_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopEvalution_TCID" forIndexPath:indexPath];
            cell.MyModel = [self.EvalutionListModel.data objectAtIndex:0];
            return cell;
        }
    }else{
        
        GoodDetail_goodImage *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodImageID" forIndexPath:indexPath];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
        cell.picString = self.CommonModel.mobileBody[indexPath.row];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        [self GetGood_GuiGe];
    }else if (indexPath.section == 2){
    
        if (self.VC_type == GoodDetail_ZC && indexPath.row == 2) {
          
            //查看服务
           XZXServicesListVC *VC = [[XZXServicesListVC alloc]initWithNibName:@"XZXServicesListVC" bundle:nil];
            VC.dataSource = self.CommonModel.content;
            [VC  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.providesPresentationContextTransitionStyle = YES;
            self.definesPresentationContext = YES;
            
            [self presentViewController:VC animated:YES completion:^{
                
            }];

        }
    }else if (indexPath.section == 3){
     
        XZXStoreInformationTVC *VC = kStoryboradController(@"Store", @"XZXStoreInformationTVCID");
        VC.storeId =self.CommonModel.storeId;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 4 && indexPath.row == 0){
        //所有评价
        XZXEvalutionListTVC *TVC = kStoryboradController(@"Homepage", @"XZXEvalutionListTVCID");
        TVC.gevalGoodsid = self.CommonModel.goodsId;
        [self.navigationController pushViewController:TVC animated:YES];
        
    }else if (indexPath.section == 5){
        
        self.ImageBrowser = [YBImageBrowser new];
        self.ImageBrowser.dataSourceArray = self.ImageBrowser_dataSource;
        self.ImageBrowser.currentIndex = indexPath.row;
        [self.ImageBrowser show];
    }
}
-(void)DidSelectAdvertisementIndex:(NSInteger )index{
    
    NSMutableArray *array = [NSMutableArray array];
    for (goodsImagesListModel *AdvModel in self.CommonModel.goodsImagesList) {
        
        
        YBImageBrowseCellData *data0 = [YBImageBrowseCellData new];
        data0.url = kImageUrl(self.CommonModel.storeId,AdvModel.goodsImage);
        [array addObject:data0];
    }
    
    self.ImageBrowser = [YBImageBrowser new];
    
    self.ImageBrowser.dataSourceArray = array;
    self.ImageBrowser.currentIndex = index;
    [self.ImageBrowser show];
}
#pragma mark 分享
-(void)rightButtonItemOnClicked:(NSInteger)index{

    __weak typeof(self) weakSelf = self;
    ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给好友"
                                               icon:@"Action_Share"
                                            handler:^{ [weakSelf itemAction:0]; }];
    
    ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                               icon:@"Action_Moments"
                                            handler:^{ [weakSelf itemAction:1]; }];
    
    ZYShareItem *item2 = [ZYShareItem itemWithTitle:@"收藏"
                                               icon:@"Action_MyFavAdd"
                                            handler:^{ [weakSelf itemAction:2]; }];
    
    // 创建shareView
    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:@[item0, item1, item2]
                                                    functionItems:@[]];
    // 弹出shareView
    [shareView show];
}

- (void)itemAction:(NSInteger )title
{
    NSMutableString *mustr = [NSMutableString stringWithString:@"http://118.31.120.17/mobile/goods_details?storeId="];
    [mustr appendString:self.CommonModel.storeId];
    [mustr appendString:[NSString stringWithFormat:@"&goodsId=%@",self.CommonModel.goodsId]];
    [mustr appendString:[NSString stringWithFormat:@"&memberId=%@",@(kUser.member_id)]];
    [mustr appendString:[NSString stringWithFormat:@"&userId=%@",@(kUser.member_id)]];
    [mustr appendString:[NSString stringWithFormat:@"&token=%@",kUser.token]];
    [mustr appendString:[NSString stringWithFormat:@"&activityType=%ld",self.CommonModel.goodsPromotionType]];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = mustr;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.CommonModel.goodsName;
    message.description = self.CommonModel.goodsName;
    [message setThumbImage:[UIImage imageNamed:@"AppLogo"]];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    switch (title) {
        case 0:
        {
            req.scene = WXSceneSession;
        }
            break;
        case 1:
        {
            req.scene = WXSceneTimeline;
        }
            break;
        case 2:
        {
            req.scene = WXSceneFavorite;
        }
            break;
        default:
            break;
    }
    [WXApi sendReq:req];
    
#if 0
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = @"云端至上";
    req.scene = WXSceneSession;
    
    switch (title) {
        case 0:
        {
            req.scene = WXSceneSession;
        }
            break;
        case 1:
        {
            req.scene = WXSceneTimeline;
        }
            break;
        case 2:
        {
            req.scene = WXSceneFavorite;
        }
            break;
        default:
            break;
    }
    
    [WXApi sendReq:req];
#endif
}

#pragma mark 普通、自营 底部按钮

- (IBAction)CS_Action:(id)sender {
    
    [self UserCS];
}

- (IBAction)Collection_Action:(id)sender {
    
    
    [self UserCollectionGood];
    
}

- (IBAction)BuyCar_Action:(id)sender {
    
    XZXShopCarListVC *VC = kStoryboradController(@"ShopCar", @"XZXShopCarListVCID");
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark 获取商品规格
//下单时判断有没有规格
-(void)GetGood_GuiGe{
    
    
    
    if (self.VC_type == GoodDetail_ZC) {
        
        
        XZXShopGoodSelect_ZC_VC *VC = [[XZXShopGoodSelect_ZC_VC alloc]initWithNibName:@"XZXShopGoodSelect_ZC_VC" bundle:nil];
        
        VC.GoodModel = self.CommonModel;
        VC.BuyGoods = ^(XZX_GoodDetail_CommonModel * _Nonnull GoodModel, NSMutableArray * _Nonnull Select_DataArray_GuiGe, NSInteger buy_type) {
            
            XZXShopGood_UploadOrderVC *UploadOrderVC = kStoryboradController(@"Homepage", @"XZXShopGood_UploadOrderVCID");
            UploadOrderVC.activitytype = self.CommonModel.goodsPromotionType;
            UploadOrderVC.UploadOrder_type = Actity_ZC;
            UploadOrderVC.ZC_type = buy_type;
            UploadOrderVC.CommonModel = GoodModel;
            UploadOrderVC.GuiGe_Array = Select_DataArray_GuiGe;
            
            [self.navigationController pushViewController:UploadOrderVC animated:YES];
        };
        
        [VC  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        
        [self presentViewController:VC animated:YES completion:^{
            
        }];
    }else{
        
        
    
    
    XZXShopGoodSelectVC *VC = [[XZXShopGoodSelectVC alloc]initWithNibName:@"XZXShopGoodSelectVC" bundle:nil];
    
    VC.GoodModel = self.CommonModel;
    VC.JF_type   = self.JF_type;
    VC.BuyGoods = ^(XZX_GoodDetail_CommonModel *GoodModel, NSMutableArray *Select_DataArray_GuiGe) {
        
        
        XZXShopGood_UploadOrderVC *UploadOrderVC = kStoryboradController(@"Homepage", @"XZXShopGood_UploadOrderVCID");
        UploadOrderVC.activitytype = self.CommonModel.goodsPromotionType;
        switch (self.VC_type) {
            case GoodDetail_CommonTV:
            {
            
                UploadOrderVC.UploadOrder_type = Good_Order;
            }
                break;
            case GoodDetail_ZY:
            case GoodDetail_RM:
                {
                    UploadOrderVC.UploadOrder_type = Actity_ZY;
                    
                }
                break;
            case GoodDetail_TG:
            {
                UploadOrderVC.UploadOrder_type = Actity_TG;
             
            }
                break;
            case GoodDetail_MS:
            {
                UploadOrderVC.UploadOrder_type = Actity_MS;
               
                
            }
                break;
            case GoodDetail_Agent:
            {
                UploadOrderVC.UploadOrder_type = Actity_Agent;
            }
                break;
            case GoodDetail_ZC:
            {
                 UploadOrderVC.UploadOrder_type = Actity_ZC;
            }
                break;
            case GoodDetail_JF:
            {
                UploadOrderVC.UploadOrder_type = Actity_JF;
                UploadOrderVC.JF_type = self.JF_type;
            }
                break;
            
            default:
                break;
        }
        
        UploadOrderVC.CommonModel = GoodModel;
        UploadOrderVC.GuiGe_Array = Select_DataArray_GuiGe;
        
        [self.navigationController pushViewController:UploadOrderVC animated:YES];
    };
   
    if (self.VC_type == GoodDetail_MS) {
       
        
        if (self.LastTime <= 0) {
            VC.LastTime = 0;
        }else{
    
                VC.LastTime = self.LastTime;
        }
    
    }else{
        
        VC.LastTime = -1;
    }
    
    [VC  setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    
    [self presentViewController:VC animated:YES completion:^{
        
    }];
    }
}


//加入购物车
- (IBAction)AddToBuyCar_Action:(id)sender {
     [self GetGood_GuiGe];
}

-(void)UploadOrder_AddCar_Action:(NSDictionary *)dic{
    
     [self GetGood_GuiGe];
}
//立即购买
- (IBAction)Buy_Action:(id)sender {
    
    [self GetGood_GuiGe];
}


-(void)UploadOrder_Buy_Action:(NSDictionary *)dic{


    XZXShopGood_UploadOrderVC *VC = kStoryboradController(@"Homepage", @"XZXShopGood_UploadOrderVCID");
     VC.activitytype = self.CommonModel.goodsPromotionType;
    switch (self.VC_type) {
        case GoodDetail_CommonTV:
        case GoodDetail_JF:
        {
            VC.UploadOrder_type = Good_Order;
        }
            break;
        case GoodDetail_ZY:
        case GoodDetail_RM:
        {
            VC.UploadOrder_type = Actity_ZY;
         
        }
            break;
        case GoodDetail_TG:
        {
            VC.UploadOrder_type = Actity_TG;
          
        }
            break;
        case GoodDetail_MS:
        {
            VC.UploadOrder_type = Actity_MS;
        }
            break;
        case GoodDetail_ZC:
        {
            VC.UploadOrder_type = Actity_ZC;
        }
            break;
        default:
            break;
    }
    
    VC.CommonModel = self.CommonModel;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 秒杀、团购 底部按钮
- (IBAction)special_CS_Action:(id)sender {

    [self UserCS];
}


- (IBAction)special_Collection_Action:(id)sender {
    
    [self UserCollectionGood];

}


- (IBAction)special_Buy_Action:(id)sender {
    
    if (self.VC_type == GoodDetail_MS &&
        self.LastTime <= 0) {
        
        
        [MBProgressHUD xh_showHudWithMessage:self.AlertMessage toView:self.view completion:^{
            
        }];
        return;
    }else if (self.VC_type == GoodDetail_ZC){
        
        if ([[XHTools getNowTimeTimestamp_HaoMiao] compare:self.CommonModel.activityEndDate]==NSOrderedAscending != 1) {
            
            return;
        }
    }
    
    [self GetGood_GuiGe];

}

-(void)UserCS{
    
    XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.storeId = self.CommonModel.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
-(void)UserCollectionGood{
    
    if (self.CommonModel.favoritesFlag == 0) {
        //收藏
        [XHNetworking xh_postWithoutSuccess:@"favorites/insertFavorites" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"favType":@"goods",@"favId":self.CommonModel.goodsId} success:^(XHResponse *responseObject) {
            
            [MBProgressHUD xh_showHudWithMessage:@"成功收藏" toView:self.view completion:^{
                
            }];
            self.CommonModel.favoritesFlag = 1;
            self.special_CollectionBtn.selected = YES;
            self.CollectionBtn.selected = YES;
        }];
    }
    else{
        //取消收藏
        [XHNetworking xh_postWithoutSuccess:@"favorites/removeByMemberIdAndFacId" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"favType":@"goods",@"favId":self.CommonModel.goodsId} success:^(XHResponse *responseObject) {
            
            [MBProgressHUD xh_showHudWithMessage:@"成功取消收藏" toView:self.view completion:^{
                
            }];
            self.CommonModel.favoritesFlag = 0;
            self.special_CollectionBtn.selected = false;
            self.CollectionBtn.selected = false;
            
        }];
    }
}


//活动商品进入购物车
- (IBAction)Car_Action:(id)sender {
    
    XZXShopCarListVC *VC = kStoryboradController(@"ShopCar", @"XZXShopCarListVCID");
    [self.navigationController pushViewController:VC animated:YES];
}
@end
