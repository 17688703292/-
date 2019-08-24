//
//  XZXStoreVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXStoreVC.h"
#import "XZXStoreInformationTVC.h"
#import "XZX_GoodDetail_CommonTV.h"
#import "ZWPullMenuView.h"
#import "XZXSearchResultVC.h"


#import "XZXStore_InformationCell.h"
#import "XZXStore_ActivityClassTC.h"
#import "XZXHome_ProduceListTC.h"
#import "XZXClass_good_TC.h"
#import "UINavigationBar+Awesome.h"
#import "XZXStoreHeadView.h"
#import "XZXHome_ClassCell.h"

#import "XZXStoreInformationModel.h"
#import "XZXHome_activityModel.h"
#import "XZXHome_classModel.h"

@interface XZXStoreVC ()<UITableViewDelegate,UITableViewDataSource,XZXStore_ActivityClassTCDelegate,XZXHome_ProduceListTCDelegate,XZXClass_good_TCDelegate,XZXStore_InformationCellDelegate,XZXHome_ClassCellDelegate,UISearchBarDelegate>

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) NSInteger SelectIndex;//选择的活动
@property (nonatomic,strong) XZXStoreInformationModel *MyModel;
@property (nonatomic,strong)NSMutableArray *ActivityClass_Array;//保存活动列表
@property (nonatomic,strong)NSMutableArray *GoodClass_Array;//保存商品分类列表
@property (nonatomic,strong)NSMutableDictionary *SelectGoodClass;//保存对应活动下选择的商品分类
@property (nonatomic,strong)XZXStoreHeadView *headView;
@property (nonatomic,strong)ZWPullMenuView *menuView;//下拉菜单
@end

@implementation XZXStoreVC

-(void)viewDidLoad{
    [super viewDidLoad];

    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    self.CustomerTableView.tableFooterView = [UIView new];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.estimatedRowHeight = 0;
    self.CustomerTableView.estimatedSectionHeaderHeight = 0;
    self.CustomerTableView.estimatedSectionFooterHeight = 0;
    [self SearchBarInNavigation];
    [self addRightItemWithIconName:@"fenxiang_bai"];
    
    
    
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXStore_InformationCell" bundle:nil] forCellReuseIdentifier:@"XZXStore_InformationCellID"];

     [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXStore_ActivityClassTC" bundle:nil] forCellReuseIdentifier:@"XZXStore_ActivityClassTCID"];
     [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXHome_ProduceListTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_ProduceListTCID"];
     [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXClass_good_TC" bundle:nil] forCellReuseIdentifier:@"XZXClass_good_TCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXHome_ClassCell" bundle:nil] forCellReuseIdentifier:@"XZXHome_ClassCellID"];
    
    NSArray *array = @[self.two_View,self.four_View];
    for (NSInteger j =0; j < array.count; j++) {
     
        UIView *view = array[j];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewMore_Action:)];
        [view addGestureRecognizer:tap];
    }
    
    
    NSArray *array_temp = @[@{@"type":@"1",@"selectImage":@"shouye_xuanzhong1",@"Image":@"shouye_weixuanzhong1",@"name":@"首页"},
                                @{@"type":@"2",@"selectImage":@"quanbushangpin_xuanzhong",@"Image":@"quanbushangpin_weixuanzhong",@"name":@"全部商品"},
                                @{@"type":@"3",@"selectImage":@"zuixinshangpin_xuanzhong",@"Image":@"zuixinshangpin_weixuanzhong",@"name":@"最新商品"},
                                @{@"type":@"4",@"selectImage":@"huodongshangpin_xuanzhong",@"Image":@"huodongshangpin_weixuanzhong",@"name":@"活动商品"}];
    self.SelectGoodClass = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in array_temp) {
   
        XZXHome_activityModel *Model = [XZXHome_activityModel new];
        Model.activityName  = [dic valueForKey:@"name"];
        Model.activityImage = [dic valueForKey:@"Image"];
        Model.activitySelectImage = [dic valueForKey:@"selectImage"];
        Model.activityType = [dic valueForKey:@"type"];
        Model.priceRange = @"";
        [self.SelectGoodClass setObject:@"0" forKey:[dic valueForKey:@"type"]];
        
        [self.ActivityClass_Array addObject:Model];
    }
    
    
    self.SelectIndex = 1;
    //获取商品分类
    [self GetgoodClass];

}


-(NSMutableArray *)ActivityClass_Array{
    
    if (!_ActivityClass_Array) {
        
        _ActivityClass_Array = [NSMutableArray array];
    }
    
    return _ActivityClass_Array;
}

-(NSMutableArray *)GoodClass_Array{
    
    if (!_GoodClass_Array) {
        _GoodClass_Array = [NSMutableArray array];
    }
    return _GoodClass_Array;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // self.navigationController.navigationBar.hidden = YES;
#if 0
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
     
                           forBarPosition:UIBarPositionAny
     
                               barMetrics:UIBarMetricsDefault];   // 设置navigationBar的颜色为透明的
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
#endif 
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = false;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 50) {
//        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
//        [self.navigationController.navigationBar lt_setBackgroundColor:[kThemeColor colorWithAlphaComponent:alpha]];
//    } else {
//        [self.navigationController.navigationBar lt_setBackgroundColor:[kThemeColor colorWithAlphaComponent:0]];
//    }
}


-(void)SetManualRefresh{

    dispatch_async(dispatch_get_main_queue(), ^{

        self.CustomerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            //先判断数据库是否有第一页的数据，取出来做临时显示。
            [self GetInformation];
        }];
        [self.CustomerTableView.mj_header beginRefreshing];


        self.CustomerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
 
                //首页不需要上k拉加载新数据
                if (self.total > self.MyModel.goods.count) {
                 
                    self.page = self.MyModel.goods.count/10 +1;
                    [self GetInformation];
                }else{
                    
                    [self.CustomerTableView.mj_footer endRefreshing];
                    [MBProgressHUD xh_showHudWithMessage:@"这是我最后的底线，别拉啦" toView:self.view completion:^{
                        
                    }];
                }
            
        }];
    });
}

-(void)GetInformation{
    
    //1、分类ID
    NSString *gcid = [NSString string];
    [[self.SelectGoodClass allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.SelectIndex]] ? [self.SelectGoodClass valueForKey:[NSString stringWithFormat:@"%ld",self.SelectIndex]] : @"";
   
    if ( [[self.SelectGoodClass allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.SelectIndex]] && self.SelectIndex != 1) {
        gcid = ((XZXHome_classModel *)[self.GoodClass_Array objectAtIndex:[[self.SelectGoodClass valueForKey:[NSString stringWithFormat:@"%ld",self.SelectIndex]] integerValue]]).gcId;
    }
    //2、筛选价格
    
    XZXHome_activityModel *model = [self.ActivityClass_Array objectAtIndex:self.SelectIndex-1];
    NSString *startprice = @"0";
    NSString *endprice   = @"";
    if ([model.priceRange containsString:@" "]) {
        
        NSArray *array = [model.priceRange componentsSeparatedByString:@" "];
        startprice = [array objectAtIndex:0];
        endprice   = [array objectAtIndex:2];
    }else if ([model.priceRange isEqualToString:@"10000元以上"]){
        
        startprice = @"";
        endprice = @"10000";
    }
    
    [XHNetworking xh_postWithoutSuccess:@"store/getStore" parameters:@{@"storeId":self.storeId,@"type":[NSString stringWithFormat:@"%ld",self.SelectIndex],@"gcId":gcid,@"startPrice":startprice,@"endPrice":endprice,@"page":@(self.page),@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {
        
        [self.CustomerTableView.mj_header endRefreshing];
        [self.CustomerTableView.mj_footer endRefreshing];
            
    
        if (responseObject.code == 200 &&
            [responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            
            if (self.page == 1) {
                
                
                [self.MyModel.goods removeAllObjects];
                if ([[responseObject.data allKeys] containsObject:@"count"]) {
                    
                    self.total =  [[responseObject.data valueForKey:@"count"] integerValue];
                }
                
                self.MyModel = [XZXStoreInformationModel yy_modelWithJSON:responseObject.data];
            }else{
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {
                    [self.MyModel.goods addObject:[XZXClass_two_good_Model yy_modelWithJSON:dic]];
                }
            }
            
            [self.CustomerTableView reloadData];
       
        }
    }];
}

-(void)GetgoodClass{
    
    [XHNetworking xh_postWithoutSuccess:@"store/getStoreGc" parameters:@{@"userId":@(kUser.member_id),@"token":kUser.token,@"storeId":self.storeId} success:^(XHResponse *responseObject) {
      
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject.data) {
                [self.GoodClass_Array addObject:[XZXHome_classModel yy_modelWithJSON:dic]];
            }
             [self SetManualRefresh];
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 3 && self.SelectIndex == 1) {
        
        return 60;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headView = [[[NSBundle mainBundle]loadNibNamed:@"XZXStoreHeadView" owner:nil options:nil] firstObject];
    self.headView.ViewMoreBlock = ^{
        
    };
    
    return self.headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.MyModel.storeId integerValue] == 0) {
        return 0;
    }
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        
        return kScreenWidth*0.48;
    }else if (indexPath.section == 1){
        
      
        return kScreenWidth/5.0 + 1;
    }else if (indexPath.section == 2){
        
        if (self.SelectIndex != 1) {
            return 50;
        }
        if (self.MyModel.storeImages.count == 0) {
           
            return 0;
        }else{
        
            return kScreenWidth/3.0;
        }
        
    }else if (indexPath.section == 3){
     
        return 20;
    }else{
    
        
        NSInteger num = self.MyModel.goods.count%2 > 0? self.MyModel.goods.count/2 +1 : self.MyModel.goods.count/2;
        
        return ((kScreenWidth-20)/2+115)*num;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        XZXStore_InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXStore_InformationCellID" forIndexPath:indexPath];
        [cell.storeImage sd_setImageWithURL:kImageUrl(self.MyModel.storeId, self.MyModel.storeAvatar) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.storeName.text = self.MyModel.storeName;
        cell.storeFans.text = self.MyModel.favoriteCount;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.MyModel.favoriteFlag integerValue] == 1) {
         
            [cell.favority setTitle:@"已收藏" forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.section == 1){
        
        XZXStore_ActivityClassTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXStore_ActivityClassTCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataArray = self.ActivityClass_Array;
        cell.delegate = self;
        cell.SelectIndex = self.SelectIndex;
        [cell.CustomerCollectionView reloadData];
        return cell;
    }else if (indexPath.section == 2){
        
        if (self.SelectIndex == 1) {
            
            if (self.MyModel.storeImages.count != 0) {
             
                XZXHome_ProduceListTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_ProduceListTCID" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                
                [cell.dataSourceUrl removeAllObjects];
                [cell.dataSourceLink removeAllObjects];
                [cell.dataSourceTitle removeAllObjects];
           
                
                for (NSDictionary *dic in self.MyModel.storeImages) {
                    
                    [cell.dataSourceUrl addObject:[NSURL URLWithString:[dic valueForKey:@"storeImages"]]];
                //    [cell.dataSourceLink addObject:@""];
                }
                cell.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                cell.cycleScrollview.clipsToBounds = true;
                cell.cycleScrollview.imageURLStringsGroup = cell.dataSourceUrl;
                cell.cycleScrollview.titlesGroup = cell.dataSourceTitle;
                
                return cell;
            }else{
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                }
                return cell;
            }
        }
        else{
            
            XZXHome_ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_ClassCellID" forIndexPath:indexPath];
            
            NSInteger CurrentClass = [[self.SelectGoodClass valueForKey:[NSString stringWithFormat:@"%ld",self.SelectIndex]] integerValue];
            cell.Current_class = CurrentClass;
            cell.dataArray = self.GoodClass_Array;
            [cell.CustomerCollecell reloadData];
            XZXHome_activityModel *Model = [self.ActivityClass_Array objectAtIndex:self.SelectIndex-1];
            if (([Model.priceRange length] == 0)) {
                
                [cell.MoreClassBtn setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
            }else{
                
              
                [cell.MoreClassBtn setTitle:Model.priceRange forState:UIControlStateNormal];
            }
            
            [cell.MoreClassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (CurrentClass < self.GoodClass_Array.count) {
             
             
                     [cell.CustomerCollecell scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:CurrentClass inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
            cell.delegate = self;
            return cell;
        }
        
    }
    else if (indexPath.section == 3){
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.backgroundColor = kBackgroundColor;
        return cell;
    }
    else{
        
        XZXClass_good_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXClass_good_TCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.GoodModel_dataSource = self.MyModel.goods;
        [cell.CustomerCVC reloadData];
        return cell;
    }
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
    
}
#pragma mark 选择活动
-(void)DidselectActivityClass:(NSInteger )item{
    
    self.SelectIndex = item+1;
    self.page = 1;
    [self GetInformation];
}


#pragma mark 选择商品三级分类
-(void)DidselectClass:(NSInteger )item{
    
    [self.SelectGoodClass setObject:[NSString stringWithFormat:@"%ld",item] forKey:[NSString stringWithFormat:@"%ld",self.SelectIndex]];
    self.page = 1;
    [self GetInformation];

}

#pragma mark 价格筛选
-(void)DidSelectPrice:(UIButton *)sender{
    

    NSArray *array = @[@"价格筛选",
                       @"0 - 100 元",
                       @"100 - 500 元",
                       @"500 - 1000 元",
                       @"1000 - 3000 元",
                       @"3000 - 10000 元",
                       @"10000元以上"];
     self.menuView = [ZWPullMenuView pullMenuAnchorView:sender titleArray:array];
    
    __weak __typeof(self) weakSelf = self;
    self.menuView.blockSelectedMenu = ^(NSInteger menuRow) {
    
        XZXHome_activityModel *model = [weakSelf.ActivityClass_Array objectAtIndex:weakSelf.SelectIndex-1];
        model.priceRange = [array objectAtIndex:menuRow];
        [weakSelf.CustomerTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf GetInformation];
    };
}

#pragma mark 底部操作
-(void)ViewMore_Action:(UITapGestureRecognizer *)tap{
    
    if ([tap.view isEqual:self.two_View]){
     
        XZXStoreInformationTVC *VC = kStoryboradController(@"Store", @"XZXStoreInformationTVCID");
        VC.storeId = self.storeId;
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([tap.view isEqual:self.four_View]){
        
        [XHNetworking xh_postWithoutSuccess:@"store/getStoreDetails" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"storeId":self.storeId} success:^(XHResponse *responseObject) {
            
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
}


#pragma mark 关注店铺
-(void)DidSelectfavority{
    if ([self.MyModel.favoriteFlag integerValue] == 0) {
        
        [XHNetworking xh_postWithoutSuccess:@"favorites/insertFavorites" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"favType":@"store",@"favId":self.storeId} success:^(XHResponse *responseObject) {
            
      
            self.MyModel.favoriteFlag = @"1";
            self.MyModel.favoriteCount = [NSString stringWithFormat:@"%ld",[self.MyModel.favoriteCount integerValue]+1];
            [self.CustomerTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }else{
        
        [XHNetworking xh_postWithoutSuccess:@"favorites/removeByMemberIdAndFacId" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"favType":@"store",@"favId":self.storeId} success:^(XHResponse *responseObject) {
            
            self.MyModel.favoriteFlag = @"0";
            self.MyModel.favoriteCount = [NSString stringWithFormat:@"%ld",[self.MyModel.favoriteCount integerValue] >=1 ? [self.MyModel.favoriteCount integerValue]-1 : 0];
            [self.CustomerTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
    }
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
            TV.VC_type = GoodDetail_JF;
            return;
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:TV animated:YES];
}

#pragma mark 搜索
-(void)SearchBarInNavigation{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-kScreenWidth/7.0*2.0, self.navigationController.navigationBar.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:self.navigationController.navigationBar.bounds];
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"请输入关键字";
    searchBar.showsScopeBar = YES;
    searchBar.delegate    = self;
    UITextField *textfield = [[[searchBar.subviews firstObject] subviews] lastObject];
    textfield.backgroundColor =[UIColor clearColor];
    
    self.navigationItem.titleView = searchBar;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    
    XZXSearchResultVC *VC = [[XZXSearchResultVC alloc]initWithNibName:@"XZXSearchResultVC" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    VC.VC_type = SearchGood_Store;
    VC.sortId  = self.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
    return false;
}
@end


