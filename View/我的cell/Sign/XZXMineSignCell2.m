//
//  XZXMineSignCell2.m
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineSignCell2.h"
#import "XZXMineSignCell3.h"

@class XZXMineSign_dayModel;
@implementation XZXMineSignCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    
    
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXMineSignCell3" bundle:nil] forCellWithReuseIdentifier:@"XZXMineSignCell3ID"];

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
    
    XZXMineSignCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXMineSignCell3ID" forIndexPath:indexPath];
    
    XZXMineSign_dayModel *model = self.GoodModel_dataSource[indexPath.row];
    
    cell.date.text = model.dayTime;
    
    cell.score.adjustsFontSizeToFitWidth = YES;
    if (model.isSign == 0) {
        
        cell.selectImage.image = [UIImage new];
        cell.otherimage.backgroundColor = [UIColor colorWithRed:208/255.0 green:46/255.0 blue:51/255.0 alpha:1];
        cell.score.text = [NSString stringWithFormat:@"+%@",model.score];
    }else{
        
        cell.score.text = @"";
        cell.selectImage.image = [UIImage imageNamed:@"qiandao"];
        cell.otherimage.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num = is_iPhone5 ? 5 : 7;
    return CGSizeMake(kScreenWidth/num, 75);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(DidSelectSigna:)]) {
        
        [self.delegate DidSelectSigna:indexPath.item];
    }
}


@end
