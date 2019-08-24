//
//  XZXHome_ActivityClassTC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXHome_ActivityClassTCDelegate <NSObject>

-(void)DidselectActivityClass:(NSInteger )item;

@end

@interface XZXHome_ActivityClassTC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomeCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger SelectIndex;
@property (nonatomic,weak)   id <XZXHome_ActivityClassTCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
