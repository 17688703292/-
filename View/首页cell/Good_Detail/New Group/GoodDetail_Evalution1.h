//
//  GoodDetail_Evalution1.h
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopGoodEvalution_ListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodDetail_Evalution1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodRate;
@property (weak, nonatomic) IBOutlet UILabel *Bad;
@property (weak, nonatomic) IBOutlet UILabel *Average;
@property (weak, nonatomic) IBOutlet UILabel *good;

@property (nonatomic,strong)XZXShopGoodEvalution_ListModel *MyModel;
@end

NS_ASSUME_NONNULL_END
