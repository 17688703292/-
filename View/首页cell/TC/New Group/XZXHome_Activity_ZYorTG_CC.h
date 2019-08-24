//
//  XZXHome_Activity_ZYorTG_CC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_Activity_ZYorTG_CC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *tagStr;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (nonatomic,strong)XZXHome_goodModel *MyModel;
@end

NS_ASSUME_NONNULL_END
