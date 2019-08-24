//
//  XZXHome_Activity_ZC2TC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_goodListModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol XZXHome_Activity_ZC2TCDelegate <NSObject>

-(void)DidselectActivityClass_ZC:(NSInteger )item;

@end

@interface XZXHome_Activity_ZC2TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)   id <XZXHome_Activity_ZC2TCDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
