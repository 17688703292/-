//
//  XZXHome_Activity_ZYorTG_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_ZYorTG_TC.h"
#import "XZXHome_Activity_ZYorTG_CC.h"
#import "XZXHome_Activity_ZYorTG2_CC.h"

#import "XZXHome_goodModel.h"
@implementation XZXHome_Activity_ZYorTG_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.CustomerCollectionView.dataSource = self;
    self.CustomerCollectionView.delegate   = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.CustomerCollectionView.collectionViewLayout = layout;
    
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHome_Activity_ZYorTG_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_Activity_ZYorTG_CCID"];
    [self.CustomerCollectionView registerNib:[UINib nibWithNibName:@"XZXHome_Activity_ZYorTG2_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXHome_Activity_ZYorTG2_CCID"];
    self.CustomerCollectionView.backgroundColor =  kBackgroundColor;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.index == 1) {
  
        return CGSizeMake( (kScreenWidth-25)/2, (kScreenWidth)/2+65);
    }else if(self.index == 2){
        
        NSInteger num = is_iPhone5 == YES ? 3 : 4;
        return CGSizeMake( (kScreenWidth-35)/num, (kScreenWidth-35)/num + 65);
    }
    return CGSizeMake(0, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
 
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.index == 1) {
     
        return self.dataArray.count > 2 ? 2:self.dataArray.count;
    }else{
        if (self.dataArray.count > 6) {
            
             return 4;
        }else if(self.dataArray.count > 2){
         
             return self.dataArray.count - 2;
        }else{
            
            return 0;
        }
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.index == 1) {
        XZXHome_Activity_ZYorTG_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_Activity_ZYorTG_CCID" forIndexPath:indexPath];
        XZXHome_goodModel  *model = self.dataArray[indexPath.item];
        cell.MyModel = model;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        XZXHome_Activity_ZYorTG2_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_Activity_ZYorTG2_CCID" forIndexPath:indexPath];
        XZXHome_goodModel  *model = self.dataArray[indexPath.item+2];
        cell.MyModel = model;
        cell.backgroundColor = [UIColor whiteColor];
       // cell.backgroundColor = [UIColor hexStringToColor:@"f1f3f4"];
        return cell;
        
    }
   
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectActivityClass_TG_ZY:type:)]) {
        
        if (self.index == 1) {
        
            [self.delegate DidselectActivityClass_TG_ZY:indexPath.item type:self.type_str];
        }else{
        
            [self.delegate DidselectActivityClass_TG_ZY:indexPath.item+2 type:self.type_str];
        }
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
@end
