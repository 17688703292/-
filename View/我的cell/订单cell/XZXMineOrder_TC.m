//
//  XZXMineOrder_TC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMineOrder_TC.h"
#import "XZXMineOrder2_CC.h"
@implementation XZXMineOrder_TCModel
@end


@implementation XZXMineOrder_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollView.cornerRadius = 10.0;
    self.CustomerCollView.dataSource = self;
    self.CustomerCollView.delegate   = self;
    [self.CustomerCollView.collectionViewLayout invalidateLayout];
    [self.CustomerCollView registerNib:[UINib nibWithNibName:@"XZXMineOrder2_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXMineOrder2_CCID"];
    [self.CustomerCollView reloadData];
    
    
    self.model = [XZXMineOrder_TCModel new];
    self.model.dataSource = [NSMutableArray array];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    

    return self.model.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXMineOrder2_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXMineOrder2_CCID" forIndexPath:indexPath];
    cell.headImage.image = [UIImage imageNamed:[[self.model.dataSource objectAtIndex:indexPath.item] valueForKey:@"HeadImage"]];
    cell.headtitle.text  = [[self.model.dataSource objectAtIndex:indexPath.item] valueForKey:@"HeadTitle"];
    if ([[[self.model.dataSource objectAtIndex:indexPath.item] allKeys] containsObject:@"num"]) {
        
        cell.num.hidden = false;
        if ([[[self.model.dataSource objectAtIndex:indexPath.item] valueForKey:@"num"] integerValue] == 0) {
            
            
            cell.num.hidden = true;
        }else{
            
            cell.num.text = [[[self.model.dataSource objectAtIndex:indexPath.item] valueForKey:@"num"] integerValue] > 99 ? @"99+":[[self.model.dataSource objectAtIndex:indexPath.item] valueForKey:@"num"];
            cell.num.hidden = false;
        }
    }else{
        
        cell.num.hidden = YES;
    }
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((kScreenWidth-20)/self.Signal_num,kScreenWidth/self.Signal_num*0.7 + 10 );
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(indexPath);
    }
}


@end
