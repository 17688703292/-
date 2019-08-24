//
//  XZXHome_SecondClassTC.h
//  BigMarket
//
//  Created by RedSky on 2019/6/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface XZXHome_SecondClassTC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollView;

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,copy)void (^didSelectSecondClassAtIndexPathBlock)(NSIndexPath *indexPathBlock);

@property (nonatomic,assign) NSInteger Signal_num;//一排N个cell
@end

NS_ASSUME_NONNULL_END
