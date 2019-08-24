//
//  XZXHomejifen_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXHomejifen_TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
