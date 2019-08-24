//
//  XZXMyAgentGoodListCVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyAgentGoodListCVC.h"
#import "XZX_GoodDetail_CommonTV.h"


#import "XZXMyAgentGoodListCCCollectionViewCell.h"

#import "XZXMyAgentGoodListModel.h"

@interface XZXMyAgentGoodListCVC ()<UICollectionViewDelegateFlowLayout,XZXMyAgentGoodListCCCollectionViewCellDelegate>

@end

@implementation XZXMyAgentGoodListCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZXMyAgentGoodListCCCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XZXMyAgentGoodListCCCollectionViewCellID"];
    self.title = @"成为代理大礼包";
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
                     self.page = self.dataArray.count/10 +1;
                    [self GetInformation];
                }else{
                    
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
        }];
    });
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"agent/getAgentPacket" parameters:@{@"page":@(self.page),@"userId":@(kUser.member_id),@"token":kUser.token} success:^(XHResponse *responseObject) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        
        if (responseObject.code == 200 &&
            [responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            
            if (self.page == 1) {

                    
                    [self.dataArray removeAllObjects];
                    if ([[responseObject.data allKeys] containsObject:@"count"]) {
                        
                        self.total =  [[responseObject.data valueForKey:@"count"] integerValue];
                    }
                
            }
            
            for (NSDictionary *dic in [responseObject.data valueForKey:@"goods"]) {

                    [self.dataArray addObject:[XZXMyAgentGoodListModel yy_modelWithJSON:dic]];
            }
            
            [self.collectionView reloadData];
        }
    }];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    
    XZXMyAgentGoodListCCCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"XZXMyAgentGoodListCCCollectionViewCellID" forIndexPath:indexPath];
    cell.MyModel = (XZXMyAgentGoodListModel *)[self.dataArray objectAtIndex:indexPath.item];
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XZXMyAgentGoodListModel * Model= [self.dataArray objectAtIndex:indexPath.item];
    XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
    TV.goodsId = Model.goodsId;
    TV.VC_type = GoodDetail_Agent;
    [self.navigationController pushViewController:TV animated:YES];
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((kScreenWidth-20)/2.0, (kScreenWidth-20)/2.0 + 50);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(void)DidselectMoreBtn:(XZXMyAgentGoodListCCCollectionViewCell *)cell{
    
    NSIndexPath *IndexPath = [self.collectionView indexPathForCell:cell];
    
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
