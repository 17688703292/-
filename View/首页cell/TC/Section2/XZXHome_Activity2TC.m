//
//  XZXHome_Activity2TC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity2TC.h"
#import "XZXHome_Activity2_CC.h"

#import "XZXHome_activityModel.h"

@implementation XZXHome_Activity2TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.CustomerCollectionView.collectionViewLayout = layout;
    self.CustomerCollectionView.bounces = false;
    
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHome_Activity2_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_Activity2_CCID"];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    return CGSizeMake((kScreenWidth-20)/3,(kScreenWidth-20)/3);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXHome_Activity2_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_Activity2_CCID" forIndexPath:indexPath];
    XZXHome_activityModel *model = self.dataArray[indexPath.item];
    
    [cell.headImage sd_setImageWithURL:kImageUrl(@"",model.activityImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    
    switch (indexPath.item%4) {
        case 0:
            {
                cell.backgroundColor = [UIColor hexStringToColor:@"ebf2ff"];
            }
            break;
        case 1:
        {
             cell.backgroundColor = [UIColor hexStringToColor:@"effdf8"];
        }
            break;
        case 2:
        {
             cell.backgroundColor = [UIColor hexStringToColor:@"feffef"];
        }
            break;
        case 3:
        {
             cell.backgroundColor = [UIColor hexStringToColor:@"fff3f1"];
        }
        default:
            break;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectActivity2:)]) {
        
        [self.delegate DidselectActivity2:indexPath.item];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
@end
