//
//  XZXHome_Activity_ZC2TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_ZC2TC.h"
#import "XZXHome_Activity_ZCCC.h"

@implementation XZXHome_Activity_ZC2TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.CustomerCollectionView.collectionViewLayout = layout;
    
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHome_Activity_ZCCC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_Activity_ZCCCID"];
    self.CustomerCollectionView.backgroundColor =  kBackgroundColor;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
     
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake( (kScreenWidth-25)/2, (kScreenWidth-25)/2*0.8);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
        if (self.dataArray.count > 1) {
            
            return 2;
        }else{
            
            return self.dataArray.count;
        }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

        XZXHome_Activity_ZCCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_Activity_ZCCCID" forIndexPath:indexPath];
    
        cell.backgroundColor = [UIColor colorWithRed:254/255.0 green:249/255.0 blue:242.0/255.0 alpha:1];
        // cell.backgroundColor = [UIColor hexStringToColor:@"f1f3f4"];
        cell.MyModel = [self.dataArray objectAtIndex:indexPath.item];
        return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectActivityClass_ZC:)]) {
        
      
        
        [self.delegate DidselectActivityClass_ZC:indexPath.item];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
@end
