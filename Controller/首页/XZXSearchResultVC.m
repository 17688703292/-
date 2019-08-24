//
//  XZXSearchResultVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXSearchResultVC.h"

#import "XZXClass_good_CC.h"
#import "XZXSearchNoDataCell.h"
#import "XZXSearchHeadView.h"
#import "XZXShopGoodSelectWeight2.h"


#import "XZXClass_two_good_Model.h"

#import "XZX_GoodDetail_CommonTV.h"

#import "DataBase_SearchResult.h"

@interface XZXSearchResultVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCVC;
@property (nonatomic,strong)dispatch_queue_t Queue;//
@property (nonatomic,strong)NSMutableArray *GoodModel_dataSource;//搜索到的结果
@property (nonatomic,strong)NSMutableArray *Search_History;//搜索过的历史
@property (nonatomic,strong)NSMutableArray *Search_hot;//搜索热门
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,copy) NSString *SearchStr;

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)NSInteger total;

@end

@implementation XZXSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      _Queue = dispatch_queue_create("Queue_XZXSearchResultVC", DISPATCH_QUEUE_SERIAL);
    self.view.backgroundColor = [UIColor whiteColor];

    self.searchBar = [[UISearchBar alloc]initWithFrame:self.navigationController.navigationBar.bounds];
    self.searchBar.barStyle = UIBarStyleBlackTranslucent;
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;

    
    UITextField *textfield = [[[self.searchBar.subviews firstObject] subviews] lastObject];
    textfield.backgroundColor =[UIColor whiteColor];
    self.navigationItem.titleView = self.searchBar;
    textfield.clearButtonMode =  UITextFieldViewModeAlways;
    
    
    [self AddReturnTopBtnIconImageName:@"zhiding" frame:CGRectMake(kScreenWidth*0.8, kScreenHeight*0.8, 50, 50) blcok:^{
        
        
    }];
    
    __weak typeof(self) weakSelf = self;
    self.Begain = ^{

        if (self.GoodModel_dataSource.count > 0) {
            
            [weakSelf.CustomerCVC scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        }
        
        
    };


    self.CustomerCVC.dataSource = self;
    self.CustomerCVC.delegate   = self;
    self.CustomerCVC.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.CustomerCVC.collectionViewLayout = layout;
    [self.CustomerCVC registerNib:[UINib nibWithNibName:@"XZXClass_good_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXClass_good_CCID"];
    [self.CustomerCVC registerNib:[UINib nibWithNibName:@"XZXSearchNoDataCell" bundle:nil] forCellWithReuseIdentifier:@"XZXSearchNoDataCellID"];
    [self.CustomerCVC registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectWeight2" bundle:nil] forCellWithReuseIdentifier:@"XZXShopGoodSelectWeight2ID"];
    [self.CustomerCVC registerClass:[XZXSearchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XZXSearchHeadViewID"];
    [self SetManualRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.ReturnTopBtn.hidden = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.ReturnTopBtn.hidden = true;
}

-(NSString *)sortId{
    if (!_sortId) {
        _sortId = [NSString string];
    }
    
    return _sortId;
}

-(void)SetManualRefresh{
    
    [self.view endEditing:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.CustomerCVC.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (    [self.SearchStr length] != 0) {
                self.page = 1;
                [self GetInformation];
            }else{
                
                [self.CustomerCVC.mj_header endRefreshing];
            }
        }];
       // [self.CustomerCVC.mj_header beginRefreshing];
        
        
        self.CustomerCVC.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
            
                if (self.total > self.GoodModel_dataSource.count) {
                    
                    
                    if (    [self.SearchStr length] != 0) {
                       
                        self.page = self.GoodModel_dataSource.count/10 +1;
                        [self GetInformation];
                    }else{
                        
                        [self.CustomerCVC.mj_footer endRefreshing];
                    }
                }else{
                    
                    [self.CustomerCVC.mj_footer endRefreshingWithNoMoreData];
                    [MBProgressHUD xh_showHudWithMessage:@"这是我最后的底线，别拉啦" toView:self.view completion:^{
                        
                    }];
                }
            
        }];
    });
}



-(void)GetInformation{
    
    [self.searchBar resignFirstResponder];
    
    
    [XHNetworking xh_postWithoutSuccess:@"homePage/search" parameters:@{@"keyWord":self.SearchStr,@"page":@(self.page),@"startPrice":@"0",@"endPrice":@"",@"storeId":self.sortId} success:^(XHResponse *responseObject) {
        
        [self.CustomerCVC.mj_header endRefreshing];
        [self.CustomerCVC.mj_footer endRefreshing];
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            if (self.page == 1) {
                
                self.total = [[responseObject.data valueForKey:@"count"] integerValue];
                [self.GoodModel_dataSource removeAllObjects];

            }
            
            if ([[responseObject.data valueForKey:@"list"] count] == 0) {
                
                [MBProgressHUD xh_showHudWithMessage:@"没有搜索到对应产品" toView:self.view completion:^{
                    
                }];
                return ;
            }
            for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
                
                [self.GoodModel_dataSource addObject:[XZXClass_two_good_Model yy_modelWithJSON:dic]];
            }
            if (self.GoodModel_dataSource.count != 0) {
                
                [[DataBase_SearchResult shareDataBase] InsertIntoTableName:@"Result" Result:self.SearchStr];
            }
            
            [self.CustomerCVC reloadData];
        }
    }];
}

- (NSMutableArray *)GoodModel_dataSource{
    if (!_GoodModel_dataSource) {
        _GoodModel_dataSource = [NSMutableArray array];
        
    }
    return _GoodModel_dataSource;
}
- (NSMutableArray *)Search_hot{
    
    
    if (!_Search_hot) {
        _Search_hot = [NSMutableArray arrayWithObjects:@"风扇",@"大米",@"油",@"夏装",@"牙膏",@"买一送一",@"零食",@"牛肉",@"水果", nil];
    }
    return _Search_hot;
}

- (NSMutableArray *)Search_History{
    
    if (!_Search_History) {
        _Search_History = [NSMutableArray arrayWithArray:[[DataBase_SearchResult shareDataBase]GetAllResutl:@"Result" Result:@""]];
    }
    return _Search_History;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (self.GoodModel_dataSource.count == 0) {
        return CGSizeMake(kScreenWidth, 50);

    }
    return CGSizeMake(kScreenWidth, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       
        XZXSearchHeadView *header = (XZXSearchHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XZXSearchHeadViewID" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            
            header.titleLab.text = @"  热门搜索";
            header.operationBtn.hidden = YES;
            
        }else if(indexPath.section == 1){
            header.titleLab.text = @"  历史搜索";
            header.operationBtn.hidden = false;
            
            header.OperationBlcok = ^{
                
               
                    [[DataBase_SearchResult shareDataBase] DelectIntoTableName:@"Result"];
                    [self.Search_History removeAllObjects];
                    
                    [self.CustomerCVC reloadData];
                
            };
        }
        return header;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (self.GoodModel_dataSource.count == 0) {
        
        return 2;
    }
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.GoodModel_dataSource.count == 0) {
        
        if (section == 0) {
            
            return self.Search_hot.count;
        }else{
            
            return self.Search_History.count;
        }
    }
    return self.GoodModel_dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
    if (self.GoodModel_dataSource.count == 0) {
     
        XZXShopGoodSelectWeight2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXShopGoodSelectWeight2ID" forIndexPath:indexPath];
        if (indexPath.section == 0) {
        
            cell.WeightName.text = [self.Search_hot objectAtIndex:indexPath.item];
             cell.WeightName.backgroundColor = kThemeColor;
        }else{
            
            cell.WeightName.text = [self.Search_History objectAtIndex:indexPath.item];
            cell.WeightName.backgroundColor = [UIColor darkGrayColor];
        }
        
       

        return cell;
    }else{
        
     
        XZXClass_good_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXClass_good_CCID" forIndexPath:indexPath];
        cell.Model = self.GoodModel_dataSource[indexPath.row];
        
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.GoodModel_dataSource.count == 0) {
        NSString *name = [NSString string];
        if (indexPath.section == 0) {

            name = [self.Search_hot objectAtIndex:indexPath.item];
        }else{
            
            name = [self.Search_History objectAtIndex:indexPath.item];
        }
        
        CGFloat width = [name xh_widthWithFont:[UIFont systemFontOfSize:15.0] constrainedToHeight:30];
        return CGSizeMake(width + 30, 40);
       
    }else{
    
       return CGSizeMake((kScreenWidth-30)/2, (kScreenWidth-20)/2+105);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.GoodModel_dataSource.count == 0) {
        
        if (indexPath.section == 0) {
            
            self.SearchStr = [self.Search_hot objectAtIndex:indexPath.item];
            
        }else{
            
            self.SearchStr = [self.Search_History objectAtIndex:indexPath.item];
        }
        self.searchBar.text = self.SearchStr;
         self.page = 1;
        [self GetInformation];
    }else{
        
     
        XZXClass_two_good_Model *Model = [self.GoodModel_dataSource objectAtIndex:indexPath.item];
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
        switch ([Model.goodsPromotionType integerValue]) {
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
        
        
        [self.navigationController pushViewController:TV animated:YES];
    }
}

#pragma mark 搜索
//当搜索的词语得到结果时再保存
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    dispatch_async(self.Queue, ^{
        
        @synchronized (self) {
            
            self.SearchStr = searchText;
    
        }
    });
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (    [self.SearchStr length] != 0) {
     self.page = 1;
        [self GetInformation];
    }
    
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    if (    [self.SearchStr length] != 0) {
        self.page = 1;
        [self GetInformation];
    }
}
@end
