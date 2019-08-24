//
//  XZXPayResultVC.m
//  DoorLock
//
//  Created by RedSky on 2019/4/1.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXPayResultVC.h"
#import "XZX_GoodDetail_CommonTV.h"
#import "XZXMyCollectionVC.h"
#import "XZXMyAgentGoodListCVC.h"
#import "XZXShopCarListVC.h"
#import "XZXMineFootCVC.h"
#import "XZXMineTVC.h"

#import "XZXHomepageTVC.h"
#import "XZXClassVC.h"
#import "XZXShopCarListVC.h"
#import "XZXMineOrderVC.h"
#import "XZXOrderDetailVC.h"
#import "XZXClass_good_CC.h"
#import "XZXPayResultHeadCC.h"

#import "XZXClass_two_Model.h"

@interface XZXPayResultVC ()<UICollectionViewDataSource,UICollectionViewDelegate,XZXPayResultHeadDelegate>



@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCVC;
@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation XZXPayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"交易成功";

    
    
    self.CustomerCVC.dataSource = self;
    self.CustomerCVC.delegate   = self;
    
  
    [self.CustomerCVC registerNib:[UINib nibWithNibName:@"XZXPayResultHeadCC" bundle:nil] forCellWithReuseIdentifier:@"XZXPayResultHeadCCID"];
    [self.CustomerCVC registerNib:[UINib nibWithNibName:@"XZXClass_good_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXClass_good_CCID"];
    
     [self GetInformation];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:pan];
    
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableDictionary *)order_data{
 
    if (!_order_data) {
        _order_data = [NSMutableDictionary dictionary];
    }
    return _order_data;
}


-(void)GetInformation{
  
    [XHNetworking xh_postWithoutSuccess:@"goodsClassNav/getGoodsListByGcId" parameters:@{@"token":kUser.token,@"gcId":[self.order_data valueForKey:@"gcId"],@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        [self.dataArray removeAllObjects];
        
        for (NSDictionary *dic in responseObject.data) {
            
            //推荐6个商品
            if (self.dataArray.count > 6) {
                break;
            }
            [self.dataArray addObject:[XZXClass_two_good_Model yy_modelWithJSON:dic]];
        }
        
        
        [self.CustomerCVC reloadData];
    }];

}



-(void)panView:(UIPanGestureRecognizer *)panGesture{
    
    
    CGPoint Point = [panGesture locationInView:self.view];
    
    if ([panGesture isKindOfClass:[UIPanGestureRecognizer class]]) {
    
        NSLog(@"x==%f,y==%f",Point.x,Point.y);
        
    }
    
}


-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    [self Back];
    
}


-(void)ViewOrder_delegate{
    
    XZXMineOrderVC *TVC = [XZXMineOrderVC new];
    TVC.selectIndex = 2;
    TVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:TVC animated:YES];
}

-(void)Back_delegate{

    [self Back];
}

-(void)Back{
    
    
    for (UIViewController *VC in self.navigationController.viewControllers) {

        if ([VC isKindOfClass:[XZXHomepageTVC class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXClassVC class]]){
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXShopCarListVC class]]){
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXMineOrderVC class]]){
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXMyCollectionVC class]]){
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXMyAgentGoodListCVC class]]){
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXShopCarListVC class]]){
            [self.navigationController popToViewController:VC animated:YES];
        }else if ([VC isKindOfClass:[XZXMineFootCVC class]]){
             [self.navigationController popToViewController:VC animated:YES];
        }else if([VC isKindOfClass:[XZXMineTVC class]]){

            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
    
        return self.dataArray.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
       
        XZXPayResultHeadCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXPayResultHeadCCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.orderContent_lab.attributedText = [NSString changestringArray:@[@"订单支付成功\n\n",[NSString stringWithFormat:@"%@元\n\n",self.allMoney],@"我们将尽快为您安排发货,请保持手机畅通"] colorArray:@[[UIColor blackColor],[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"21.0",@"27.0",@"15.0"]];
        return cell;
    }else{
        
        XZXClass_good_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXClass_good_CCID" forIndexPath:indexPath];
        cell.Model = self.dataArray[indexPath.row];
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
       
        return CGSizeMake(kScreenWidth, 20+kScreenWidth*0.7*0.5+180+40+30);
    }else{
    
        return CGSizeMake((kScreenWidth-20)/2, (kScreenWidth-20)/2+75);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section > 0) {
       
        XZXClass_two_good_Model *Model = [self.dataArray objectAtIndex:indexPath.item];
        XZX_GoodDetail_CommonTV *TV = kStoryboradController(@"Homepage", @"XZX_GoodDetail_CommonTVID");
        TV.goodsId = Model.goodsId;
        TV.VC_type = GoodDetail_CommonTV;
        [self.navigationController pushViewController:TV animated:YES];
    }
}


@end
