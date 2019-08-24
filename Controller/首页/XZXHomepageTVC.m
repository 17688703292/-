//
//  XZXHomepageTVC1.m
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomepageTVC.h"
#import "XZXHome_Class_StoreCVC.h"
#import "XZXMine_MessageListTVC.h"
#import "XZXStoreVC.h"
#import "XZXSearchResultVC.h"
#import "ZWPullMenuView.h"
#import "OtherViewController.h"
#import "XZXClass_two_TVC.h"
#import "XHLaunchAd.h"


#import "XZXHomeModel.h"
#import "XZXShopGoodTypeHeadCell.h"
#import "XZXClass_good_TC.h"
#import "XZX_GoodList_JFTV.h"

#import "XZXHome_ClassCC.h"
#import "XZXHome_ClassCell.h"
#import "XZXHome_SecondClassTC.h"
#import "XZXHom_CarouselAdvertisementCell.h"
#import "XZXHome_ActivityClassTC.h"
#import "XZXHome_Activity2TC.h"
#import "XZX_Activity2_TVC.h"
#import "XZX_GoodList_MSTV.h"
#import "XZX_GoodDetail_CommonTV.h"

//活动
#import "XZXHome_ActivityHeadTC.h"
#import "XZXHome_Activity_MSTC.h"
#import "XZXHome_Activity_ZYorTG_TC.h"


//自营、团购商品列表
#import "XZX_GoodList_ZYTV.h"

//众筹
#import "XZX_GoodList_ZCTV.h"

//热卖
#import "XZXHomeremai_TC.h"

#import "XZXHome_Activity_ZCTC.h"
#import "XZXHome_Activity_ZC2TC.h"

@interface XZXHomepageTVC ()<UIGestureRecognizerDelegate,XZXHomeHeadViewClasslDelegate,XZXHom_CarouselAdvertisementCellDelegate,XZXHome_ActivityClassTCDelegate,XZXHome_Activity2TCDelegate,XZXHome_ActivityHeadTCDelegate,UISearchBarDelegate,XZXHome_Activity_MSTCDelegate,XZXHome_Activity_ZYorTG_TCDelegate,XZXClass_good_TCDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,XZXHome_Activity_ZC2TCDelegate,XZXHomeremai_TCDelegate>

@property (nonatomic,assign)__block NSInteger  Current_class;//当前选择分类下标
@property (nonatomic,strong)XZXHomeModel *MyModel;

@property (nonatomic,strong)ZWPullMenuView *menuView;//下拉菜单

@property (nonatomic,strong)UIView *searchbackView;
@property (nonatomic,strong)UIView *selectType;
@property (nonatomic,strong)UILabel *searchtype_label;//用户搜索框
@property (nonatomic,copy) NSString *searchtype_str;//用户搜索类型 店铺、商店
@property (nonatomic,strong)dispatch_queue_t XZXHomepageTVC_Queue;

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) NSTimer *LoadIntroducePic_time;
@property (nonatomic,assign) NSInteger LoadIntroducePic_second;
@property (nonatomic,strong) UIImageView *LoadIntroducePic_Image;
@property (nonatomic,strong) UILabel *LoadIntroducePic_label;

@end


@implementation XZXHomepageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadIntroducePic) name:@"LoadIntroducePic" object:nil];
   
    self.XZXHomepageTVC_Queue = dispatch_queue_create("XZXHomepageTVC_Queue", DISPATCH_QUEUE_CONCURRENT);
    self.searchtype_str = @" 商品";
    [self SearchBarInNavigation];
    [self RegisterCell];
    self.Current_class = 0;//
    [self addLeftItemWithIconName:@"yunduanziti"];
    [self addRightItemWithIconName:@"xiaoxi_bai"];
    [self AddReturnTopBtnIconImageName:@"zhiding" frame:CGRectMake(kScreenWidth*0.8, kScreenHeight*0.8, 50, 50) blcok:^{
        
        
    }];
    
    __weak typeof(self) weakSelf = self;
    self.Begain = ^{
        if(weakSelf.classView_Main.dataArray.count > 0){
        
            
            [weakSelf.CustomerTableViewCell scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    };
 
    self.classView_Main = [[[NSBundle mainBundle]loadNibNamed:@"XZXHomeHeadViewClass" owner:nil options:nil] firstObject];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    self.classView_Main.CustomerCollecell.collectionViewLayout = flowLayout;
    [self.classView_Main.CustomerCollecell registerNib:[UINib nibWithNibName:@"XZXHome_ClassCC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_ClassCCID"];
    [self.classView addSubview:self.classView_Main];
    self.classView_Main.delegate = self;
    [self.classView_Main.MoreClassBtn setImage:[UIImage imageNamed:@"quanbufenlei"] forState:UIControlStateNormal];
    
    
    self.CustomerTableViewCell.dataSource = self;
    self.CustomerTableViewCell.delegate   = self;
    self.CustomerTableViewCell.estimatedRowHeight = 0;
    self.CustomerTableViewCell.estimatedSectionHeaderHeight = 0;
    self.CustomerTableViewCell.estimatedSectionFooterHeight = 0;
    [self ManualGetInformation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReturnFisrtClass) name:@"ReturnFisrtClass" object:nil];
    
}

//-(void)LoadIntroducePic{
//    
//    self.LoadIntroducePic_Image.userInteractionEnabled = false;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoadIntroducePic" object:nil];
//    self.LoadIntroducePic_Image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xinyemian"]];
//    self.LoadIntroducePic_Image.frame = [UIApplication sharedApplication].keyWindow.bounds;
//    self.LoadIntroducePic_Image.backgroundColor = [UIColor orangeColor];
//    self.LoadIntroducePic_Image.contentMode = UIViewContentModeScaleAspectFill;
//    [[UIApplication sharedApplication].keyWindow addSubview:self.LoadIntroducePic_Image];
//    self.LoadIntroducePic_second = 3;
//    self.LoadIntroducePic_label = [[UILabel alloc]init];
//    [self.LoadIntroducePic_Image addSubview:self.LoadIntroducePic_label];
//    [self.LoadIntroducePic_label mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.right.mas_equalTo(self.LoadIntroducePic_Image.mas_right).offset(-10);
//        make.top.mas_equalTo(self.LoadIntroducePic_Image.mas_top).offset(20+kNavigationBarHeight);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//    }];
//    self.LoadIntroducePic_label.textAlignment = NSTextAlignmentCenter;
//    self.LoadIntroducePic_label.cornerRadius = 20;
//    self.LoadIntroducePic_label.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.LoadIntroducePic_label.textColor = [UIColor whiteColor];
//    self.LoadIntroducePic_label.layer.borderWidth = 3.0;
//    self.LoadIntroducePic_label.text = [NSString stringWithFormat:@"%ld",self.LoadIntroducePic_second];
//    self.LoadIntroducePic_time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(HidenLoadIntroducePic) userInfo:nil repeats:YES];
//    
//}

-(void)HidenLoadIntroducePic{
    
    --self.LoadIntroducePic_second;
    if (self.LoadIntroducePic_second <= 0) {
        
        [self.LoadIntroducePic_Image removeFromSuperview];
        [self.LoadIntroducePic_time invalidate];
        self.LoadIntroducePic_time = nil;
    }else{
        
         self.LoadIntroducePic_label.text = [NSString stringWithFormat:@"%ld",self.LoadIntroducePic_second];
    }
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //YES：允许右滑返回  NO：禁止右滑返回
    return NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
   
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.ReturnTopBtn.hidden = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    

    self.ReturnTopBtn.hidden = true;
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReturnFisrtClass" object:nil];
}

-(void)ReturnFisrtClass{
    
    if(self.Current_class != 0){
        
        self.Current_class = 0;
        self.page = 1;
        [self GetInformation];
    }
}

-(void)RegisterCell{
    
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_ClassCell" bundle:nil] forCellReuseIdentifier:@"XZXHome_ClassCellID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_SecondClassTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_SecondClassTCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHom_CarouselAdvertisementCell" bundle:nil] forCellReuseIdentifier:@"XZXHom_CarouselAdvertisementCellID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_ActivityClassTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_ActivityClassTCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_ActivityHeadTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_ActivityHeadTCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_Activity_ZYorTG_TC" bundle:nil] forCellReuseIdentifier:@"XZXHome_Activity_ZYorTG_TCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_Activity_MSTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_Activity_MSTCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_Activity2TC" bundle:nil] forCellReuseIdentifier:@"XZXHome_Activity2TCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXClass_good_TC" bundle:nil] forCellReuseIdentifier:@"XZXClass_good_TCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_Activity_ZCTC" bundle:nil] forCellReuseIdentifier:@"XZXHome_Activity_ZCTCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHome_Activity_ZC2TC" bundle:nil] forCellReuseIdentifier:@"XZXHome_Activity_ZC2TCID"];
    [self.CustomerTableViewCell registerNib:[UINib nibWithNibName:@"XZXHomeremai_TC" bundle:nil] forCellReuseIdentifier:@"XZXHomeremai_TCID"];
    self.CustomerTableViewCell.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)ManualGetInformation{
    
    self.CustomerTableViewCell.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [self GetInformation];
        
    }];
    [self.CustomerTableViewCell.mj_header beginRefreshing];
    
    self.CustomerTableViewCell.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.Current_class == 0) {
          
          
            
            [self GetInformation_FirstPage];
            
        }else{
            
            ++ self.page;
            [self GetInformation];
        }
    }];
    
}

#pragma mark 商品推荐列表--首页

-(void)GetInformation_FirstPage{
    
    [XHNetworking xh_postWithoutSuccess:@"homePage/getIntroduceGoods" parameters:@{@"page":@(self.page)} success:^(XHResponse *responseObject) {
     
        
        [self.CustomerTableViewCell.mj_header endRefreshing];
        [self.CustomerTableViewCell.mj_footer endRefreshing];
        
        dispatch_async(self.XZXHomepageTVC_Queue, ^{
            
            
            if (self.page == 1) {
                
                self.MyModel.goods = [NSMutableArray array];
                
            }
            
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
       
                if ([responseObject.data count] > 0) {
                    
                    for (NSDictionary *dic in responseObject.data) {
                        
                        XZXClass_two_good_Model *goodModel = [XZXClass_two_good_Model yy_modelWithJSON:dic];
                        [self.MyModel.goods addObject:goodModel];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        self.classView_Main.Current_class = self.Current_class;
                        self.classView_Main.dataArray = self.MyModel.class;
                        
                        ++ self.page;
                        [self.CustomerTableViewCell reloadData];
                    });
                }
            }
    
        });
    }];
}

#pragma mark 商品推荐列表--分类
-(void)GetInformation{
    
    NSString *gcid = [NSString string];
    if (self.MyModel.activity > 0) {
        
        gcid = ((XZXHome_classModel *)[self.MyModel.class objectAtIndex:self.Current_class]).gcId;
    }
    [XHNetworking xh_postWithoutSuccess:@"homePage/getHomePage" parameters:@{@"gcId1":gcid,@"page":@(self.page)} success:^(XHResponse *responseObject) {
        
        [self.CustomerTableViewCell.mj_header endRefreshing];
        [self.CustomerTableViewCell.mj_footer endRefreshing];
        
        dispatch_async(self.XZXHomepageTVC_Queue, ^{
            
            
            if (self.page == 1) {
                
                [self.MyModel.navigationImage removeAllObjects];
                self.MyModel = [XZXHomeModel yy_modelWithJSON:responseObject.data];
                XZXHome_classModel *classModel = [XZXHome_classModel new];
                classModel.gcId = @"";
                classModel.gcName = @"首页";
                classModel.gcThumb = @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789555E290DB9F544868353CD65C8BA5658.png";
                [self.MyModel.class insertObject:classModel atIndex:0];
                
            }else{
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"goodsByGcId"]) {
                    
                    XZXClass_two_good_Model *goodModel = [XZXClass_two_good_Model yy_modelWithJSON:dic];
                    [self.MyModel.goods addObject:goodModel];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
             
                self.classView_Main.Current_class = self.Current_class;
                self.classView_Main.dataArray = self.MyModel.class;
                [self.classView_Main RefreshUI];
                [self.CustomerTableViewCell reloadData];
            });
        });
        
    }];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 1 || section ==2 || section == 3 || section == 4 || section == 5 || section == 6 || section == 7){return 10;}
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = kBackgroundColor_yun;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            return 0;
        }else{
            
            return kScreenWidth*0.45;
        }
        
    }else if (indexPath.section == 1){
        
        if (self.Current_class == 0) {
            //首页
            if (indexPath.row == 0) {
                
                NSInteger num = is_iPhone5 == YES ? 4 : 5;
                
                return kScreenWidth/num;
                
            }else{
                
                NSInteger num = self.MyModel.activity2.count%3 > 0? self.MyModel.activity2.count/3 +1 : self.MyModel.activity2.count/3;
                
                return ((kScreenWidth-15)/3)*num;
            }
        }else{
            //分类
            if (indexPath.row == 0) {
                
                NSInteger num = is_iPhone5 == YES ? 4 : 5;
                
                NSInteger num_t = [self.MyModel.class objectAtIndex:self.Current_class].goodsClassPc.count%num == 0 ? [self.MyModel.class objectAtIndex:self.Current_class].goodsClassPc.count/num: [self.MyModel.class objectAtIndex:self.Current_class].goodsClassPc.count/num + 1;
                
                return (kScreenWidth/4*0.7 + 20)*num_t;
                
            }else{
                
                NSInteger num = self.MyModel.activity2.count%3 > 0? self.MyModel.activity2.count/3 +1 : self.MyModel.activity2.count/3;
                
                return ((kScreenWidth-15)/3)*num;
            }
            
            
        }
        
    }
    else if (indexPath.section == 3){
        
        //首页--秒杀
            if (indexPath.row == 0) {
                
                return kScreenWidth*0.16;
            }else{
                
                NSInteger num = self.MyModel.spike.list.count%3 > 0? self.MyModel.spike.list.count/3 +1 : self.MyModel.spike.list.count/3;
                if (num >2) {
                    
                    num = 2;
                }
                return (kScreenWidth/3 + 55)*num;
            }
    }else if (indexPath.section == 4){
        //团购
        if (indexPath.row == 0) {
            
           return kScreenWidth*0.16;
        }
        else if (indexPath.row == 1){
            
            return (kScreenWidth-20)/2.0 + 65;
        }
        else{
            NSInteger num = is_iPhone5 == YES ? 3 : 4;
            return (kScreenWidth-20)/num*1.5;
        }
    }else if (indexPath.section == 2){
        //自营
    if (self.Current_class == 0) {
            
        if (indexPath.row == 0) {
            
            return kScreenWidth*0.16;
        }
        else if (indexPath.row == 1){
            
            return kScreenWidth/2+70;
        }
        else{
            NSInteger num = is_iPhone5 == YES ? 3 : 4;
            return (kScreenWidth-35)/num + 70;
        }
    }else{
        
        //分类-产品列表
        NSInteger num = self.MyModel.goods.count%2 > 0? self.MyModel.goods.count/2 +1 : self.MyModel.goods.count/2;
        
        return ((kScreenWidth-20)/2+115)*num;
    }
    }
    else if (indexPath.section == 5){
        //众筹
        if (indexPath.row == 0) {
            
            return kScreenWidth*0.16;
        }
        else if (indexPath.row == 1){
            
            return kScreenWidth/2;
        }
        else{
            if (self.MyModel.zhongchou.list.count > 1) {
                
                 return (kScreenWidth-25)/2*0.8;
            }
            return 0;
        }
        
    }else if (indexPath.section == 6){
        //热卖
     
        if (self.MyModel.remai.list.count > 0) {
            
            if (indexPath.row == 0) {
                
                return kScreenWidth*0.16;
            }else{
               
                return kScreenWidth *0.24 *( self.MyModel.remai.list.count%2 == 0 ? self.MyModel.remai.list.count/2 : self.MyModel.remai.list.count/2 + 1);
            }
        }
        return 0;
    }else if (indexPath.section == 7){
        //积分
        if (self.MyModel.jifen.list.count > 0) {
            
            return 100;
        }
        return 0;
    }else if (indexPath.section == 8){
        //拍卖
        return 0;
    }else{
        
        if (indexPath.row == 0) {
           
            return 0;
        }else{
            
            //分类-产品列表
            NSInteger num = self.MyModel.goods.count%2 > 0? self.MyModel.goods.count/2 +1 : self.MyModel.goods.count/2;
           
            return ((kScreenWidth-20)/2+115)*num;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    if (self.Current_class == 0) {
        
        return 10;
        return 3 + self.MyModel.activity.count;
    }else{
        
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    /**
     统一分类产品、广告
     */
    if (section == 0) {
    
        if (self.MyModel.class.count > 0) {
            return 2;
        }
        return 0;
    }
    
    /**
      首页和分类从第二段开始不一样
     */
    if (self.Current_class == 0) {
        
        if (section == 1){
            //活动栏目、4个榜单
            if(self.MyModel.activity.count > 0){
                return 2;
            }
            return 0;
        }
        else if (section == 2){
            //自营
            if (self.MyModel.selfSupport.list.count <= 2 &&
                self.MyModel.selfSupport.list.count > 0) {
                return 2;
                
            }else if(self.MyModel.selfSupport.list.count > 2){
                
                return 3;
            }
            return 0;
        }
        else if (section == 3){
            //秒杀
            if (self.MyModel.spike.list.count > 0) {
                return 2;
            }
            return 0;
        }else if (section == 4){
            //团购
            if (self.MyModel.groupBuy.list.count <= 2 &&
                self.MyModel.groupBuy.list.count > 0) {
                return 2;
                
            }else if(self.MyModel.groupBuy.list.count > 2){
                
                return 3;
            }
            return 0;
        }else if (section == 5){
            //众筹
            if (self.MyModel.zhongchou.list.count > 0) {
                return 3;
            }
            return 0;
        }else if (section == 6){
            //热卖
            if (self.MyModel.remai.list.count > 0) {
                
                return 2;
            }
            return 0;
        }else if (section == 7){
            //积分
            if (self.MyModel.jifen.list.count > 0) {
           
                return 2;
            }
            return 0;
        }else if (section == 8){
            //拍卖
            return 0;
        }else{
            //商品列表
            return 2;
        }
    }else{
        
        
        if (section == 1) {
            
            //1、二级分类 2、自定义活动列表
            return 1;
        }else{
        
            //商品列表
            return 1;
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            XZXHome_ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_ClassCellID" forIndexPath:indexPath];
            
            cell.Current_class = self.Current_class;
            cell.dataArray = self.MyModel.class;
            [cell.CustomerCollecell reloadData];
            [cell.CustomerCollecell scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.Current_class inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
          //  cell.delegate = self;
            [cell.MoreClassBtn setImage:[UIImage imageNamed:@"quanbufenlei"] forState:UIControlStateNormal];
            return cell;
        }else{
            XZXHom_CarouselAdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHom_CarouselAdvertisementCellID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell.advArray removeAllObjects];
            for (XZXHome_AdvModel *AdvModel in self.MyModel.navigationImage) {
                
                [cell.advArray addObject:kImageStr(@"",AdvModel.navigationImage)];
            }
            //初始化卡片轮播图
            [cell Carousel];
            return cell;
        }
    }else if (indexPath.section == 1){
        //区分首页与分类
        if (self.Current_class == 0) {
            /**
             首页
             **/
            
            if (indexPath.row == 0) {
                
                //首页对应活动列表
                XZXHome_ActivityClassTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_ActivityClassTCID" forIndexPath:indexPath];
                cell.dataArray = self.MyModel.activity;
                cell.delegate = self;
                [cell.CustomeCollectionView reloadData];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                
                //首页对应活动列表
                XZXHome_Activity2TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity2TCID" forIndexPath:indexPath];
                cell.dataArray = self.MyModel.activity2;
                cell.delegate = self;
                [cell.CustomerCollectionView reloadData];
                return cell;
            }
        }else{
            /**
             分类
             */
            if (indexPath.row == 0) {
                
                //二级分类列表
                XZXHome_SecondClassTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_SecondClassTCID" forIndexPath:indexPath];
                
                if (is_iPhone5 == YES) {
                    
                    cell.Signal_num = 4;
                }else{
                    
                    cell.Signal_num = 5;
                }
                cell.dataSource = [self.MyModel.class objectAtIndex:self.Current_class].goodsClassPc;
                
                cell.CustomerCollView.scrollEnabled = false;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.CustomerCollView reloadData];
                __weak typeof(self) weakSelf = self;
                
                cell.didSelectSecondClassAtIndexPathBlock = ^(NSIndexPath * _Nonnull indexPathBlock) {
                    
                    XZXClass_two_TVC *TVC = kStoryboradController(@"Class", @"XZXClass_two_TVCID");
                    TVC.hidesBottomBarWhenPushed = YES;
                    TVC.title = [[weakSelf.MyModel.class objectAtIndex:weakSelf.Current_class].goodsClassPc objectAtIndex:indexPathBlock.item].gcName;
                    TVC.gcParentId = [NSString stringWithFormat:@"%ld",[[weakSelf.MyModel.class objectAtIndex:weakSelf.Current_class].goodsClassPc objectAtIndex:indexPathBlock.item].gcId];
                    [weakSelf.navigationController pushViewController:TVC animated:YES];
                };
                return cell;
                
            }else{
             
                //一级分类对应活动列表
                XZXHome_Activity2TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity2TCID" forIndexPath:indexPath];
                cell.dataArray = self.MyModel.activity2;
                cell.delegate = self;
                [cell.CustomerCollectionView reloadData];
                return cell;
            }
        }
    }else{
        
        if (self.Current_class == 0) {
            
            //首页
            if (indexPath.row == 0) {
                XZXHome_ActivityHeadTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_ActivityHeadTCID" forIndexPath:indexPath];
                cell.delegate = self;
                [cell ReloadUI:self.MyModel section:indexPath.section];
                return cell;
            }else{
            
                if (indexPath.section == 2){
                    //自营
                    XZXHome_Activity_ZYorTG_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity_ZYorTG_TCID" forIndexPath:indexPath];
                    cell.dataArray = self.MyModel.selfSupport.list;
                    cell.index = indexPath.row;
                    [cell.CustomerCollectionView reloadData];
                    cell.type_str = @"ZY";
                    cell.delegate = self;
                    return cell;
                }
                else if (indexPath.section == 3) {
                    //秒杀
                    XZXHome_Activity_MSTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity_MSTCID" forIndexPath:indexPath];
                    cell.dataArray = self.MyModel.spike.list;
                    [cell.CustomerCollectionView reloadData];
                    cell.delegate = self;
                    return cell;
                    
                }
                else if (indexPath.section == 4){
                    //团购
                    XZXHome_Activity_ZYorTG_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity_ZYorTG_TCID" forIndexPath:indexPath];
                    cell.dataArray = self.MyModel.groupBuy.list;
                    cell.index = indexPath.row;
                    cell.type_str = @"TG";
                    cell.delegate = self;
                    [cell.CustomerCollectionView reloadData];
                    return cell;
                }
                else if (indexPath.section == 5){
                    //众筹
                
                    if (indexPath.row == 1) {
                        
                        XZXHome_Activity_ZCTC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity_ZCTCID" forIndexPath:indexPath];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.MyModel = [self.MyModel.zhongchou.list objectAtIndex:indexPath.row-1];
                        return cell;
                    }else{
                        
                        XZXHome_Activity_ZC2TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHome_Activity_ZC2TCID" forIndexPath:indexPath];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.delegate = self;
                        if (self.MyModel.zhongchou.list.count > 1) {
                            
                            cell.dataArray = (NSMutableArray *)[self.MyModel.zhongchou.list subarrayWithRange:NSMakeRange(1, self.MyModel.zhongchou.list.count-1)];
                            [cell.CustomerCollectionView reloadData];
                        }
                        
                        return cell;
                    }
                 
                    
                }
                else if (indexPath.section == 6){
                    //热卖
                    XZXHomeremai_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXHomeremai_TCID" forIndexPath:indexPath];
                    cell.dataArray = self.MyModel.remai.list;
                    cell.delegate = self;
                    return cell;
                    
                }else if(indexPath.section == 7 ||
                         indexPath.section == 8){
                    
                    
                }else{
                    
                    //首页  商品列表
                    XZXClass_good_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXClass_good_TCID" forIndexPath:indexPath];
                    cell.delegate = self;
                    cell.GoodModel_dataSource = self.MyModel.goods;
                    [cell.CustomerCVC reloadData];
                    return cell;
                }

                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                }
                return cell;
            }
        }else{
            //分类
            
            XZXClass_good_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXClass_good_TCID" forIndexPath:indexPath];
            cell.delegate = self;
            cell.GoodModel_dataSource = self.MyModel.goods;
            [cell.CustomerCVC reloadData];
            return cell;
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 5 && indexPath.row == 1) {
        //选择众筹第一个商品
        
        [self EntergoodDetailVC_ZC:[self.MyModel.zhongchou.list objectAtIndex:0]];
    }
}


-(void)DidselectActivityClass_ZC:(NSInteger)item{
    
    [self EntergoodDetailVC_ZC:[self.MyModel.zhongchou.list objectAtIndex:item+1]];
}

-(void)EntergoodDetailVC_ZC:(XZXHome_goodModel *)model{
    
  
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.VC_type = GoodDetail_ZC;
    TV.goodsId = model.goodsCommonid;
    TV.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:TV animated:YES];
}

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
            TV.VC_type = GoodDetail_ZC;
            TV.goodsId = model.goodsCommonid;
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

#pragma mark 搜索栏

-(void)SearchBarInNavigation{
    
    
    self.searchbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*0.5, self.navigationController.navigationBar.frame.size.height*0.7)];
    self.searchbackView.backgroundColor = [UIColor whiteColor];
    
    self.searchbackView.cornerRadius = self.navigationController.navigationBar.frame.size.height*0.7*0.5;
    self.navigationItem.titleView = self.searchbackView;
    
    self.selectType = [[UIView alloc]initWithFrame:CGRectMake(5, 5, self.searchbackView.frame.size.width/3.0, self.searchbackView.frame.size.height*0.7)];
    [self.searchbackView addSubview:self.selectType];
    self.selectType.backgroundColor = [UIColor colorWithRed:217/255.0 green:11/255.0 blue:23/255.0 alpha:1];
    self.selectType.cornerRadius = self.searchbackView.frame.size.height*0.7*0.5;
    
    
    self.searchtype_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,  self.selectType.frame.size.width/1.5, self.searchbackView.frame.size.height*0.7)];
    [self.selectType addSubview:self.searchtype_label];
    
    self.searchtype_label.backgroundColor = [UIColor clearColor];
    self.searchtype_label.text = self.searchtype_str;
    self.searchtype_label.textColor = [UIColor whiteColor];
    self.searchtype_label.adjustsFontSizeToFitWidth = YES;
    
    
    UIImageView *searchtype_image = [[UIImageView alloc]initWithFrame:CGRectMake(self.selectType.frame.size.width/1.5 ,0, self.selectType.frame.size.width - self.selectType.frame.size.width/1.5, self.searchbackView.frame.size.height*0.7)];
    searchtype_image.image = [UIImage imageNamed:@"jiantou_down"];
    [self.selectType addSubview:searchtype_image];
    
    searchtype_image.contentMode = UIViewContentModeCenter;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_List:)];
    [self.selectType addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_Seartch)];
    [self.searchbackView addGestureRecognizer:tap2];
    
    
    //右-放大镜
    UIImageView *View_Big = [[UIImageView alloc]initWithFrame:CGRectMake(self.searchbackView.frame.size.width - 50, 0, 50, self.searchbackView.frame.size.height)];
    View_Big.image = [UIImage imageNamed:@"fandajin"];
    View_Big.contentMode = UIViewContentModeCenter;
    [self.searchbackView addSubview:View_Big];
}


-(void)tap_List:(UITapGestureRecognizer *)tap{
    
    
    
    NSArray *array = @[@" 商品",@" 店铺"];
    self.menuView = [ZWPullMenuView pullMenuAnchorView:self.searchtype_label titleArray:array];
    
    __weak __typeof(self) weakSelf = self;
    self.menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        
        weakSelf.searchtype_str = array[menuRow];
        weakSelf.searchtype_label.text = weakSelf.searchtype_str;
        if (menuRow == 1) {
            //进入店铺列表
            XZXHome_Class_StoreCVC *VC = kStoryboradController(@"Homepage", @"XZXHome_Class_StoreCVCID");
            VC.hidesBottomBarWhenPushed = YES;
            
            VC.VC_type = Store_List;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
}

-(void)tap_Seartch{
    if ([self.searchtype_str isEqualToString:@" 商品"]) {
        
        XZXSearchResultVC *VC = [[XZXSearchResultVC alloc]initWithNibName:@"XZXSearchResultVC" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        VC.VC_type = SearchGood_GoodList;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        //进入店铺列表
        XZXHome_Class_StoreCVC *VC = kStoryboradController(@"Homepage", @"XZXHome_Class_StoreCVCID");
        VC.hidesBottomBarWhenPushed = YES;
        
        VC.VC_type = Store_List;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}



-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    
    XZXMine_MessageListTVC *TVC = [[XZXMine_MessageListTVC alloc]initWithNibName:@"XZXMine_MessageListTVC" bundle:nil];
    TVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 自定义协议
/**
 切换产品分类
 **/
//轮播图（效果等同女神榜单）
-(void)DidSelectAdvertisementIndex:(NSInteger )index{
    
//    XZXHome_AdvModel *Model = [self.MyModel.navigationImage objectAtIndex:index];
//    
//    XZX_Activity2_TVC *TVC = [XZX_Activity2_TVC new];
//    TVC.activityType = Model.activityType;
//    TVC.title = @"";
//    TVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:TVC animated:YES];
}

-(void)DidselectClass:(NSInteger)item{
    
    self.Current_class = item;
    self.page = 1;
    [self GetInformation];
    
}

#pragma mark 选择更多商品分类
-(void)DidselectMoreClass{
    
    XZXHome_Class_StoreCVC *VC = kStoryboradController(@"Homepage", @"XZXHome_Class_StoreCVCID");
    VC.hidesBottomBarWhenPushed = YES;
    
    VC.VC_type = GoodClass_List;
    VC.dataArray = self.MyModel.class;

    VC.DidSelectClassBlock = ^(NSInteger index) {
        
        self.Current_class = index;
        [self GetInformation];
    };
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark  选择活动-进入商品列表

-(void)DidselectActivityClass:(NSInteger)item{
    
    XZXHome_activityModel * MyModel = [self.MyModel.activity objectAtIndex:item];
    
    
    switch ([MyModel.activityType integerValue]) {
        case ZiYing_t:
        {
            //自营列表
            
            XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
            VC.hidesBottomBarWhenPushed = YES;
            VC.storeId = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case MiaoSha_t:
        {
            XZX_GoodList_MSTV *TV = [XZX_GoodList_MSTV new];
            TV.activityModel = MyModel;
            
            NSString *gcid = [NSString string];
            if (self.MyModel.activity > 0) {
                gcid = ((XZXHome_classModel *)[self.MyModel.class objectAtIndex:self.Current_class]).gcId;
            }
            TV.gcid = gcid;
            TV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TV animated:YES];
        }
            break;
        case ZhongChou_t:
        {
            
            XZX_GoodList_ZCTV *TV = [[XZX_GoodList_ZCTV alloc]initWithNibName:@"XZX_GoodList_ZCTV" bundle:nil];
            TV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TV animated:YES];
            
        }
            break;
        case ReMai_t:
        {
            XZXHome_activityModel *MyModel = [XZXHome_activityModel new];
            for (XZXHome_activityModel *temp in self.MyModel.activity) {
                if ([temp.activityType integerValue] == ReMai_t) {
                    MyModel = temp;
                    break;
                }
            }
            XZX_GoodList_ZYTV *TVC = [[XZX_GoodList_ZYTV alloc]init];
            TVC.ZYTV_t = ZYTV_RM_t;
            TVC.activityModel = MyModel;
            TVC.gcid = @"";
            TVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TVC animated:YES];
            
        }
            break;
        case TuanGou_t:
        {
            
            OtherViewController *VC = kStoryboradController(@"Login", @"OtherViewControllerID");
            VC.hidesBottomBarWhenPushed =  YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case JiFen_t:
        {
            
            XZX_GoodList_JFTV *VC = [[XZX_GoodList_JFTV alloc]initWithNibName:@"XZX_GoodList_JFTV" bundle:nil];
            VC.hidesBottomBarWhenPushed =  YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        default:
        {
            OtherViewController *VC = kStoryboradController(@"Login", @"OtherViewControllerID");
            VC.hidesBottomBarWhenPushed =  YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
    }
}


#pragma mark   选择6个固定活动。  新手推荐
 
-(void)DidselectActivity2:(NSInteger)item{
    
    XZX_Activity2_TVC *TVC = [XZX_Activity2_TVC new];
    TVC.activityType = ((XZXHome_activityModel *)[self.MyModel.activity2 objectAtIndex:item]).activityType;
    TVC.title = ((XZXHome_activityModel *)[self.MyModel.activity2 objectAtIndex:item]).activityName;
    TVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TVC animated:YES];
}

#pragma mark 查看更多
-(void)DidSelectViewMoreActivity:(XZXHome_ActivityHeadTC *)cell{
    
    NSIndexPath *indexPath = [self.CustomerTableViewCell indexPathForCell:cell];
    XZXHome_activityModel * MyModel = [XZXHome_activityModel new];
    
    switch (indexPath.section) {
        case 3:
        {
            //秒杀
            for (XZXHome_activityModel *temp in self.MyModel.activity) {
                if ([temp.activityType integerValue] == 20) {
                    MyModel = temp;
                    break;
                }
            }
            XZX_GoodList_MSTV *TV = [XZX_GoodList_MSTV new];
            TV.activityModel = MyModel;
            
            NSString *gcid = [NSString string];
            if (self.MyModel.activity > 0) {
                gcid = ((XZXHome_classModel *)[self.MyModel.class objectAtIndex:self.Current_class]).gcId;
            }
            TV.gcid = gcid;
            TV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TV animated:YES];
        }
            break;
        case 4:
        {
            //团购
            for (XZXHome_activityModel *temp in self.MyModel.activity) {
                if ([temp.activityType integerValue] == 50) {
                    MyModel = temp;
                    break;
                }
            }
            XZX_GoodList_ZYTV *TVC = [[XZX_GoodList_ZYTV alloc]init];
            
            TVC.ZYTV_t = ZYTV_TG_t;
            
            TVC.activityModel = MyModel;
            
            NSString *gcid = [NSString string];
            if (self.MyModel.activity > 0) {
                gcid = ((XZXHome_classModel *)[self.MyModel.class objectAtIndex:self.Current_class]).gcId;
            }
            TVC.gcid = gcid;
            TVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TVC animated:YES];
            
        }
            break;
        case 2:
        {
            //自营
            for (XZXHome_activityModel *temp in self.MyModel.activity) {
                if ([temp.activityType integerValue] == 10) {
                    MyModel = temp;
                    break;
                }
            }
            XZX_GoodList_ZYTV *TVC = [[XZX_GoodList_ZYTV alloc]init];
            TVC.ZYTV_t = ZYTV_ZY_t;
            TVC.activityModel = MyModel;
            
            NSString *gcid = [NSString string];
            if (self.MyModel.activity > 0) {
                gcid = ((XZXHome_classModel *)[self.MyModel.class objectAtIndex:self.Current_class]).gcId;
            }
            TVC.gcid = gcid;
            TVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TVC animated:YES];
        }
            break;
        case 5:
        {
            XZX_GoodList_ZCTV *TV = [[XZX_GoodList_ZCTV alloc]initWithNibName:@"XZX_GoodList_ZCTV" bundle:nil];
            TV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TV animated:YES];
        }
            break;
        case 6:
        {
            
            for (XZXHome_activityModel *temp in self.MyModel.activity) {
                if ([temp.activityType integerValue] == ReMai_t) {
                    MyModel = temp;
                    break;
                }
            }
            XZX_GoodList_ZYTV *TVC = [[XZX_GoodList_ZYTV alloc]init];
            TVC.ZYTV_t = ZYTV_RM_t;
            TVC.activityModel = MyModel;
            TVC.gcid = @"";
            TVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}


#pragma mark 进入商品详情

//秒杀
-(void)DidselectActivityClass_MS:(NSInteger )item{
    
    XZXHome_goodModel * MyModel = [self.MyModel.spike.list objectAtIndex:item];
    
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = MyModel.goodsId;
    TV.VC_type = GoodDetail_MS;
    TV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TV animated:YES];
}

//团购、自营
-(void)DidselectActivityClass_TG_ZY:(NSInteger)item type:(NSString *)type_str{
    
    if ([type_str isEqualToString:@"TG"]) {
        XZXHome_goodModel * MyModel = [self.MyModel.groupBuy.list objectAtIndex:item];
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = MyModel.goodsId;
        TV.VC_type = GoodDetail_TG;
        TV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:TV animated:YES];
    }else{
        XZXHome_goodModel * MyModel = [self.MyModel.selfSupport.list objectAtIndex:item];
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = MyModel.goodsId;
        TV.VC_type = GoodDetail_ZY;
        TV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:TV animated:YES];
    }
}

//热卖
-(void)DidSelect_XZXHomeremai_TC:(NSString *)goodsId{
    
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = goodsId;
    TV.VC_type = GoodDetail_RM;
    TV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TV animated:YES];
}




@end
