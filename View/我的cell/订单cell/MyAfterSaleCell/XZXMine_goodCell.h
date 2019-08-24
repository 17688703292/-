//
//  XZXMine_goodCell.h
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXMineOrderGoodDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_goodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodContent;

@property (nonatomic,strong)XZXMineOrderGoodDetailModel *MyModel;
@end

NS_ASSUME_NONNULL_END
