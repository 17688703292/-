//
//  XZXHomeremai_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/8/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeremai_TC.h"
#import "XZXHomeremai_CC.h"

#import "XZXHome_goodModel.h"

@implementation XZXHomeremai_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // Initialization code
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    //    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    self.CustomerCollectionView.collectionViewLayout = layout;
    self.CustomerCollectionView.scrollEnabled = false;
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHomeremai_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXHomeremai_CCID"];
    
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
    
    
    return CGSizeMake( (kScreenWidth-30)/2, (kScreenWidth*0.48-10)/2.0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XZXHomeremai_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHomeremai_CCID" forIndexPath:indexPath];
    
    XZXHome_goodModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.goodImage sd_setImageWithURL:kImageUrl(model.storeId, model.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    cell.goodName.text = model.goodsName;
      cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@\n",model.goodsPrice],[NSString stringWithFormat:@"积分：%@",model.score]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"14.0",@"14.0"]];
    
//    [cell.goodImage sd_setImageWithURL:kImageStr([dic valueForKey:@"storeId"], [dic valueForKey:@"goodsImage"]) placeholderImage:[UIImage imageNamed:LoadPic]];
//    cell.goodName.text = [dic valueForKey:@"goodsName"];
//    cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@\n",[dic valueForKey:@"goodsPrice"]],[NSString stringWithFormat:@"积分：%@",[dic valueForKey:@"score"]]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"14.0",@"14.0"]];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidSelect_XZXHomeremai_TC:)]) {
        
        
         XZXHome_goodModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [self.delegate DidSelect_XZXHomeremai_TC:model.goodsId];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

@end
