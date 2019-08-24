//
//  XZXHomeJF4_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeJF4_TC.h"

#import "XZXHomeJF5_CC.h"
@implementation XZXHomeJF4_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    self.CustomerCollectionView.collectionViewLayout = layout;
    self.CustomerCollectionView.scrollEnabled = false;
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHomeJF5_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXHomeJF5_CCID"];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake( (kScreenWidth-20)/3, (kScreenWidth-0)/3 + 45);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XZXHomeJF5_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHomeJF5_CCID" forIndexPath:indexPath];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    [cell.goodImage sd_setImageWithURL:kImageStr([dic valueForKey:@"storeId"], [dic valueForKey:@"goodsImage"]) placeholderImage:[UIImage imageNamed:LoadPic]];
    cell.goodName.text = [dic valueForKey:@"goodsName"];
    if (self.scoreType == 1) {
        
        cell.goodJiFen.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@",[dic valueForKey:@"score"]],@"积分"] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"14.0",@"14.0"]];
    }else{
        
        cell.goodJiFen.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@",[dic valueForKey:@"score"]],@"积分",@" + ",[NSString stringWithFormat:@"¥ %@",[dic valueForKey:@"goodsPromotionPrice"]],@"元"] colorArray:@[kThemeColor,[UIColor lightGrayColor],[UIColor blackColor],kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"14.0",@"14.0",@"13.0",@"14.0",@"14.0"]];
    }
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        if ([self.delegate respondsToSelector:@selector(DidSelectCell:)]) {
    
    
    
            [self.delegate DidSelectCell:[[self.dataArray objectAtIndex:indexPath.item] valueForKey:@"goodsId"]];
        }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}



@end
