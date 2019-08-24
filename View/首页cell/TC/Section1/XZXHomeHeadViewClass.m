//
//  XZXHomeHeadViewClass.m
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeHeadViewClass.h"
#import "XZXHome_ClassCC.h"

#import "XZXHome_classModel.h"


@implementation XZXHomeHeadViewClass


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
 
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
       
    }
    return _dataArray;
}
-(void)RefreshUI{
    
    
    [self.CustomerCollecell reloadData];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //CGRect titleSize = [((XZXHome_classModel *)self.dataArray[indexPath.item]).gcName boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    
    CGSize titleSize = [((XZXHome_classModel *)self.dataArray[indexPath.item]).gcName sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    return CGSizeMake(titleSize.width+20,45);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXHome_ClassCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXHome_ClassCCID" forIndexPath:indexPath];
    XZXHome_classModel *model = self.dataArray[indexPath.item];
    cell.title.text = model.gcName;
    
    cell.title.textColor = [UIColor whiteColor];
    if (self.Current_class == indexPath.item) {
        
        
        cell.bottomLine.backgroundColor = [UIColor whiteColor];
    }else{
        
        cell.bottomLine.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(DidselectClass:)]) {
        self.Current_class = indexPath.item;
        [self.delegate DidselectClass:indexPath.item];
    }
}


- (IBAction)MoreClass_Action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DidselectMoreClass)]) {
        
        [self.delegate DidselectMoreClass];
    }else if ([self.delegate respondsToSelector:@selector(DidSelectPrice:)]){
        
        [self.delegate DidSelectPrice:sender];
    }
}
@end
