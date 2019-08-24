//
//  XZXStore_ActivityClassTC.h
//  BigMarket
//
//  Created by RedSky on 2019/6/3.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXStore_ActivityClassTCDelegate <NSObject>

-(void)DidselectActivityClass:(NSInteger )item;

@end

@interface XZXStore_ActivityClassTC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger SelectIndex;
@property (nonatomic,weak)   id <XZXStore_ActivityClassTCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
