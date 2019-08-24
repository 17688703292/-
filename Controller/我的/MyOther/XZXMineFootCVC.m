//
//  XZXMineFootCVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/24.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineFootCVC.h"

#import "XZX_GoodDetail_CommonTV.h"
#import "XZXMineFootHeadView.h"
#import "XZXMineFootHeadView2.h"
#import "XZXMineFootCC.h"
#import "XZXMineFoot2CC.h"

@interface XZXMineFootCVC ()<UICollectionViewDelegateFlowLayout,XZXMineFootCCDelegate>

@property (nonatomic,strong)UILabel *Sectiontitle;
@end

@implementation XZXMineFootBaseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goods": [XZXMineFootModel class]};
}

@end

@implementation XZXMineFootModel


@end



@implementation XZXMineAgentListBaseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goods": [XZXMineAgent_GoodListBaseModel class]};
}

@end

@implementation XZXMineAgent_GoodListBaseModel


@end

@implementation XZXMineFootCVC




static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;

    if (self.VC_type == VC_foot) {
     
        [self.collectionView registerNib:[UINib nibWithNibName:@"XZXMineFootCC" bundle:nil] forCellWithReuseIdentifier:@"XZXMineFootCCID"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"XZXMineFootHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XZXMineFootHeadViewID"];
        self.title = @"我的足迹";
    }else{
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"XZXMineFoot2CC" bundle:nil] forCellWithReuseIdentifier:@"XZXMineFootCC2ID"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"XZXMineFootHeadView2" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XZXMineFootHeadView2ID"];
        self.title = @"查看产品";
    }
    self.collectionView.backgroundColor = kBackgroundColor;
    // Do any additional setup after loading the view.
    [self SetManualRefresh];
    
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
                  ++self.page;
                //self.page = self.dataArray.count/3+1;
                [self GetInformation];
            }else{
                
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
    });
}

-(void)GetInformation{
    
    NSString *url = [NSString string];
    NSDictionary *dic = [NSDictionary dictionary];
    if(self.VC_type == VC_foot){
        
        url = @"goodsBrowse/myPopularity";
        dic = @{@"memberId":@(kUser.member_id),@"userId":@(kUser.member_id),@"token":kUser.token};
    }else{
        
        url = @"agent/getMyPacketGoods";
        dic = @{@"memberId":@(kUser.member_id),@"userId":@(kUser.member_id),@"token":kUser.token,@"agId":@(self.agId),@"page":@(self.page)};
    }
    
    [XHNetworking xh_postWithoutSuccess:url parameters:dic success:^(XHResponse *responseObject) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        if (self.VC_type == VC_foot) {
         //足迹
            if (responseObject.code == 200 &&
                [responseObject.data isKindOfClass:[NSArray class]]) {
                
                
                for (NSDictionary *dic in responseObject.data) {
                    
                    [self.dataArray addObject:[XZXMineFootBaseModel yy_modelWithJSON:dic]];
                }
                
                [self.collectionView reloadData];
            }
        }else{
            //代理
            if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
              
                if (self.page == 1) {
                    
                    
                    [self.dataArray removeAllObjects];
                    if ([[responseObject.data allKeys] containsObject:@"count"]) {
                        
                        self.total =  [[responseObject.data valueForKey:@"count"] integerValue];
                    }
                    
                }
                
                for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {
                    
                    [self.dataArray addObject:[XZXMineAgentListBaseModel yy_modelWithJSON:dic]];
                }
                
                if (self.dataArray.count == 0) {
                    
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.collectionView reloadData];
            }
        }
    }];
}
#pragma mark <UICollectionViewDataSource>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 50);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{


    if (self.VC_type == VC_foot) {
           XZXMineFootHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XZXMineFootHeadViewID" forIndexPath:indexPath];
        XZXMineFootBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
        headerView.Section_title.text = baseModel.time;
        return headerView;
    }else{
        
        XZXMineAgentListBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
           XZXMineFootHeadView2 *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XZXMineFootHeadView2ID" forIndexPath:indexPath];
        headerView.title.text = [NSString stringWithFormat:@"%@  %@",baseModel.acCode,baseModel.acDescription];
        
        
        headerView.detailtitle.text = [NSString stringWithFormat:@"份数：%ld 份",baseModel.count];
     
              return headerView;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    if (self.VC_type == VC_foot) {
    
        return ((XZXMineFootBaseModel *)[self.dataArray objectAtIndex:section]).goods.count;
    }else{
        
        return ((XZXMineAgentListBaseModel *)[self.dataArray objectAtIndex:section]).goods.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.VC_type == VC_foot) {
     

        XZXMineFootCC *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"XZXMineFootCCID" forIndexPath:indexPath];
        XZXMineFootBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
        XZXMineFootModel *Model = [baseModel.goods objectAtIndex:indexPath.item];
        [cell.headImage sd_setImageWithURL:kImageUrl(Model.storeId, Model.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        
        if ([Model.goodsPromotionType integerValue] == ZhongChou_t) {
            
            
                    cell.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:Model.goodsPrice]]] colorArray:@[kThemeColor] fontArray:@[@"17.0"]];
        }else if ([Model.goodsPromotionType integerValue] == JiFen_t){
            
            
             cell.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"积分：%@ + ",[Model.score isKindOfClass:[NSString class]] ? Model.score : @"0"],[NSString stringWithFormat:@"\n¥ %@",[NSString reviseString:Model.goodsPromotionPrice]]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"17.0",@"14.0"]];
        }else{
            
         
                    cell.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:Model.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",[Model.score isKindOfClass:[NSString class]] ? Model.score : @"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"17.0",@"14.0"]];
        }
         cell.delegate = self;
         return cell;
    }else{
       
        XZXMineFoot2CC *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"XZXMineFootCC2ID" forIndexPath:indexPath];
        XZXMineAgentListBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
        XZXMineAgent_GoodListBaseModel *Model = [baseModel.goods objectAtIndex:indexPath.item];
        [cell.headImage sd_setImageWithURL:kImageUrl(Model.storeId, Model.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.contrn.text = Model.goodsName;
        cell.price.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:Model.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",[Model.score isKindOfClass:[NSString class]] ? Model.score : @"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"15.0",@"12.0"]];
        return cell;
     
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.VC_type == VC_foot) {
    
        
        XZXMineFootBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
        XZXMineFootModel *Model = [baseModel.goods objectAtIndex:indexPath.item];
        
        
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        
            TV.goodsId = Model.goodsId;
   
        
        if ([Model.goodsPromotionType integerValue] == MiaoSha_t) {
            
            TV.VC_type = GoodDetail_MS;
        }else if ([Model.goodsPromotionType integerValue] == TuanGou_t){
            
            TV.VC_type = GoodDetail_TG;
        }
        else if ([Model.goodsPromotionType integerValue] == ZhongChou_t){
            
            TV.VC_type = GoodDetail_ZC;
        }else if ([Model.goodsPromotionType integerValue] == ReMai_t){
            
            TV.VC_type = GoodDetail_CommonTV;
        }else if ([Model.goodsPromotionType integerValue] == JiFen_t){
            
            TV.VC_type = GoodDetail_JF;
            TV.VC_type = GoodDetail_JF;
            TV.JF_type = [Model.goodsPromotionPrice floatValue] ==0 ? 3 : 4;
        }
        else if ([Model.goodsPromotionType integerValue] == ZiYing_t || [Model.storeId integerValue] == 1 || Model.isOwnShop == 1){
           
            TV.VC_type = GoodDetail_ZY;
        }
        
        [self.navigationController pushViewController:TV animated:YES];
    }else{
     
        XZXMineAgentListBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
        XZXMineAgent_GoodListBaseModel *Model = [baseModel.goods objectAtIndex:indexPath.item];
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
        TV.VC_type = GoodDetail_Agent;
        [self.navigationController pushViewController:TV animated:YES];
        
    }
    return;
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    NSInteger num = is_iPhone5 ? 2 : 3;
    return CGSizeMake(kScreenWidth/num, kScreenWidth/num + 60);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark 收藏
-(void)MoreAction:(XZXMineFootCC *)cell{
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    __weak typeof(self) weakSelf = self;
    XZXMineFootBaseModel *baseModel = [self.dataArray objectAtIndex:indexPath.section];
    XZXMineFootModel *Model = [baseModel.goods objectAtIndex:indexPath.item];
    ZYShareItem *item0 = [ZYShareItem itemWithTitle:@""
                                               icon:@""
                                            handler:^{ [weakSelf itemAction:nil]; }];
    ZYShareItem *item1 = [ZYShareItem itemWithTitle:@""
                                               icon:@""
                                            handler:^{ [weakSelf itemAction:nil]; }];
    ZYShareItem *item2 = [ZYShareItem itemWithTitle:@"收藏"
                                               icon:@"zuji_shoucang"
                                            handler:^{ [weakSelf itemAction:Model]; }];
    
    // 创建shareView
    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:@[item0,item1,item2]
                                                    functionItems:@[]];
    // 弹出shareView
    shareView.titleLabel.text = @"";
    [shareView show];
}



- (void)itemAction:(XZXMineFootModel *)Model
{
    
    if ([Model isKindOfClass:[XZXMineFootModel class]]) {
      
        [XHNetworking xh_postWithoutSuccess:@"favorites/insertFavorites" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id),@"favType":@"goods",@"favId":Model.goodsId} success:^(XHResponse *responseObject) {
            
            [MBProgressHUD xh_showHudWithMessage:@"成功收藏" toView:self.view completion:^{
                
            }];
        }];
    }
}


@end
