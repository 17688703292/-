//
//  XZXClass_good_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class XZXClass_two_good_Model;

@protocol XZXClass_good_TCDelegate<NSObject>

-(void)EntergoodsDetailVC:(XZXClass_two_good_Model *)model;
@end

@interface XZXClass_good_TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCVC;

@property (nonatomic,strong) NSMutableArray *GoodModel_dataSource;

@property (nonatomic,weak) id <XZXClass_good_TCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
