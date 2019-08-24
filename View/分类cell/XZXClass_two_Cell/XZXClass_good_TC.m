//
//  XZXClass_good_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXClass_good_TC.h"
#import "XZXClass_good_CC.h"
@implementation XZXClass_good_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCVC.dataSource = self;
    self.CustomerCVC.delegate   = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.CustomerCVC.scrollEnabled = false;
    self.CustomerCVC.backgroundColor = kBackgroundColor;
    [self.CustomerCVC registerNib:[UINib nibWithNibName:@"XZXClass_good_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXClass_good_CCID"];
}

- (NSMutableArray *)GoodModel_dataSource{
    if (!_GoodModel_dataSource) {
        _GoodModel_dataSource = [NSMutableArray array];
    }
    return _GoodModel_dataSource;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.GoodModel_dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXClass_good_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXClass_good_CCID" forIndexPath:indexPath];
    cell.Model = self.GoodModel_dataSource[indexPath.item];
  
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth-30)/2, (kScreenWidth-20)/2+105);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(EntergoodsDetailVC:)]) {
        
        [self.delegate EntergoodsDetailVC:self.GoodModel_dataSource[indexPath.row]];
    }
}

@end
