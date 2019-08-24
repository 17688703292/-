//
//  XZXHome_Activity_MSTC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_MSTC.h"
#import "XZXHome_Activity_MS_CC.h"
#import "XZXHome_goodModel.h"

@implementation XZXHome_Activity_MSTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //self.CustomerCollectionView.collectionViewLayout = layout;
    self.CustomerCollectionView.bounces = false;
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHome_Activity_MS_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_Activity_MS_CCID"];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((kScreenWidth-30)/3,kScreenWidth/3 + 50);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count > 6 ? 6 : self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXHome_Activity_MS_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_Activity_MS_CCID" forIndexPath:indexPath];
    XZXHome_goodModel *model = self.dataArray[indexPath.item];
    cell.MyModel = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectActivityClass_MS:)]) {
        
        [self.delegate DidselectActivityClass_MS:indexPath.item];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

@end
