//
//  XZXReturnAfterSaleSelectImageTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXReturnAfterSaleSelectImageTVC.h"
#import "XZXMine_AboutMe_TeamCell.h"
#import "XZXMine_EnterStore_SelectPic.h"
@implementation XZXReturnAfterSaleSelectImageTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //图片选择
    self.CustomerCollectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    self.CustomerCollectionView.delegate = self;
    self.CustomerCollectionView.dataSource = self;
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXMine_AboutMe_TeamCell" bundle:nil] forCellWithReuseIdentifier:@"XZXMine_AboutMe_TeamCellID"];
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXMine_EnterStore_SelectPic" bundle:nil] forCellWithReuseIdentifier:@"XZXMine_EnterStore_SelectPicID"];
    
    self.CustomerCollectionView.showsVerticalScrollIndicator = YES;
    self.CustomerCollectionView.bounces = false;
    self.CustomerCollectionView.showsHorizontalScrollIndicator = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSMutableArray *)dataArray_Pic{
    if (!_dataArray_Pic) {
        _dataArray_Pic = [NSMutableArray array];
    }
    return _dataArray_Pic;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray_Pic.count;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10.0;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.CustomerCollectionView.frame.size.width-20)/3.0, 90);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   if (indexPath.item == 0) {
            
            XZXMine_AboutMe_TeamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXMine_AboutMe_TeamCellID" forIndexPath:indexPath];
            cell.HeadImage.image = self.dataArray_Pic[indexPath.row];
            cell.backgroundColor = kBackgroundColor;
            
            return cell;
   }else{
        
        XZXMine_EnterStore_SelectPic *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXMine_EnterStore_SelectPicID" forIndexPath:indexPath];
        
        cell.PicImage.image = self.dataArray_Pic[indexPath.row];
        
        cell.backgroundColor = kBackgroundColor;
        cell.DelectImageBtn.hidden = false;
        cell.DelectPicBlock = ^(XZXMine_EnterStore_SelectPic * _Nonnull CellBlock) {
            
            NSIndexPath *IndexBlock = [self.CustomerCollectionView indexPathForCell:CellBlock];
            [self.dataArray_Pic removeObjectAtIndex:IndexBlock.item];
            [self.CustomerCollectionView reloadData];
        };
        return cell;
   }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        
        XZXReturnAfterSaleSelectImageTVC *cell = (XZXReturnAfterSaleSelectImageTVC *)[[collectionView superview] superview];
        if (self.dataArray_Pic.count < 4) {
            
            if ([self.delegate respondsToSelector:@selector(GetPhont_XZXReturnAfterSaleSelectImageTVCDelegate:)]) {
                [self.delegate GetPhont_XZXReturnAfterSaleSelectImageTVCDelegate:cell];
            }
        }
    }
}

@end
