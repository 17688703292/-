//
//  XZXMineSignCell2.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXMineSign_dayModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol XZXMineSignCell2Delegate <NSObject>

-(void)DidSelectSigna:(NSInteger )item;

@end

@class XZXMineSign_dayModel;

@interface XZXMineSignCell2 : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (nonatomic,strong)NSMutableArray  *GoodModel_dataSource;
@property (nonatomic,weak)id<XZXMineSignCell2Delegate>delegate;

@end

NS_ASSUME_NONNULL_END
