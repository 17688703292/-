//
//  XZXShopGoodSelectWeight.m
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopGoodSelectWeight.h"
#import "XZXShopGoodSelectWeight2.h"


@implementation XZXShopGoodSelectWeight

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectWeight2" bundle:nil] forCellWithReuseIdentifier:@"XZXShopGoodSelectWeight2ID"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.CustomerCollectionView.collectionViewLayout = layout;


}

-(NSMutableArray *)GuigeArray{
    if (!_GuigeArray) {
        
        _GuigeArray = [NSMutableArray array];
    }
    return _GuigeArray;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXShopGoodSelectWeight2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXShopGoodSelectWeight2ID" forIndexPath:indexPath];
    XZXShopGoodSelectGuiGeModel *MyModel = [self.dataSource objectAtIndex:indexPath.row];

    cell.WeightName.text = MyModel.spValueName;
    if (MyModel.status == 1) {
        
        cell.WeightName.backgroundColor = kThemeColor;
    }else{
        cell.WeightName.backgroundColor = [UIColor lightGrayColor];
        //cell.WeightName.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0  blue:231/255.0  alpha:1];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    XZXShopGoodSelectGuiGeModel *MyModel = [self.dataSource objectAtIndex:indexPath.row];
    CGFloat width = [MyModel.spValueName xh_widthWithFont:[UIFont systemFontOfSize:15.0] constrainedToHeight:30];
    return CGSizeMake(width + 20, 40);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    

    if ([self.SelectWeightdelegate respondsToSelector:@selector(didSelectGuigeDataSource:tableviewcell:)]) {
        [self.SelectWeightdelegate didSelectGuigeDataSource:self.dataSource[indexPath.item] tableviewcell:((XZXShopGoodSelectWeight *)[[collectionView superview] superview])];
    }
    
    for (NSInteger j = 0; j< self.dataSource.count; j++) {
        
         XZXShopGoodSelectGuiGeModel *MyModel = [self.dataSource objectAtIndex:j];
        if (indexPath.item == j) {
            
            MyModel.status = 1;
        }else{
            
            MyModel.status = 0;
        }
    }
    
    [self.CustomerCollectionView reloadData];
}
@end
