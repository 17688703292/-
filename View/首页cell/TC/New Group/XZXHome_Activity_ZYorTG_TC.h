//
//  XZXHome_Activity_ZYorTG_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXHome_Activity_ZYorTG_TCDelegate <NSObject>

-(void)DidselectActivityClass_TG_ZY:(NSInteger )item type:(NSString *)type_str;

@end

@interface XZXHome_Activity_ZYorTG_TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger index;//第2行/第三行

@property (nonatomic,copy)NSString *type_str;

@property (nonatomic,weak)   id <XZXHome_Activity_ZYorTG_TCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
