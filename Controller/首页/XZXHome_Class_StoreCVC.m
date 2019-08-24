//
//  XZXHome_Class_StoreCVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Class_StoreCVC.h"
#import "XZXStoreVC.h"

#import "XZXClass_CC.h"

#import "XZXHome_classModel.h"

@interface XZXHome_Class_StoreCVC()<UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,copy) NSString *SearchStr;
@property (nonatomic,strong)dispatch_queue_t Queue;//

@end
@implementation XZXHome_StoreModel


@end

@implementation XZXHome_Class_StoreCVC

-(void)viewDidLoad{
    [super viewDidLoad];
    if (self.VC_type == GoodClass_List) {
      
        self.title = @"商品分类";
        dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
           
            NSDictionary *dic = @{
                                  @"1":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789D53CB0FBD0E8450599039375F933D13F.jpg",
                                  @"2":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/12134567898FF540C532F94784899D55CC2F1CA37B.jpg",
                                  @"3":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/12134567890025F0329E2241E2B51A1FBE4401603C.jpg",
                                  @"256":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789E28D6BFFCCBC41CF86A7C2BA714E10C1.jpg",
                                  @"308":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789C47606D9983644FB872B7F493569456B.jpg",
                                  @"470":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789BC8074A536AF4F079D2E8B921045658E.jpg",
                                  @"530":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789C8D3D4DB486C47BBB1D5CF43CBD475A6.jpg",
                                  @"593":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789DE79F7AAA3FA44A5987A23F4915F9CDB.jpg",
                                  @"662":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789B6740B263A99476C9C075CA71D01B54E.jpg",
                                  @"730":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/121345678972F00EE999574011B81C030B2830C9B6.jpg",
                                  @"825":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789B1F3BEC4D7024203B79C8C05AF1F727B.jpg",
                                  @"888":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789DC8858398BE0409B936A09A94F87DF72.jpg",
                                  @"959":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/12134567895BB002D17A4E456089F8E6F25C3A817F.jpg",
                                  @"1037":@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789ABDD8C2CFFD74102B489C01FFB739A0D.jpg"
                                  };
            
            for (XZXHome_classModel *Model in self.dataArray) {
                
                if ([[dic allKeys] containsObject:Model.gcId]) {
                    
                    Model.gcThumb = [dic valueForKey:Model.gcId];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.collectionView reloadData];
            });
        });
    }else if (self.VC_type == Store_List){
        
        
        _Queue = dispatch_queue_create("XZXHome_Class_StoreCVC", DISPATCH_QUEUE_SERIAL);
        self.SearchStr = [NSString string];

        self.searchBar = [[UISearchBar alloc]initWithFrame:self.navigationController.navigationBar.bounds];
        self.searchBar.barStyle = UIBarStyleBlackTranslucent;
        self.searchBar.searchBarStyle = UISearchBarStyleDefault;
        self.searchBar.placeholder = @"搜索";
        self.searchBar.delegate = self;
        UITextField *textfield = [[[self.searchBar.subviews firstObject] subviews] lastObject];
        textfield.backgroundColor =[UIColor whiteColor];
        self.navigationItem.titleView = self.searchBar;
        
        self.title = @"店铺";
        [self SetManualRefresh];
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZXClass_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXClass_CCID"];
}

-(void)SetManualRefresh{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            //先判断数据库是否有第一页的数据，取出来做临时显示。
            [self GetInformation];
        }];
        
        [self.collectionView.mj_header beginRefreshing];
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^ {
            

            if (self.total > self.dataArray.count) {
                self.page = self.dataArray.count/10+1;
                [self GetInformation];
            }else{
                
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
    });
}

-(void)GetInformation{
    
    
    [self.searchBar resignFirstResponder];
   
    [XHNetworking xh_postWithoutSuccess:@"homePage/getStoreS" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"page":@(self.page),@"StoreName":self.SearchStr} success:^(XHResponse *responseObject) {
        
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        
        if (self.page == 1) {
            
            self.total = [[responseObject.data valueForKey:@"count"] integerValue];
            [self.dataArray removeAllObjects];
            
        }
        
        if ([[responseObject.data valueForKey:@"list"] count] == 0) {
            
            [MBProgressHUD xh_showHudWithMessage:@"没有搜索到对应产品" toView:self.view completion:^{
                
            }];
            return ;
        }
        
        
        self.total = [[responseObject.data valueForKey:@"count"] integerValue];
        for (NSDictionary *dic in [responseObject.data valueForKey:@"list"]) {
            [self.dataArray addObject:[XZXHome_StoreModel yy_modelWithJSON:dic]];
        }
        [self.collectionView reloadData];

    }];
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger num = is_iPhone5 == YES ? 3 : 4;
    return CGSizeMake(kScreenWidth/num, kScreenWidth/num+20);
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    XZXClass_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXClass_CCID" forIndexPath:indexPath];
    if (self.VC_type == GoodClass_List) {
     
        XZXHome_classModel *Model = [self.dataArray objectAtIndex:indexPath.row];
        [cell.GoodImage sd_setImageWithURL:kImageUrl(@"",Model.gcThumb) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.name.text = Model.gcName;
    }else{
        
        XZXHome_StoreModel *Model = [self.dataArray objectAtIndex:indexPath.row];
        [cell.GoodImage sd_setImageWithURL:kImageUrl(Model.storeId,Model.storeAvatar) placeholderImage:[UIImage imageNamed:@"dianpu_shoucang"]];
        cell.name.text = Model.storeName;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.VC_type == GoodClass_List) {
     
        if (self.DidSelectClassBlock) {
            
            [self.navigationController popViewControllerAnimated:YES];
            self.DidSelectClassBlock(indexPath.item);
            
        }
        
    }else{
        XZXHome_StoreModel *model = [self.dataArray objectAtIndex:indexPath.row];
        XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
        VC.hidesBottomBarWhenPushed = YES;
        VC.storeId = model.storeId;
        [self.navigationController pushViewController:VC animated:YES];
     
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
