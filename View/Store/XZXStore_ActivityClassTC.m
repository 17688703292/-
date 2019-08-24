//
//  XZXStore_ActivityClassTC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/3.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXStore_ActivityClassTC.h"


#import "XZXHome_ActivityClassCC.h"
#import "XZXStore_ActityCC.h"

#import "XZXHome_activityModel.h"

@implementation XZXStore_ActivityClassTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.CustomerCollectionView.collectionViewLayout = layout;
    
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHome_ActivityClassCC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_ActivityClassCCID"];
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXStore_ActityCC" bundle:nil] forCellWithReuseIdentifier:@"XZXStore_ActityCCID"];
    
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/4,kScreenWidth/4 + 20);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    XZXHome_activityModel *model = self.dataArray[indexPath.item];
    
    if ([model.activityImage containsString:@"jpg"] ||
        [model.activityImage containsString:@"png"]) {
        XZXHome_ActivityClassCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_ActivityClassCCID" forIndexPath:indexPath];
        [cell.HeadImage sd_setImageWithURL:kImageUrl(@"",model.activityImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.title.text = model.activityName;
        return cell;
    }else{
        
        XZXStore_ActityCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXStore_ActityCCID" forIndexPath:indexPath];
        if (self.SelectIndex-1 == indexPath.item) {
            
            cell.headImage.image = [UIImage imageNamed:model.activitySelectImage];
            cell.title.textColor = kThemeColor;
        }else
        {
            
            cell.headImage.image = [UIImage imageNamed:model.activityImage];
            cell.title.textColor = [UIColor lightGrayColor];
        }
        cell.headImage.contentMode  = UIViewContentModeCenter;
        cell.title.text = model.activityName;
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectActivityClass:)]) {
        
        [self.delegate DidselectActivityClass:indexPath.item];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
@end
