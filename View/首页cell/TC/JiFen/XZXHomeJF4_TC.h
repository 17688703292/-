//
//  XZXHomeJF4_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XZXHomeJF4Delegate <NSObject>

-(void)DidSelectCell:(NSString *)goodsId;

@end

@interface XZXHomeJF4_TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;

@property (nonatomic,assign) NSInteger scoreType;//1积分兑，2积分购
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,weak) id<XZXHomeJF4Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
