//
//  XZX_GoodList_MSHeadViewTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_MSHeadViewTVC.h"
#import "XZX_GoodList_MSHeadViewCC.h"

@implementation XZX_GoodList_MSHeadViewTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.CustomerCollectionView.collectionViewLayout = layout;
    
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZX_GoodList_MSHeadViewCC" bundle:nil] forCellWithReuseIdentifier:@"XZX_GoodList_MSHeadViewCCID"];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(kScreenWidth/4.5,kScreenWidth/4.5*0.75);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    XZX_GoodList_MSHeadViewCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZX_GoodList_MSHeadViewCCID" forIndexPath:indexPath];
    
    
        
        if ([XHTools dateRemaining:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"spikeTime"]] > 0) {
            
         
         
              cell.Content.text = [NSString stringWithFormat:@"%@\n即将开始",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"spikeTime"]];
        }else{
            
            
            if (-[XHTools dateRemaining:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"spikeTime"]] < [[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"spikeLasttime"] integerValue]*60) {
                
                
                cell.Content.text = [NSString stringWithFormat:@"%@\n抢购中",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"spikeTime"]];
                
            }else{
                
                     cell.Content.text = [NSString stringWithFormat:@"%@\n已结束",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"spikeTime"]];
            }
            
        }
        

    
    if (self.currentTime_t == indexPath.item) {
        
        cell.BackImage.image = [UIImage imageNamed:@"MS_down"];
    }else{
        cell.BackImage.image = [UIImage new];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectMSTime:)]) {
        
        [self.delegate DidselectMSTime:indexPath.item];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

@end
