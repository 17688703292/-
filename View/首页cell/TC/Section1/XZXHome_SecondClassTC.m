//
//  XZXHome_SecondClassTC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_SecondClassTC.h"
#import "XZXMineOrder2_CC.h"

#import "XZXClass_rightModel.h"

@implementation XZXHome_SecondClassTC


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
    self.CustomerCollView.dataSource = self;
    self.CustomerCollView.delegate   = self;
    [self.CustomerCollView.collectionViewLayout invalidateLayout];
    [self.CustomerCollView registerNib:[UINib nibWithNibName:@"XZXMineOrder2_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXMineOrder2_CCID"];
    [self.CustomerCollView reloadData];

}

-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXMineOrder2_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXMineOrder2_CCID" forIndexPath:indexPath];
    XZXClass_rightModel *model = [self.dataSource objectAtIndex:indexPath.item];
    [cell.headImage sd_setImageWithURL:kImageUrl(@"", model.gcThumb) placeholderImage:[UIImage imageNamed:LoadPic]];
    cell.headtitle.text  = model.gcName;
    cell.headImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.headImage.clipsToBounds = YES;
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((kScreenWidth/4*0.7 + 20),(kScreenWidth/4*0.7 + 20));
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.didSelectSecondClassAtIndexPathBlock) {
        self.didSelectSecondClassAtIndexPathBlock(indexPath);
    }
}


@end
