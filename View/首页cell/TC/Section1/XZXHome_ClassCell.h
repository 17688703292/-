//
//  XZXHome_ClassCell.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XZXHome_ClassCellDelegate <NSObject>

-(void)DidselectClass:(NSInteger )item;
-(void)DidselectMoreClass;//首页-选择更多分类
-(void)DidSelectPrice:(UIButton *)sender;//店铺-价格筛选
@end

@interface XZXHome_ClassCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollecell;
@property (weak, nonatomic) IBOutlet UIButton *MoreClassBtn;
- (IBAction)MoreClass_Action:(id)sender;


@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger Current_class;
@property (nonatomic,weak)   id <XZXHome_ClassCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
