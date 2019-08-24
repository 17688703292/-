//
//  XZXHomeHeadViewClass.h
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@protocol XZXHomeHeadViewClasslDelegate <NSObject>

-(void)DidselectClass:(NSInteger )item;
-(void)DidselectMoreClass;//首页-选择更多分类
-(void)DidSelectPrice:(UIButton *)sender;//店铺-价格筛选
@end

@interface XZXHomeHeadViewClass : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *MoreClassBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollecell;
- (IBAction)MoreClass_Action:(id)sender;


@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger Current_class;
@property (nonatomic,weak)   id <XZXHomeHeadViewClasslDelegate>delegate;

-(void)RefreshUI;
@end

NS_ASSUME_NONNULL_END
