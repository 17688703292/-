//
//  XZXHome_Activity_MSTC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXHome_Activity_MSTCDelegate <NSObject>

-(void)DidselectActivityClass_MS:(NSInteger )item;

@end

@interface XZXHome_Activity_MSTC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)   id <XZXHome_Activity_MSTCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
