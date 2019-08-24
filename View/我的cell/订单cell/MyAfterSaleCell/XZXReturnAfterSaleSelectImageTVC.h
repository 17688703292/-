//
//  XZXReturnAfterSaleSelectImageTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XZXReturnAfterSaleSelectImageTVC;
@protocol XZXReturnAfterSaleSelectImageTVCDelegate <NSObject>

-(void)GetPhont_XZXReturnAfterSaleSelectImageTVCDelegate:(XZXReturnAfterSaleSelectImageTVC *)cell;

@end

@interface XZXReturnAfterSaleSelectImageTVC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray_Pic;
@property (nonatomic,weak)id <XZXReturnAfterSaleSelectImageTVCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
