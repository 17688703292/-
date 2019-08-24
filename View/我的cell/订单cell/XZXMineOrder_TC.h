//
//  XZXMineOrder_TC.h
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineOrder_TCModel : NSObject <NSObject>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) NSString *ImageName;
@property (nonatomic,copy) NSString *TitleName;

@end


@interface XZXMineOrder_TC : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) XZXMineOrder_TCModel *model;


@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollView;

@property (nonatomic,copy)void (^didSelectItemAtIndexPathBlock)(NSIndexPath *indexPathBlock);

@property (nonatomic,assign) NSInteger Signal_num;//一排N个cell
@end

NS_ASSUME_NONNULL_END
