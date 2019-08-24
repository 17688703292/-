//
//  XZXMineTVC.m
//  Slumbers
//
//  Created by zhu on 2018/12/3.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XZXMineTVC.h"
#import "XZXMinePersonMessage_TC.h"
#import "XZXMineAd_TC.h"
#import "XZXMineOrder_TC.h"
#import "XZXMine_AdressListTVC.h"
#import "XZXMyWalletVC.h"
#import "XZXMine_personInformationTVC.h"
#import "XZXMine_ScoreList.h"
#import "XZXMine_MessageListTVC.h"
#import "XZXMyCollectionVC.h"
#import "XZXMineFriendTVC.h"
#import "XZXMineFeedBackVC.h"
#import "XZXAp_VC.h"
#import "XZXAp_Store_Success.h"
#import "XZXAp_Store_waitting.h"
#import "XZXAp_Store_Fair.h"
#import "XZXMineInvitivyCode.h"
#import "OtherViewController.h"
#import "XZXMineCustomerTVC.h"
#import "XZXMineAboutMeTVC.h"
#import "XZXAp_Store_TwoVC.h"
#import "XZXAp_StoreShow.h"
#import "XZXAp_Product_Fair.h"
#import "XZXAp_Store_UploadMessageVC.h"
#import "XZXMine_ZCTVC.h"


#import "XZXMineAgentVC.h"
#import "XZXMyActivityList.h"
#import "XZXMyAgentGoodListCVC.h"
#import "XZXMineFootCVC.h"
#import "XZXMineSignTVC.h"
#import "XZX_GoodDetail_CommonTV.h"

#import "XZXMine_headView.h"
#import "XZXAfterSale.h"
#import "XZXMineOrderVC.h"
#import "XZXClass_good_TC.h"

#import "CSTools.h"
#import "XZXMinePersonMessageModel.h"
#import "XZXClass_two_good_Model.h"

#import "UINavigationBar+Awesome.h"

@interface XZXMineTVC ()<UIGestureRecognizerDelegate,XZXMinePersonMessageDelegate,XZXClass_good_TCDelegate>

@property (nonatomic,strong)UIView *CodeImage_backGround;//背景图
@property (nonatomic,strong)UIImageView *CodeImage_Max;//二维码放大图

@property (nonatomic,strong) NSMutableArray *dataSource_Myorder;
@property (nonatomic,strong) NSMutableArray *dataSource_MyOther;
@property (nonatomic,strong) XZXMinePersonMessageModel *MyModel;
@property (nonatomic,strong) dispatch_queue_t XZXMineTVC_Queue;

@end

@implementation XZXMineTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMinePersonMessage_TC" bundle:nil] forCellReuseIdentifier:@"XZXMinePersonMessage_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMineAd_TC" bundle:nil] forCellReuseIdentifier:@"XZXMineAd_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMineOrder_TC" bundle:nil] forCellReuseIdentifier:@"XZXMineOrder_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXClass_good_TC" bundle:nil] forCellReuseIdentifier:@"XZXClass_good_TCID"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.bounces = NO;
    self.XZXMineTVC_Queue = dispatch_queue_create("XZXMineTVC_Queue", DISPATCH_QUEUE_CONCURRENT);
   
    dispatch_async(self.XZXMineTVC_Queue, ^{
   
        
         [self GetGoodList];
    });
    self.title = @"我的";
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //YES：允许右滑返回  NO：禁止右滑返回
    return NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
  
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    dispatch_async(self.XZXMineTVC_Queue, ^{
        [self GetInformation];
        [self GetInformationRecode];
    });
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xh_imageWithColor:kThemeColor]
     
                            forBarPosition:UIBarPositionAny
     
                                barMetrics:UIBarMetricsDefault];
    
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated{
    
   // self.navigationController.navigationBar.hidden = false;
}



-(UIView *)CodeImage_backGround{
    if (!_CodeImage_backGround) {
        _CodeImage_backGround = [[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_CodeImage_backGround];
        _CodeImage_backGround.alpha = 0;
        _CodeImage_backGround.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HidenCodeImage_Background_Action)];
        [_CodeImage_backGround addGestureRecognizer:tap];
        _CodeImage_backGround.userInteractionEnabled = YES;
    }
    return _CodeImage_backGround;
}

-(UIImageView *)CodeImage_Max{
    
    if (!_CodeImage_Max) {
        _CodeImage_Max = [[UIImageView alloc]init];
        [_CodeImage_backGround addSubview:_CodeImage_Max];
        [_CodeImage_Max mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).mas_offset(-kScreenHeight/11.0);
            make.width.mas_equalTo(kScreenWidth/3.0*2.0);
            make.height.mas_equalTo(kScreenWidth/3.0*2.0);
        }];
        _CodeImage_Max.alpha = 0;
        _CodeImage_Max.image = [CSTools creatQRcodeWithInfo:[NSString stringWithFormat:@"%ld",kUser.member_id] withSize:CGSizeMake(kScreenWidth/3.0*2.0, kScreenWidth/3.0*2.0)];
    }
    
    return _CodeImage_Max;
}

-(NSMutableArray *)dataSource_Myorder{
    if (!_dataSource_Myorder) {
        _dataSource_Myorder = [NSMutableArray array];
        [_dataSource_Myorder addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"HeadImage":@"daifukuan",@"HeadTitle":@"待付款",@"num":@"0"}]];
        [_dataSource_Myorder addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"HeadImage":@"daifahuo",@"HeadTitle":@"待发货",@"num":@"0"}]];
        [_dataSource_Myorder addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"HeadImage":@"daishouhuo",@"HeadTitle":@"待收货",@"num":@"0"}]];
        [_dataSource_Myorder addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"HeadImage":@"daipingjia",@"HeadTitle":@"评价",@"num":@"0"}]];
        [_dataSource_Myorder addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"HeadImage":@"jintuikuan",@"HeadTitle":@"售后",@"num":@"0"}]];
     ;
    }
    return _dataSource_Myorder;
}

-(NSMutableArray *)dataSource_MyOther{
    if (!_dataSource_MyOther) {
        _dataSource_MyOther = [NSMutableArray array];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"shoucang_wode",@"HeadTitle":@"收藏"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"zuji",@"HeadTitle":@"足迹"}];
        //[_dataSource_MyOther addObject:@{@"HeadImage":@"qianbao",@"HeadTitle":@"钱包"}];
       // [_dataSource_MyOther addObject:@{@"HeadImage":@"zhangdan",@"HeadTitle":@"账单"}];
        //[_dataSource_MyOther addObject:@{@"HeadImage":@"pingtuan_wode",@"HeadTitle":@"拼团"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"miaosha_wode",@"HeadTitle":@"秒杀"}];
       // [_dataSource_MyOther addObject:@{@"HeadImage":@"youhuijuan",@"HeadTitle":@"优惠券"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"shenqingkaidian",@"HeadTitle":@"申请开店"}];
       // [_dataSource_MyOther addObject:@{@"HeadImage":@"jifengouwu",@"HeadTitle":@"积分购物"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"dizhiguanli",@"HeadTitle":@"地址管理"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"woderenyuan",@"HeadTitle":@"我的人缘"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"fenhongjifen",@"HeadTitle":@"分红积分"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"tousuyujianyi",@"HeadTitle":@"投诉与建议"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"yunduangufen",@"HeadTitle":@"云端股份"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"bangzhuyukefu",@"HeadTitle":@"帮助与客服"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"guanyuwomen",@"HeadTitle":@"关于我们"}];
        [_dataSource_MyOther addObject:@{@"HeadImage":@"zhongchou_wode",@"HeadTitle":@"众筹"}];
    }
    
    return _dataSource_MyOther;
    
}

-(void)GetInformation{

    [XHNetworking xh_requestPath:@"yunshop/myInformation" parameters:@{@"token":kUser.token,@"memberId":@(kUser.member_id),@"userId":@(kUser.member_id)} requestType:POST showIndicator:false showSuccess:false showError:false errorResponse:false response:^(XHResponse *responseObject) {
        
        self.MyModel = [XZXMinePersonMessageModel yy_modelWithJSON:responseObject.data];
        kUser.account = self.MyModel.account;
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}

-(void)GetInformationRecode{
    
    

      [XHNetworking xh_requestPath:@"yunshop/getMyOrderAllStatusCount" parameters:@{@"token":kUser.token,@"memberId":@(kUser.member_id),@"userId":@(kUser.member_id)} requestType:POST showIndicator:false showSuccess:false showError:false errorResponse:false response:^(XHResponse *responseObject) {
        
          for (NSInteger j = 0; j < self.dataSource_Myorder.count; j++) {
              NSDictionary *dic = [self.dataSource_Myorder objectAtIndex:j];
              
              switch (j) {
                  case 0:
                  {
                   
                     [dic setValue:[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"status10Count"]] forKey:@"num"];
                  }
                      break;
                  case 1:
                  {
                      [dic setValue:[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"status20Count"]] forKey:@"num"];
                  }
                      break;
                  case 2:
                  {
                      [dic setValue:[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"status30Count"]] forKey:@"num"];
                  }
                      break;
                  case 3:
                  {
                      [dic setValue:[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"status40Count"]] forKey:@"num"];
                  }
                      break;
                      
                  default:
                      break;
              }
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              
              
              [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
          });
      }];
}

-(void)GetGoodList{
    
    [XHNetworking xh_requestPath:@"store/getStore" parameters:@{@"storeId":@"1",@"type":@"1",@"gcId":@"",@"startPrice":@"0",@"endPrice":@"",@"page":@(1),@"userId":@(kUser.member_id),@"token":kUser.token} requestType:POST showIndicator:false showSuccess:false showError:false errorResponse:false response:^(XHResponse *responseObject) {
        if (responseObject.code == 200 &&
            [responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            
            for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {
                
                [self.dataArray addObject:[XZXClass_two_good_Model yy_modelWithJSON:dic]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            });
            
        }
    }];
    
}

#pragma mark - Table view data source



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1 || section == 4) {
        return 30;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        XZXMine_headView *View = [[[NSBundle mainBundle]loadNibNamed:@"XZXMine_headView" owner:nil options:nil] firstObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewAllOrder)];
        [View.ViewAllOrder addGestureRecognizer:tap];
        View.ViewAllOrder.userInteractionEnabled = YES;
        return View;
    }else if (section == 4){
     
        UIView *view = [UIView new];
        view.backgroundColor = kBackgroundColor;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 30)];
        [view addSubview:label];
        label.text = @"专属推荐";
        return view;
    }
    else{
        
        UIView *view = [UIView new];
        view.backgroundColor = kBackgroundColor;
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return kScreenWidth*0.373;
    }else if (indexPath.section == 1){
        
        return  kScreenWidth/5*0.7 + 20;
    }else if (indexPath.section == 3){
        
        NSInteger num = self.dataSource_MyOther.count%4 == 0 ? self.dataSource_MyOther.count/4: self.dataSource_MyOther.count/4 + 1;
        
        return (kScreenWidth/4*0.7 + 20)*num;
    }else if (indexPath.section == 4){
        
        NSInteger num = self.dataArray.count%2 > 0? self.dataArray.count/2 +1 : self.dataArray.count/2;
        return ((kScreenWidth-20)/2+115)*num;
    }
    return kScreenWidth*0.198;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
 
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        XZXMinePersonMessage_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMinePersonMessage_TCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.MyModel = self.MyModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1 ||
              indexPath.section == 3){
        
        XZXMineOrder_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMineOrder_TCID" forIndexPath:indexPath];
      
        if (indexPath.section == 1) {
            cell.model.dataSource = self.dataSource_Myorder;
            cell.Signal_num = 5;
        }else if (indexPath.section == 3){
            cell.model.dataSource = self.dataSource_MyOther;
            cell.Signal_num = 4;
        }
    
    
        cell.CustomerCollView.scrollEnabled = false;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.CustomerCollView reloadData];
        cell.didSelectItemAtIndexPathBlock = ^(NSIndexPath * _Nonnull indexPathBlock) {
          
            if (indexPath.section == 1) {
                
                [self OrderList:indexPathBlock.item];
            }else if(indexPath.section == 3){
                switch (indexPathBlock.item) {
                    case 0:
                        {
                            [self Collection];
                        }
                        break;
                    case 1:
                    {
                        [self MyFeet];
                    }
                        break;
                    case 2:
                    {
                        [self MyMiaoSha];
                    }
                        break;
                    case 3:
                    {
                        [self ApplyStore];
                    }
                        break;
                    case 4:
                    {
                        [self ManagerAdress];
                    }
                        break;
                    case 5:
                    {
                        [self MyFriend];
                    }
                        break;
                    case 6:
                    {
                        [self Integral];
                    }
                        break;
                    case 7:
                    {
                        [self FeedBack];
                    }
                        break;
                    case 8:
                    {
                        
                        OtherViewController *VC = kStoryboradController(@"Login", @"OtherViewControllerID");
                        VC.hidesBottomBarWhenPushed =  YES;
                        VC.title = @"云端股份";
                        VC.ImageStr = @"img_yunduangupiao";
                        VC.contentStr = @"";
                        [self.navigationController pushViewController:VC animated:YES];
                    }
                        break;
                    case 9:
                    {
                        [self Customer];
                    }
                        break;
                    case 10:
                    {
                        
                        [self AboutMe];
                    }
                        break;
                    case 11:
                    {
                        [self MyZhongChou];
                    }
                        break;
                    default:
                        break;
                }
                
            }
        };
        return cell;
    }else if (indexPath.section == 2){
     
        XZXMineAd_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMineAd_TCID" forIndexPath:indexPath];
        
        return cell;
    }else{
        
        XZXClass_good_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXClass_good_TCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.GoodModel_dataSource = self.dataArray;
        [cell.CustomerCVC reloadData];
        cell.CustomerCVC.scrollEnabled = false;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        OtherViewController *VC = kStoryboradController(@"Login", @"OtherViewControllerID");
        VC.hidesBottomBarWhenPushed =  YES;
        VC.title = @"代理礼包";
        VC.ImageStr = @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/12134567890C849E5602F8403E93F39D0C5092840D.png";
        [self.navigationController pushViewController:VC animated:YES];
        
#if 0
        XZXMyAgentGoodListCVC *VC = [[XZXMyAgentGoodListCVC alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
#endif
    }
}

#pragma mark 个人信息
-(void)ViewInformation_Action{
    
    XZXMine_personInformationTVC *VC = kStoryboradController(@"Mine", @"XZXMine_personInformationTVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.MyModel = self.MyModel;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)ViewCode_Action{
    
    XZXMineInvitivyCode *VC = kStoryboradController(@"Mine", @"XZXMineInvitivyCodeID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)HidenCodeImage_Background_Action{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.CodeImage_backGround.alpha = 0;
        self.CodeImage_Max.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}


//签到
-(void)ViewSign_Action{
    
    XZXMineSignTVC *VC = kStoryboradController(@"Mine", @"XZXMineSignTVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.IsSign = self.MyModel.isSignToDay;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)ViewScore_Action{
    
    XZXMine_ScoreList *VC = kStoryboradController(@"Mine", @"XZXMine_ScoreListID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)ViewMessage_Action{
    
    
    XZXMine_MessageListTVC *TVC = [[XZXMine_MessageListTVC alloc]initWithNibName:@"XZXMine_MessageListTVC" bundle:nil];
    TVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 订单列表

-(void)ViewAllOrder{
    
    XZXMineOrderVC *TVC = [XZXMineOrderVC new];
    TVC.selectIndex = AllOrder_VC ;
    TVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TVC animated:YES];
}

-(void)OrderList:(NSInteger )item{
    
    if (item == 4) {
        //售后
        XZXAfterSale *SaleTVC = [[XZXAfterSale alloc]initWithNibName:@"XZXAfterSale" bundle:nil];
        SaleTVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:SaleTVC animated:YES];
        
    }else{
        
        XZXMineOrderVC *TVC = [XZXMineOrderVC new];
        TVC.selectIndex = (int )(item +1) ;
        TVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:TVC animated:YES];
    }
}

#pragma mark 收藏
-(void)Collection{
 
    XZXMyCollectionVC *VC = kStoryboradController(@"Mine", @"XZXMyCollectionVCID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 足迹
-(void)MyFeet{
    
    XZXMineFootCVC *VC = [[XZXMineFootCVC alloc]initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    VC.hidesBottomBarWhenPushed = YES;
    VC.VC_type = VC_foot;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 钱包
-(void)MyWallet{
    
    XZXMyWalletVC *VC = kStoryboradController(@"Mine", @"XZXMyWalletVCID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 收藏
-(void)MyBill{
    
}
#pragma mark 团购
-(void)MyPinTuan{
    
}
#pragma mark 秒杀
-(void)MyMiaoSha{
    
    XZXMyActivityList *VC = [XZXMyActivityList new];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 众筹
-(void)MyZhongChou{
    
    XZXMine_ZCTVC *VC = [[XZXMine_ZCTVC alloc]initWithNibName:@"XZXMine_ZCTVC" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 优惠券
-(void)Coupon{
    
}

#pragma mark 申请开店
-(void)ApplyStore{
    
    [XHNetworking xh_requestAlwaysWithResponse:[NSString stringWithFormat:@"%@store/selectByMemberId",Store_ServiceIP] parameters:@{@"memberId":@(kUser.member_id)} requestType:POST showIndicator:YES response:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            
            switch ([[responseObject.data valueForKey:@"storeState"] integerValue]) {

                case 4:
                {
                    //开店失败
                    XZXAp_Store_Fair *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_FairID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 5:
                {
                 //开店审核中
                    XZXAp_Store_waitting *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_waittingID");
                    one.hidesBottomBarWhenPushed = YES;
                    one.contentStr = @"申请开店审核";
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 6:
                {
                     //未提交申请
                    XZXAp_VC *one = kStoryboradController(@"ApplicationStore", @"XZXAp_VCID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                default:
                {
                     //其它情况 开店成功
                    XZXAp_StoreShow *show =kStoryboradController(@"ApplicationStore", @"XZXAp_StoreShowID");
                    show.VC_type = Finally;
                    show.hidesBottomBarWhenPushed = YES;
                    show.storeNameStr = [responseObject.data valueForKey:@"storeName"];
                    show.storeId = [responseObject.data valueForKey:@"storeId"];
                    [self.navigationController pushViewController:show animated:YES];
                }
                    break;
            }

#if 0
            switch ([[responseObject.data valueForKey:@"storeState"] integerValue]) {
                case 1:
                {
                    //开店成功 资质成功 合同成功
                    XZXAp_StoreShow *show =kStoryboradController(@"ApplicationStore", @"XZXAp_StoreShowID");
                    show.VC_type = Finally;
                    show.hidesBottomBarWhenPushed = YES;
                    show.storeNameStr = [responseObject.data valueForKey:@"storeName"];
                    show.storeId = [[responseObject.data valueForKey:@"storeId"] isKindOfClass:[NSNull class]] ? @"":[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"storeId"]];
                    [self.navigationController pushViewController:show animated:YES];
                }
                    break;
                case 2:
                {
                    //开店成功 资质审核中 合同没有
                    XZXAp_Store_waitting *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_waittingID");
                    one.hidesBottomBarWhenPushed = YES;
                    one.contentStr = @"上传厂家资质审核中";
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 3:
                {
                    //开店成功 资质没有 合同没有
                    XZXAp_StoreShow *show =kStoryboradController(@"ApplicationStore", @"XZXAp_StoreShowID");
                    show.VC_type = upload_message;
                    show.hidesBottomBarWhenPushed = YES;
                    show.storeNameStr = [responseObject.data valueForKey:@"storeName"];
                    show.storeId = [responseObject.data valueForKey:@"storeId"];
                    [self.navigationController pushViewController:show animated:YES];
                }
                    break;
                case 4:
                {
                    //开店失败
                    XZXAp_Store_Fair *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_FairID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 5:
                {
                 //开店审核中
                    XZXAp_Store_waitting *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_waittingID");
                    one.hidesBottomBarWhenPushed = YES;
                    one.contentStr = @"申请开店审核";
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 6:
                {
                    //未提交申请
                    XZXAp_VC *one = kStoryboradController(@"ApplicationStore", @"XZXAp_VCID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 7:
                {
                    //开店成功 资质审核成功 合同没有
                    XZXAp_StoreShow *show =kStoryboradController(@"ApplicationStore", @"XZXAp_StoreShowID");
                    show.VC_type = upload_contract;
                    show.hidesBottomBarWhenPushed = YES;
                    show.productNum = [responseObject.data valueForKey:@"uuid"];
                    show.storeNameStr = [[responseObject.data valueForKey:@"storeName"] isKindOfClass:[NSNull class]] ? @"":[responseObject.data valueForKey:@"storeName"];
                    show.storeId = [[responseObject.data valueForKey:@"storeId"] isKindOfClass:[NSNull class]] ? @"":[NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"storeId"]];
                    [self.navigationController pushViewController:show animated:YES];
                }
                    break;
                case 8:
                
                {
                    //开店成功 资质失败 合同没有
                    XZXAp_Product_Fair *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Product_FairID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 9:
                {
                    //开店成功 有第一张资质表 没有第二张资质表 没有证书
                    
                    XZXAp_Store_UploadMessageVC *VC = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_UploadMessageVCID");
                    VC.storeJoinin1Id = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"manufacturerId"]];
                    VC.classId = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"scId"]];
                    VC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:VC animated:YES];
                }
                    break;
                case 10:
                    //开店成功 资质成功 合同成功 第N次 有第一张资质表 没有第二张资质表
                {
                    
                    XZXAp_Store_UploadMessageVC *VC = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_UploadMessageVCID");
                    VC.storeJoinin1Id = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"manufacturerId"]];
                    VC.classId = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"scId"]];
                    VC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:VC animated:YES];
                }
                    break;
                case 11:
                    //开店成功 资质成功 合同成功 第N次 资质审核失败
                {
                    XZXAp_Product_Fair *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Product_FairID");
                    one.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                case 12:
                    //开店成功 资质成功 合同成功 第N次 资质审核中
                {
                    //开店成功 资质审核中 合同没有
                    XZXAp_Store_waitting *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_waittingID");
                    one.hidesBottomBarWhenPushed = YES;
                    one.contentStr = @"上传厂家资质审核中";
                    [self.navigationController pushViewController:one animated:YES];
                }
                    break;
                default:
                    break;
            }
#endif
        }

    }];

}

#pragma mark 积分购物
-(void)SpendMypoints{
    
}
#pragma mark 地址管理
-(void)ManagerAdress{
    
    
    XZXMine_AdressListTVC *TVC = [XZXMine_AdressListTVC new];
    TVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 我的人缘
-(void)MyFriend{
    
    XZXMineFriendTVC *VC = kStoryboradController(@"Mine", @"XZXMineFriendTVCID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark 分红积分
-(void)Integral{
    
    XZXMineAgentVC *VC = kStoryboradController(@"Mine", @"XZXMineAgentVCID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark 我的投诉
-(void)FeedBack{
    
    XZXMineFeedBackVC *VC = kStoryboradController(@"Mine", @"XZXMineFeedBackVCID");
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark 关注与客服
-(void)Customer{
    
    XZXMineCustomerTVC *VC = [[XZXMineCustomerTVC alloc]initWithNibName:@"XZXMineCustomerTVC" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 关于我们
-(void)AboutMe{
    
    
    XZXMineAboutMeTVC *VC = [[XZXMineAboutMeTVC alloc]initWithNibName:@"XZXMineAboutMeTVC" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 选择商品详情
-(void)EntergoodsDetailVC:(XZXClass_two_good_Model *)model{
    
    //根据不同商品类型进入不同商品页面
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = model.goodsId;
    switch ([model.goodsPromotionType integerValue]) {
        case Command_t:
        {
            TV.VC_type = GoodDetail_CommonTV;
        }
            break;
        case MiaoSha_t:
        {
            TV.VC_type = GoodDetail_MS;
        }
            break;
        case ZhongChou_t:
        {
            TV.VC_type = GoodDetail_CommonTV;
            return;
        }
            break;
        case ReMai_t:
        {
            TV.VC_type = GoodDetail_CommonTV;
            
        }
            break;
        case TuanGou_t:
        {
            TV.VC_type = GoodDetail_TG;
        }
            break;
        case JiFen_t:
        {
            TV.VC_type = GoodDetail_CommonTV;
            return;
        }
            break;
        default:
            break;
    }
    TV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TV animated:YES];
}

@end
