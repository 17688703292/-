//
//  XZX_GoodList_MSHeadViewTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN



@protocol XZX_GoodList_MSHeadViewTVCDelegate <NSObject>

-(void)DidselectMSTime:(NSInteger )item;

@end


@interface XZX_GoodList_MSHeadViewTVC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,assign) NSInteger currentTime_t;
@property (nonatomic,weak)   id <XZX_GoodList_MSHeadViewTVCDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
