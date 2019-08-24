//
//  XZXShopGoodTypeHeadCell.h
//  DoorLock
//
//  Created by RedSky on 2019/3/4.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXShopGoodTypeHeadCell : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;

@property (nonatomic,assign) NSInteger selectGoodType;
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,copy) void(^selectGoodTypeBlock)(NSInteger electGoodType_t);
@end

NS_ASSUME_NONNULL_END
