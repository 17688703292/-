//
//  XZXShopGoodTypeHeadCell.m
//  DoorLock
//
//  Created by RedSky on 2019/3/4.
//  Copyright © 2019 RedSky. All rights reserved.
//


#import "XZXShopGoodTypeHeadCell.h"

#import "XZXShopGoodTypeCollecCell.h"

#import "XZXClass_two_Model.h"

@implementation XZXShopGoodTypeHeadCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXShopGoodTypeCollecCell" bundle:nil] forCellWithReuseIdentifier:@"XZXShopGoodTypeCollecCellID"];

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    XZXClass_two_Model *model = self.dataSource[indexPath.item];
    
    CGSize titleSize = [model.gcName sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    return CGSizeMake(titleSize.width+40,60);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXShopGoodTypeCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXShopGoodTypeCollecCellID" forIndexPath:indexPath];
    XZXClass_two_Model *model = self.dataSource[indexPath.item];
    cell.Title.text = model.gcName;
    
    if (self.selectGoodType != indexPath.item) {
        
        [cell.Title setTextColor:[UIColor blackColor]];
        cell.Title.backgroundColor = [UIColor clearColor];
    }else{
        
        [cell.Title setTextColor:[UIColor whiteColor]];
        cell.Title.backgroundColor = kThemeColor;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    self.selectGoodType = indexPath.item;
    
    if (self.selectGoodTypeBlock) {
    
        self.selectGoodTypeBlock(self.selectGoodType);
    }
}

@end
