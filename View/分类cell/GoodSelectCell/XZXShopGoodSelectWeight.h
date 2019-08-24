//
//  XZXShopGoodSelectWeight.h
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopGoodSelectGuiGeModel.h"
@class XZXShopGoodSelectWeight;

@protocol XZXShopGoodSelectWeightDelegate<NSObject>
/**
   index  分类规格下标
   GuigeDataModel 具体规格模型
 
 **/
-(void)didSelectGuigeDataSource:(XZXShopGoodSelectGuiGeModel *)GuigeDataModel tableviewcell:(XZXShopGoodSelectWeight *)cell;
@end

@interface XZXShopGoodSelectWeight : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CustomerCollectionView;



@property (nonatomic,weak) id<XZXShopGoodSelectWeightDelegate>SelectWeightdelegate;
@property (nonatomic,strong) NSMutableArray *dataSource;//可选择的规格列表
@property (nonatomic,strong) NSMutableArray *GuigeArray;//选中的规格列表




@end
