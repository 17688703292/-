//
//  XZXShopEvalution_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopGoodEvalution_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXShopEvalution_TC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *BackImage;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic,strong)XZXShopGoodEvalution_Model *MyModel;
@end

NS_ASSUME_NONNULL_END
