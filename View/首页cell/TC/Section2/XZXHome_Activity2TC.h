//
//  XZXHome_Activity2TC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXHome_Activity2TCDelegate <NSObject>

-(void)DidselectActivity2:(NSInteger )item;

@end

@interface XZXHome_Activity2TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)   id <XZXHome_Activity2TCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
